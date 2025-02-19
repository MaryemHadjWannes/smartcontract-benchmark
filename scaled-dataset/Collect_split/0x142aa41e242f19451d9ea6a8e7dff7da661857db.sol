// File: openzeppelin-solidity/contracts/GSN/Context.sol



pragma solidity ^0.5.0;



/*

 * @dev Provides information about the current execution context, including the

 * sender of the transaction and its data. While these are generally available

 * via msg.sender and msg.data, they should not be accessed in such a direct

 * manner, since when dealing with GSN meta-transactions the account sending and

 * paying for execution may not be the actual sender (as far as an application

 * is concerned).

 *

 * This contract is only required for intermediate, library-like contracts.

 */

contract Context {

    // Empty internal constructor, to prevent people from mistakenly deploying

    // an instance of this contract, which should be used via inheritance.

    constructor () internal { }

    // solhint-disable-previous-line no-empty-blocks



    function _msgSender() internal view returns (address payable) {

        return msg.sender;

    }



    function _msgData() internal view returns (bytes memory) {

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

        return msg.data;

    }

}



// File: openzeppelin-solidity/contracts/access/Roles.sol



pragma solidity ^0.5.0;



/**

 * @title Roles

 * @dev Library for managing addresses assigned to a Role.

 */

library Roles {

    struct Role {

        mapping (address => bool) bearer;

    }



    /**

     * @dev Give an account access to this role.

     */

    function add(Role storage role, address account) internal {

        require(!has(role, account), "Roles: account already has role");

        role.bearer[account] = true;

    }



    /**

     * @dev Remove an account's access to this role.

     */

    function remove(Role storage role, address account) internal {

        require(has(role, account), "Roles: account does not have role");

        role.bearer[account] = false;

    }



    /**

     * @dev Check if an account has this role.

     * @return bool

     */

    function has(Role storage role, address account) internal view returns (bool) {

        require(account != address(0), "Roles: account is the zero address");

        return role.bearer[account];

    }

}



// File: openzeppelin-solidity/contracts/access/roles/PauserRole.sol



pragma solidity ^0.5.0;







contract PauserRole is Context {

    using Roles for Roles.Role;



    event PauserAdded(address indexed account);

    event PauserRemoved(address indexed account);



    Roles.Role private _pausers;



    constructor () internal {

        _addPauser(_msgSender());

    }



    modifier onlyPauser() {

        require(isPauser(_msgSender()), "PauserRole: caller does not have the Pauser role");

        _;

    }



    function isPauser(address account) public view returns (bool) {

        return _pausers.has(account);

    }



    function addPauser(address account) public onlyPauser {

        _addPauser(account);

    }



    function renouncePauser() public {

        _removePauser(_msgSender());

    }



    function _addPauser(address account) internal {

        _pausers.add(account);

        emit PauserAdded(account);

    }



    function _removePauser(address account) internal {

        _pausers.remove(account);

        emit PauserRemoved(account);

    }

}



// File: openzeppelin-solidity/contracts/lifecycle/Pausable.sol



pragma solidity ^0.5.0;







/**

 * @dev Contract module which allows children to implement an emergency stop

 * mechanism that can be triggered by an authorized account.

 *

 * This module is used through inheritance. It will make available the

 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to

 * the functions of your contract. Note that they will not be pausable by

 * simply including this module, only once the modifiers are put in place.

 */

contract Pausable is Context, PauserRole {

    /**

     * @dev Emitted when the pause is triggered by a pauser (`account`).

     */

    event Paused(address account);



    /**

     * @dev Emitted when the pause is lifted by a pauser (`account`).

     */

    event Unpaused(address account);



    bool private _paused;



    /**

     * @dev Initializes the contract in unpaused state. Assigns the Pauser role

     * to the deployer.

     */

    constructor () internal {

        _paused = false;

    }



    /**

     * @dev Returns true if the contract is paused, and false otherwise.

     */

    function paused() public view returns (bool) {

        return _paused;

    }



    /**

     * @dev Modifier to make a function callable only when the contract is not paused.

     */

    modifier whenNotPaused() {

        require(!_paused, "Pausable: paused");

        _;

    }



    /**

     * @dev Modifier to make a function callable only when the contract is paused.

     */

    modifier whenPaused() {

        require(_paused, "Pausable: not paused");

        _;

    }



    /**

     * @dev Called by a pauser to pause, triggers stopped state.

     */

    function pause() public onlyPauser whenNotPaused {

        _paused = true;

        emit Paused(_msgSender());

    }



    /**

     * @dev Called by a pauser to unpause, returns to normal state.

     */

    function unpause() public onlyPauser whenPaused {

        _paused = false;

        emit Unpaused(_msgSender());

    }

}



