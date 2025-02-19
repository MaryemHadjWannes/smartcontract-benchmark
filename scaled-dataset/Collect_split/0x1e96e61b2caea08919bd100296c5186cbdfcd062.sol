// SPDX-License-Identifier: MIT



pragma solidity ^0.8.0;



contract Ownable {

    address public owner;



    event OwnershipTransferred(

        address indexed previousOwner,

        address indexed newOwner

    );



    constructor() {

        owner = msg.sender;

    }



    /**

     * @dev Throws if called by any account other than the owner.

     */

    modifier onlyOwner() {

        require(msg.sender == owner, 'Ownable: caller is not the owner');

        _;

    }



    /**

     * @dev Leaves the contract without owner. It will not be possible to call

     * `onlyOwner` functions anymore. Can only be called by the current owner.

     *

     * NOTE: Renouncing ownership will leave the contract without an owner,

     * thereby removing any functionality that is only available to the owner.

     */

    function renounceOwnership() public onlyOwner {

        emit OwnershipTransferred(owner, address(0));

        owner = address(0);

    }



    /**

     * @dev Transfers ownership of the contract to a new account (`newOwner`).

     * Can only be called by the current owner.

     */

    function transferOwnership(address newOwner) public onlyOwner {

        _transferOwnership(newOwner);

    }



    /**

     * @dev Transfers ownership of the contract to a new account (`newOwner`).

     */

    function _transferOwnership(address newOwner) internal {

        require(

            newOwner != address(0),

            'Ownable: new owner is the zero address'

        );

        emit OwnershipTransferred(owner, newOwner);

        owner = newOwner;

    }

}



interface IERC20 {

    function totalSupply() external view returns (uint256);



    function balanceOf(address account) external view returns (uint256);



    function transfer(address recipient, uint256 amount)

        external

        returns (bool);



    function allowance(address owner, address spender)

        external

        view

        returns (uint256);



    function approve(address spender, uint256 amount) external returns (bool);



    function transferFrom(

        address sender,

        address recipient,

        uint256 amount

    ) external returns (bool);



    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(

        address indexed owner,

        address indexed spender,

        uint256 value

    );

}



contract Wrapper {

    uint256 public totalSupply;



    mapping(address => uint256) private _balances;

    IERC20 public stakedToken;



    event Staked(address indexed user, uint256 amount);

    event Withdrawn(address indexed user, uint256 amount);



    function balanceOf(address account) public view returns (uint256) {

        return _balances[account];

    }



    string constant _transferErrorMessage = 'Staked token transfer failed';



    function stakeFor(address forWhom, uint128 amount) public payable virtual {

        IERC20 st = stakedToken;

        if (st == IERC20(address(0))) {

            unchecked {

                totalSupply += msg.value;

                _balances[forWhom] += msg.value;

            }

        } else {

            require(msg.value == 0, 'Non-zero eth');

            require(amount > 0, 'Cannot stake 0');

            require(

                st.transferFrom(msg.sender, address(this), amount),

                _transferErrorMessage

            );

            unchecked {

                totalSupply += amount;

                _balances[forWhom] += amount;

            }

        }

        emit Staked(forWhom, amount);

    }



    function withdraw(uint128 amount) public virtual {

        require(amount <= _balances[msg.sender], 'You cannot withdraw more tokens than you have staked.');

        unchecked {

            _balances[msg.sender] -= amount;

            totalSupply = totalSupply - amount;

        }

        IERC20 st = stakedToken;

        if (st == IERC20(address(0))) {

            (bool success, ) = msg.sender.call{ value: amount }('');

            require(success, 'ETH transfer failure');

        } else {

            require(

                stakedToken.transfer(msg.sender, amount),

                _transferErrorMessage

            );

        }

        emit Withdrawn(msg.sender, amount);

    }

}