// File: openzeppelin-solidity/contracts/math/SafeMath.sol



pragma solidity ^0.5.0;



/**

 * @dev Wrappers over Solidity's arithmetic operations with added overflow

 * checks.

 *

 * Arithmetic operations in Solidity wrap on overflow. This can easily result

 * in bugs, because programmers usually assume that an overflow raises an

 * error, which is the standard behavior in high level programming languages.

 * `SafeMath` restores this intuition by reverting the transaction when an

 * operation overflows.

 *

 * Using this library instead of the unchecked operations eliminates an entire

 * class of bugs, so it's recommended to use it always.

 */

library SafeMath {

    /**

     * @dev Returns the addition of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `+` operator.

     *

     * Requirements:

     * - Addition cannot overflow.

     */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        require(c >= a, "SafeMath: addition overflow");



        return c;

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting on

     * overflow (when the result is negative).

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     * - Subtraction cannot overflow.

     */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        return sub(a, b, "SafeMath: subtraction overflow");

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on

     * overflow (when the result is negative).

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     * - Subtraction cannot overflow.

     *

     * _Available since v2.4.0._

     */

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b <= a, errorMessage);

        uint256 c = a - b;



        return c;

    }



    /**

     * @dev Returns the multiplication of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `*` operator.

     *

     * Requirements:

     * - Multiplication cannot overflow.

     */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the

        // benefit is lost if 'b' is also tested.

        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522

        if (a == 0) {

            return 0;

        }



        uint256 c = a * b;

        require(c / a == b, "SafeMath: multiplication overflow");



        return c;

    }



    /**

     * @dev Returns the integer division of two unsigned integers. Reverts on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `/` operator. Note: this function uses a

     * `revert` opcode (which leaves remaining gas untouched) while Solidity

     * uses an invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        return div(a, b, "SafeMath: division by zero");

    }



    /**

     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `/` operator. Note: this function uses a

     * `revert` opcode (which leaves remaining gas untouched) while Solidity

     * uses an invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     *

     * _Available since v2.4.0._

     */

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        // Solidity only automatically asserts when dividing by 0

        require(b > 0, errorMessage);

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold



        return c;

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * Reverts when dividing by zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     */

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {

        return mod(a, b, "SafeMath: modulo by zero");

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * Reverts with custom message when dividing by zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     *

     * _Available since v2.4.0._

     */

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}



// File: openzeppelin-solidity/contracts/token/ERC20/IERC20.sol



pragma solidity ^0.5.0;



/**

 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include

 * the optional functions; to access them see {ERC20Detailed}.

 */

interface IERC20 {

    /**

     * @dev Returns the amount of tokens in existence.

     */

    function totalSupply() external view returns (uint256);



    /**

     * @dev Returns the amount of tokens owned by `account`.

     */

    function balanceOf(address account) external view returns (uint256);



    /**

     * @dev Moves `amount` tokens from the caller's account to `recipient`.

     *

     * Returns a boolean value indicating whether the operation succeeded.

     *

     * Emits a {Transfer} event.

     */

    function transfer(address recipient, uint256 amount) external returns (bool);



    /**

     * @dev Returns the remaining number of tokens that `spender` will be

     * allowed to spend on behalf of `owner` through {transferFrom}. This is

     * zero by default.

     *

     * This value changes when {approve} or {transferFrom} are called.

     */

    function allowance(address owner, address spender) external view returns (uint256);



    /**

     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.

     *

     * Returns a boolean value indicating whether the operation succeeded.

     *

     * IMPORTANT: Beware that changing an allowance with this method brings the risk

     * that someone may use both the old and the new allowance by unfortunate

     * transaction ordering. One possible solution to mitigate this race

     * condition is to first reduce the spender's allowance to 0 and set the

     * desired value afterwards:

     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

     *

     * Emits an {Approval} event.

     */

    function approve(address spender, uint256 amount) external returns (bool);



    /**

     * @dev Moves `amount` tokens from `sender` to `recipient` using the

     * allowance mechanism. `amount` is then deducted from the caller's

     * allowance.

     *

     * Returns a boolean value indicating whether the operation succeeded.

     *

     * Emits a {Transfer} event.

     */

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);



    /**

     * @dev Emitted when `value` tokens are moved from one account (`from`) to

     * another (`to`).

     *

     * Note that `value` may be zero.

     */

    event Transfer(address indexed from, address indexed to, uint256 value);



    /**

     * @dev Emitted when the allowance of a `spender` for an `owner` is set by

     * a call to {approve}. `value` is the new allowance.

     */

    event Approval(address indexed owner, address indexed spender, uint256 value);

}



// File: openzeppelin-solidity/contracts/utils/Address.sol



pragma solidity ^0.5.5;



/**

 * @dev Collection of functions related to the address type

 */

library Address {

    /**

     * @dev Returns true if `account` is a contract.

     *

     * This test is non-exhaustive, and there may be false-negatives: during the

     * execution of a contract's constructor, its address will be reported as

     * not containing a contract.

     *

     * IMPORTANT: It is unsafe to assume that an address for which this

     * function returns false is an externally-owned account (EOA) and not a

     * contract.

     */

    function isContract(address account) internal view returns (bool) {

        // This method relies in extcodesize, which returns 0 for contracts in

        // construction, since the code is only stored at the end of the

        // constructor execution.



        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts

        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned

        // for accounts without code, i.e. `keccak256('')`

        bytes32 codehash;

        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

        // solhint-disable-next-line no-inline-assembly

        assembly { codehash := extcodehash(account) }

        return (codehash != 0x0 && codehash != accountHash);

    }



    /**

     * @dev Converts an `address` into `address payable`. Note that this is

     * simply a type cast: the actual underlying value is not changed.

     *

     * _Available since v2.4.0._

     */

    function toPayable(address account) internal pure returns (address payable) {

        return address(uint160(account));

    }



    /**

     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to

     * `recipient`, forwarding all available gas and reverting on errors.

     *

     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost

     * of certain opcodes, possibly making contracts go over the 2300 gas limit

     * imposed by `transfer`, making them unable to receive funds via

     * `transfer`. {sendValue} removes this limitation.

     *

     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].

     *

     * IMPORTANT: because control is transferred to `recipient`, care must be

     * taken to not create reentrancy vulnerabilities. Consider using

     * {ReentrancyGuard} or the

     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].

     *

     * _Available since v2.4.0._

     */

    function sendValue(address payable recipient, uint256 amount) internal {

        require(address(this).balance >= amount, "Address: insufficient balance");



        // solhint-disable-next-line avoid-call-value

        (bool success, ) = recipient.call.value(amount)("");

        require(success, "Address: unable to send value, recipient may have reverted");

    }

}



// File: openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol



pragma solidity ^0.5.0;









/**

 * @title SafeERC20

 * @dev Wrappers around ERC20 operations that throw on failure (when the token

 * contract returns false). Tokens that return no value (and instead revert or

 * throw on failure) are also supported, non-reverting calls are assumed to be

 * successful.

 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,

 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.

 */

library SafeERC20 {

    using SafeMath for uint256;

    using Address for address;



    function safeTransfer(IERC20 token, address to, uint256 value) internal {

        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));

    }



    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {

        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));

    }



    function safeApprove(IERC20 token, address spender, uint256 value) internal {

        // safeApprove should only be called when setting an initial allowance,

        // or when resetting it to zero. To increase and decrease it, use

        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'

        // solhint-disable-next-line max-line-length

        require((value == 0) || (token.allowance(address(this), spender) == 0),

            "SafeERC20: approve from non-zero to non-zero allowance"

        );

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));

    }



    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).add(value);

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    /**

     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement

     * on the return value: the return value is optional (but if data is returned, it must not be false).

     * @param token The token targeted by the call.

     * @param data The call data (encoded using abi.encode or one of its variants).

     */

    function callOptionalReturn(IERC20 token, bytes memory data) private {

        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since

        // we're implementing it ourselves.



        // A Solidity high level call has three parts:

        //  1. The target address is checked to verify it contains contract code

        //  2. The call itself is made, and success asserted

        //  3. The return value is decoded, which in turn checks the size of the returned data.

        // solhint-disable-next-line max-line-length

        require(address(token).isContract(), "SafeERC20: call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = address(token).call(data);

        require(success, "SafeERC20: low-level call failed");



        if (returndata.length > 0) { // Return data is optional

            // solhint-disable-next-line max-line-length

            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");

        }

    }

}