contract TokenStaking is Wrapper, Ownable {

    IERC20 public rewardToken;

    uint256 public rewardRate;

    uint64 public periodFinish;

    uint64 public lastUpdateTime;

    uint128 public rewardPerTokenStored;

    struct UserRewards {

        uint128 userRewardPerTokenPaid;

        uint128 rewards;

    }

    mapping(address => UserRewards) public userRewards;



    event RewardAdded(uint256 reward);

    event RewardPaid(address indexed user, uint256 reward);



    constructor(IERC20 _rewardToken, IERC20 _stakedToken) {

        rewardToken = _rewardToken;

        stakedToken = _stakedToken;

    }



    modifier updateReward(address account) {

        uint128 _rewardPerTokenStored = rewardPerToken();

        lastUpdateTime = lastTimeRewardApplicable();

        rewardPerTokenStored = _rewardPerTokenStored;

        userRewards[account].rewards = earned(account);

        userRewards[account].userRewardPerTokenPaid = _rewardPerTokenStored;

        _;

    }



    function lastTimeRewardApplicable() public view returns (uint64) {

        uint64 blockTimestamp = uint64(block.timestamp);

        return blockTimestamp < periodFinish ? blockTimestamp : periodFinish;

    }



    function rewardPerToken() public view returns (uint128) {

        uint256 totalStakedSupply = totalSupply;

        if (totalStakedSupply == 0) {

            return rewardPerTokenStored;

        }

        unchecked {

            uint256 rewardDuration = lastTimeRewardApplicable() - lastUpdateTime;

            return uint128(rewardPerTokenStored + (rewardDuration * rewardRate) / totalStakedSupply);

        }

    }



    // Calculate $HNY rewards earned

    function earned(address account) public view returns (uint128) {

        unchecked {

            return uint128((balanceOf(account) * (rewardPerToken() - userRewards[account].userRewardPerTokenPaid)) / 1e18 + userRewards[account].rewards);

        }

    }



    // Stake LP tokens

    function stake(uint128 amount) external payable {

        stakeFor(msg.sender, amount);

    }



    // Stake LP for an address

    function stakeFor(address forWhom, uint128 amount) public payable override updateReward(forWhom) {

        super.stakeFor(forWhom, amount);

    }



    // Unstake tokens

    function withdraw(uint128 amount) public override updateReward(msg.sender) {

        super.withdraw(amount);

    }



    // Claim rewards and unstake tokens

    function exit() external {

        claimHoney();

        withdraw(uint128(balanceOf(msg.sender)));

    }



    // Claim accumulated $HNY rewards

    function claimHoney() public updateReward(msg.sender) {

        uint256 reward = earned(msg.sender);

        if (reward > 0) {

            userRewards[msg.sender].rewards = 0;

            require(rewardToken.transfer(msg.sender, reward), 'reward transfer failed');

            emit RewardPaid(msg.sender, reward);

        }

    }



    // Set reward limit, reward rate, and duration

    function setRewardParams(uint128 rewardLimit, uint64 duration, uint256 rr) external onlyOwner {

        unchecked {

            require(rewardLimit > 0);

            rewardPerTokenStored = rewardPerToken();

            uint64 blockTimestamp = uint64(block.timestamp);

            uint256 maxRewardSupply = rewardToken.balanceOf(address(this));

            if (rewardToken == stakedToken) maxRewardSupply -= totalSupply;

            uint256 leftover = 0;

            if (blockTimestamp >= periodFinish) {

                rewardRate = rr;

            } else {

                uint256 remaining = periodFinish - blockTimestamp;

                leftover = remaining * rewardRate;

                rewardRate = rr;

            }

            //require(rewardLimit + leftover <= maxRewardSupply, 'There is not enough $HNY in the contract.');

            lastUpdateTime = blockTimestamp;

            periodFinish = blockTimestamp + duration;

            emit RewardAdded(rewardLimit);

        }

    }



    // Withdraw $HNY from the contract

    function withdrawHoney() external onlyOwner {

        uint256 rewardSupply = rewardToken.balanceOf(address(this));

        if (rewardToken == stakedToken) rewardSupply -= totalSupply;

        require(rewardToken.transfer(msg.sender, rewardSupply));

        rewardRate = 0;

        periodFinish = uint64(block.timestamp);

    }





}



/*

   ____            __   __        __   _

  / __/__ __ ___  / /_ / /  ___  / /_ (_)__ __

 _\ \ / // // _ \/ __// _ \/ -_)/ __// / \ \ /

/___/ \_, //_//_/\__//_//_/\__/ \__//_/ /_\_\

     /___/



* Synthetix: YFIRewards.sol

*

* Docs: https://docs.synthetix.io/

*

*

* MIT License

* ===========

*

* Copyright (c) 2020 Synthetix

*

* Permission is hereby granted, free of charge, to any person obtaining a copy

* of this software and associated documentation files (the "Software"), to deal

* in the Software without restriction, including without limitation the rights

* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell

* copies of the Software, and to permit persons to whom the Software is

* furnished to do so, subject to the following conditions:

*

* The above copyright notice and this permission notice shall be included in all

* copies or substantial portions of the Software.

*

* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR

* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,

* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE

* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER

* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,

* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

*/