// File: openzeppelin-solidity/contracts/ownership/Ownable.sol



pragma solidity ^0.5.0;



/**

 * @dev Contract module which provides a basic access control mechanism, where

 * there is an account (an owner) that can be granted exclusive access to

 * specific functions.

 *

 * This module is used through inheritance. It will make available the modifier

 * `onlyOwner`, which can be applied to your functions to restrict their use to

 * the owner.

 */

contract Ownable is Context {

    address private _owner;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    /**

     * @dev Initializes the contract setting the deployer as the initial owner.

     */

    constructor () internal {

        _owner = _msgSender();

        emit OwnershipTransferred(address(0), _owner);

    }



    /**

     * @dev Returns the address of the current owner.

     */

    function owner() public view returns (address) {

        return _owner;

    }



    /**

     * @dev Throws if called by any account other than the owner.

     */

    modifier onlyOwner() {

        require(isOwner(), "Ownable: caller is not the owner");

        _;

    }



    /**

     * @dev Returns true if the caller is the current owner.

     */

    function isOwner() public view returns (bool) {

        return _msgSender() == _owner;

    }



    /**

     * @dev Leaves the contract without owner. It will not be possible to call

     * `onlyOwner` functions anymore. Can only be called by the current owner.

     *

     * NOTE: Renouncing ownership will leave the contract without an owner,

     * thereby removing any functionality that is only available to the owner.

     */

    function renounceOwnership() public onlyOwner {

        emit OwnershipTransferred(_owner, address(0));

        _owner = address(0);

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

        require(newOwner != address(0), "Ownable: new owner is the zero address");

        emit OwnershipTransferred(_owner, newOwner);

        _owner = newOwner;

    }

}



// File: contracts/Withdrawable.sol



pragma solidity ^0.5.0;









contract Withdrawable is Ownable {

    using SafeERC20 for IERC20;



    function adminWithdraw(address asset) onlyOwner public {

        uint amount = adminWitrawAllowed(asset);

        require(amount > 0, "admin witdraw not allowed");

        if (asset == address(0)) {

            msg.sender.transfer(amount);

        } else {

            IERC20(asset).safeTransfer(msg.sender, amount);

        }

    }



    // can be overridden to disallow withdraw for some token

    function adminWitrawAllowed(address asset) internal view returns(uint allowedAmount) {

        allowedAmount = asset == address(0)

            ? address(this).balance

            : IERC20(asset).balanceOf(address(this));

    }

}



// File: contracts/SimpleStaking.sol



pragma solidity ^0.5.0;













contract SimpleStaking is Withdrawable, Pausable {

  using SafeERC20 for IERC20;

  using SafeMath for uint;



  IERC20 public token;

  uint public stakingStart;

  uint public stakingEnd;

  uint public interestRate;

  uint constant interestRateUnit = 1e6;

//  uint public accruingDelta = 15 days;

//  uint public stakingStepTimespan;

  uint constant HUGE_TIME = 99999999999999999;

  uint public adminStopTime = HUGE_TIME;

  uint public accruingInterval;



  mapping (address => uint) public lockedAmount;

  mapping (address => uint) public alreadyWithdrawn;

  uint public totalLocked;

  uint public totalWithdrawn;



  uint public interestReserveBalance;



  event StakingUpdated(address indexed user, uint userLocked, uint remainingInterestReserve);

  event Withdraw(address investor, uint amount);



  constructor (address token_, uint start_, uint end_, uint accruingInterval_, uint rate_) public {

    token = IERC20(token_);

    require(end_ > start_, "end must be greater than start");

    stakingStart = start_;

    stakingEnd = end_;

    require(rate_ > 0 && rate_ < interestRateUnit, "rate must be greater than 0 and lower than unit");

    interestRate = rate_;

    require(accruingInterval_ > 0, "accruingInterval_ must be greater than 0");

    require((end_ - start_) % accruingInterval_ == 0, "end time not alligned");

    require(end_ - start_ >= accruingInterval_, "end - start must be greater than accruingInterval");

    accruingInterval = accruingInterval_;

  }



  modifier afterStart() {

    require(stakingStart < now, "Only after start");

    _;

  }



  modifier beforeStart() {

    require(now < stakingStart, "Only before start");

    _;

  }



  function adminWitrawAllowed(address asset) internal view returns(uint) {

    if (asset != address(token)) {

      return super.adminWitrawAllowed(asset);

    } else {

      uint balance = token.balanceOf(address(this));

      uint maxInterest = _getTotalInterestAmount(totalLocked);

      uint interest = adminStopTime == HUGE_TIME

        ? maxInterest

        : _getAccruedInterest(maxInterest, adminStopTime);

      uint reserved = totalLocked.add(interest).sub(totalWithdrawn);

      return reserved < balance ? balance - reserved : 0;

    }

  }



  function _min(uint a, uint b) private pure returns(uint) {

    return a < b ? a : b;

  }



  function _max(uint a, uint b) private pure returns(uint) {

    return a > b ? a : b;

  }



  function adminStop() public onlyOwner {

    require(adminStopTime == HUGE_TIME, "already admin stopped");

    require(now < stakingEnd, "already ended");

    adminStopTime = _max(now, stakingStart);

  }



  function _transferTokensFromSender(uint amount) private {

    require(amount > 0, "Invalid amount");

    uint expectedBalance = token.balanceOf(address(this)).add(amount);

    token.safeTransferFrom(msg.sender, address(this), amount);

    require(token.balanceOf(address(this)) == expectedBalance, "Invalid balance after transfer");

  }



  function addFundsForInterests(uint amount) public {

    _transferTokensFromSender(amount);

    interestReserveBalance = interestReserveBalance.add(amount);

  }



  function getAvailableStaking() external view returns(uint) {

    return now > stakingStart

    ? 0

    : interestReserveBalance.mul(interestRateUnit).div(interestRate).add(interestRateUnit / interestRate).sub(1);

  }



  function _getTotalInterestAmount(uint investmentAmount) private view returns(uint) {

    return investmentAmount.mul(interestRate).div(interestRateUnit);

  }



  function getAccruedInterestNow(address user) public view returns(uint) {

    return getAccruedInterest(user, now);

  }



  function getAccruedInterest(address user, uint time) public view returns(uint) {

    uint totalInterest = _getTotalInterestAmount(lockedAmount[user]);

    return _getAccruedInterest(totalInterest, time);

  }



  function _getAccruedInterest(uint totalInterest, uint time) private view returns(uint) {

    if (time < stakingStart + accruingInterval) {

      return 0;

    } else if ( stakingEnd <= time && time < adminStopTime) {

      return totalInterest;

    } else {

      uint lockTimespanLength = stakingEnd - stakingStart;

      uint elapsed = _min(time, adminStopTime).sub(stakingStart).div(accruingInterval).mul(accruingInterval);

      return totalInterest.mul(elapsed).div(lockTimespanLength);

    }

  }



  function addStaking(uint amount) external

    whenNotPaused

    beforeStart

  {

    require(token.allowance(msg.sender, address(this)) >= amount, "Insufficient allowance");

    uint interestAmount = _getTotalInterestAmount(amount);

    require(interestAmount <= interestReserveBalance, "No tokens available for interest");



    _transferTokensFromSender(amount);

    interestReserveBalance = interestReserveBalance.sub(interestAmount);



    uint newLockedAmount = lockedAmount[msg.sender].add(amount);

    lockedAmount[msg.sender] = newLockedAmount;

    totalLocked = totalLocked.add(amount);



    emit StakingUpdated(msg.sender, newLockedAmount, interestReserveBalance);

  }



  function withdraw() external

    afterStart

    returns(uint)

  {

    uint locked = lockedAmount[msg.sender];

    uint withdrawn = alreadyWithdrawn[msg.sender];

    uint accruedInterest = getAccruedInterest(msg.sender, now);

    uint unlockedAmount = now < _min(stakingEnd, adminStopTime) ? 0 : locked;



    uint accrued = accruedInterest + unlockedAmount;

    require(accrued > withdrawn, "nothing to withdraw");

    uint toTransfer = accrued.sub(withdrawn);



    alreadyWithdrawn[msg.sender] = withdrawn.add(toTransfer);

    totalWithdrawn = totalWithdrawn.add(toTransfer);

    token.safeTransfer(msg.sender, toTransfer);

    emit Withdraw(msg.sender, toTransfer);



    return toTransfer;

  }

}



// File: contracts/SimpleStakingProxy.sol



pragma solidity ^0.5.0;















contract SimpleStakingProxy is Withdrawable, Pausable {

  using SafeERC20 for IERC20;

  using SafeMath for uint;



  IERC20 public token;

  uint public stakingStart;

  uint public stakingEnd;

  uint public interestRate;

  uint constant interestRateUnit = 1e6;

//  uint public accruingDelta = 15 days;

//  uint public stakingStepTimespan;

  uint constant HUGE_TIME = 99999999999999999;

  uint public adminStopTime = HUGE_TIME;

  uint public accruingInterval;



  SimpleStaking public proxedStaking;

  mapping (address => uint) public _lockedAmount;

  mapping (address => uint) public _alreadyWithdrawn;

  uint public totalLocked;

  uint public totalWithdrawn;



  uint public interestReserveBalance;



  event StakingUpdated(address indexed user, uint userLocked, uint remainingInterestReserve);

  event Withdraw(address investor, uint amount);



  constructor (address token_, address staking_) public {

    token = IERC20(token_);

    proxedStaking = SimpleStaking(staking_);

    stakingStart = proxedStaking.stakingStart();

    stakingEnd = proxedStaking.stakingEnd();

    interestRate = proxedStaking.interestRate();

    accruingInterval = proxedStaking.accruingInterval();

    totalLocked = proxedStaking.totalLocked();

//    totalWithdrawn = proxedStaking.totalWithdrawn();

    require(proxedStaking.paused(), "proxed staking contract must be paused");

    require(stakingEnd > stakingStart, "end must be greater than start");

    require(interestRate > 0 && interestRate < interestRateUnit, "rate must be greater than 0 and lower than unit");

    require(accruingInterval > 0, "accruingInterval_ must be greater than 0");

    require((stakingEnd - stakingStart) % accruingInterval == 0, "end time not alligned");

    require(stakingEnd - stakingStart >= accruingInterval, "end - start must be greater than accruingInterval");

  }



  modifier afterStart() {

    require(stakingStart < now, "Only after start");

    _;

  }



  modifier beforeStart() {

    require(now < stakingStart, "Only before start");

    _;

  }



  function _min(uint a, uint b) private pure returns(uint) {

    return a < b ? a : b;

  }



  function _max(uint a, uint b) private pure returns(uint) {

    return a > b ? a : b;

  }



  function adminStop() public onlyOwner {

    require(adminStopTime == HUGE_TIME, "already admin stopped");

    require(now < stakingEnd, "already ended");

    adminStopTime = _max(now, stakingStart);

  }



  function lockedAmount(address user) public view returns(uint amount) {

    amount = _lockedAmount[user];

    if (amount == 0) {

      amount = proxedStaking.lockedAmount(user);

    }

  }



  function alreadyWithdrawn(address user) public view returns(uint amount) {

    if (_lockedAmount[user] == 0) {

      amount = proxedStaking.alreadyWithdrawn(user);

    } else {

      amount = _alreadyWithdrawn[user];

    }

  }



  function _fetchAmounts(address user) internal returns(uint locked, uint withdrawn) {

    locked = _lockedAmount[user];

    withdrawn = _alreadyWithdrawn[user];

    if (locked == 0) {

      locked = proxedStaking.lockedAmount(user);

      withdrawn = proxedStaking.alreadyWithdrawn(user);

      _lockedAmount[user] = locked;

      _alreadyWithdrawn[user] = withdrawn;

    }

  }



  function fetchAmounts(address[] memory users) public {

    for (uint i=0; i < users.length; i++) {

      _fetchAmounts(users[i]);

    }

  }



  event AdminStakingChanged(address user, uint oldLocked, uint oldWithdrawn, uint newLocked, uint newWithdrawn);



  function adminSetAmounts(address user, uint locked, uint withdrawn) public onlyOwner {

    (uint oldLocked, uint oldWithdrawn) = _fetchAmounts(msg.sender);

    _lockedAmount[user] = locked;

    _alreadyWithdrawn[user] = withdrawn;

    emit AdminStakingChanged(user, oldLocked, oldWithdrawn, locked, withdrawn);

  }



  function _transferTokensFromSender(uint amount) private {

    require(amount > 0, "Invalid amount");

    uint expectedBalance = token.balanceOf(address(this)).add(amount);

    token.safeTransferFrom(msg.sender, address(this), amount);

    require(token.balanceOf(address(this)) == expectedBalance, "Invalid balance after transfer");

  }



  function addFundsForInterests(uint amount) public {

    _transferTokensFromSender(amount);

    interestReserveBalance = interestReserveBalance.add(amount);

  }



  function getAvailableStaking() external view returns(uint) {

    return now > stakingStart

    ? 0

    : interestReserveBalance.mul(interestRateUnit).div(interestRate).add(interestRateUnit / interestRate).sub(1);

  }



  function _getTotalInterestAmount(uint investmentAmount) private view returns(uint) {

    return investmentAmount.mul(interestRate).div(interestRateUnit);

  }



  function getAccruedInterestNow(address user) public view returns(uint) {

    return getAccruedInterest(user, now);

  }



  function getAccruedInterest(address user, uint time) public view returns(uint) {

    uint totalInterest = _getTotalInterestAmount(lockedAmount(user));

    return _getAccruedInterest(totalInterest, time);

  }



  function _getAccruedInterest(uint totalInterest, uint time) private view returns(uint) {

    if (time < stakingStart + accruingInterval) {

      return 0;

    } else if ( stakingEnd <= time && time < adminStopTime) {

      return totalInterest;

    } else {

      uint lockTimespanLength = stakingEnd - stakingStart;

      uint elapsed = _min(time, adminStopTime).sub(stakingStart).div(accruingInterval).mul(accruingInterval);

      return totalInterest.mul(elapsed).div(lockTimespanLength);

    }

  }



  function addStaking(uint amount) external

    whenNotPaused

    beforeStart

  {

    require(token.allowance(msg.sender, address(this)) >= amount, "Insufficient allowance");

    uint interestAmount = _getTotalInterestAmount(amount);

    require(interestAmount <= interestReserveBalance, "No tokens available for interest");



    _transferTokensFromSender(amount);

    interestReserveBalance = interestReserveBalance.sub(interestAmount);



    (uint newLockedAmount, ) = _fetchAmounts(msg.sender);

    newLockedAmount = newLockedAmount.add(amount);

    _lockedAmount[msg.sender] = newLockedAmount;

    totalLocked = totalLocked.add(amount);



    emit StakingUpdated(msg.sender, newLockedAmount, interestReserveBalance);

  }



  function withdraw() external

    afterStart

    returns(uint)

  {

    (, uint withdrawn) = _fetchAmounts(msg.sender);

    uint accruedInterest = getAccruedInterest(msg.sender, now);

//    uint unlockedAmount = now < _min(stakingEnd, adminStopTime) ? 0 : locked;

    uint unlockedAmount = 0; // locked tokens managed by the DAO



    uint accrued = accruedInterest + unlockedAmount;

    require(accrued > withdrawn, "nothing to withdraw");

    uint toTransfer = accrued.sub(withdrawn);



    _alreadyWithdrawn[msg.sender] = withdrawn.add(toTransfer);

    totalWithdrawn = totalWithdrawn.add(toTransfer);

    token.safeTransfer(msg.sender, toTransfer);

    emit Withdraw(msg.sender, toTransfer);



    return toTransfer;

  }

}