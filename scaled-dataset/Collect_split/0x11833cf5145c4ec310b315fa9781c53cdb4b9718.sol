// File: @openzeppelin/contracts/token/ERC20/IERC20.sol



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



// File: @openzeppelin/contracts/token/ERC20/ERC20Detailed.sol



pragma solidity ^0.5.0;





/**

 * @dev Optional functions from the ERC20 standard.

 */

contract ERC20Detailed is IERC20 {

    string private _name;

    string private _symbol;

    uint8 private _decimals;



    /**

     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of

     * these values are immutable: they can only be set once during

     * construction.

     */

    constructor (string memory name, string memory symbol, uint8 decimals) public {

        _name = name;

        _symbol = symbol;

        _decimals = decimals;

    }



    /**

     * @dev Returns the name of the token.

     */

    function name() public view returns (string memory) {

        return _name;

    }



    /**

     * @dev Returns the symbol of the token, usually a shorter version of the

     * name.

     */

    function symbol() public view returns (string memory) {

        return _symbol;

    }



    /**

     * @dev Returns the number of decimals used to get its user representation.

     * For example, if `decimals` equals `2`, a balance of `505` tokens should

     * be displayed to a user as `5,05` (`505 / 10 ** 2`).

     *

     * Tokens usually opt for a value of 18, imitating the relationship between

     * Ether and Wei.

     *

     * NOTE: This information is only used for _display_ purposes: it in

     * no way affects any of the arithmetic of the contract, including

     * {IERC20-balanceOf} and {IERC20-transfer}.

     */

    function decimals() public view returns (uint8) {

        return _decimals;

    }

}



// File: @openzeppelin/contracts/math/SafeMath.sol



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



// File: @openzeppelin/contracts/utils/Address.sol



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



// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol



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



// File: @openzeppelin/contracts/GSN/Context.sol



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



// File: @openzeppelin/contracts/ownership/Ownable.sol



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



// File: contracts/interfaces/ILendingProtocol.sol



pragma solidity 0.5.16;



interface ILendingProtocol {

  function mint() external returns (uint256);

  function redeem(address account) external returns (uint256);

  function nextSupplyRate(uint256 amount) external view returns (uint256);

  function nextSupplyRateWithParams(uint256[] calldata params) external view returns (uint256);

  function getAPR() external view returns (uint256);

  function getPriceInToken() external view returns (uint256);

  function token() external view returns (address);

  function underlying() external view returns (address);

  function availableLiquidity() external view returns (uint256);

}



// File: contracts/interfaces/AaveLendingPoolProvider.sol



pragma solidity 0.5.16;



interface AaveLendingPoolProvider {

  function getLendingPool() external view returns (address);

  function getLendingPoolCore() external view returns (address);

}



// File: contracts/interfaces/AaveLendingPool.sol



pragma solidity 0.5.16;



interface AaveLendingPool {

  function deposit(address _reserve, uint256 _amount, uint16 _referralCode) external;

  function getReserveData(address _reserve)

    external view returns (

      uint256 totalLiquidity,

      uint256 availableLiquidity,

      uint256 totalBorrowsStable,

      uint256 totalBorrowsVariable,

      uint256 liquidityRate,

      uint256 variableBorrowRate,

      uint256 stableBorrowRate,

      uint256 averageStableBorrowRate,

      uint256 utilizationRate,

      uint256 liquidityIndex,

      uint256 variableBorrowIndex,

      address aTokenAddress,

      uint40 lastUpdateTimestamp

    );

}



// File: contracts/interfaces/AaveLendingPoolCore.sol



pragma solidity 0.5.16;



interface AaveLendingPoolCore {

  function getReserveCurrentLiquidityRate(address _reserve) external view returns (uint256);

  function getReserveInterestRateStrategyAddress(address _reserve) external view returns (address);

  function getReserveTotalBorrowsStable(address _reserve) external view returns (uint256);

  function getReserveTotalBorrowsVariable(address _reserve) external view returns (uint256);

  function getReserveCurrentAverageStableBorrowRate(address _reserve) external view returns (uint256);

  function getReserveAvailableLiquidity(address _reserve) external view returns (uint256);

}



// File: contracts/interfaces/AToken.sol



pragma solidity 0.5.16;



interface AToken {

  function redeem(uint256 amount) external;

}



// File: contracts/interfaces/AaveInterestRateStrategy.sol



pragma solidity 0.5.16;



interface AaveInterestRateStrategy {

  function getBaseVariableBorrowRate() external view returns (uint256);

  function calculateInterestRates(

    address _reserve,

    uint256 _utilizationRate,

    uint256 _totalBorrowsStable,

    uint256 _totalBorrowsVariable,

    uint256 _averageStableBorrowRate) external view

  returns (uint256 liquidityRate, uint256 stableBorrowRate, uint256 variableBorrowRate);

}



// File: contracts/wrappers/IdleAave.sol



/**

 * @title: Aave wrapper

 * @summary: Used for interacting with Aave. Has

 *           a common interface with all other protocol wrappers.

 *           This contract holds assets only during a tx, after tx it should be empty

 * @author: Idle Labs Inc., idle.finance

 */

pragma solidity 0.5.16;

























contract IdleAave is ILendingProtocol, Ownable {

  using SafeERC20 for IERC20;

  using SafeMath for uint256;



  // protocol token (aToken) address

  address public token;

  // underlying token (token eg DAI) address

  address public underlying;

  address public idleToken;



  address public constant aaveAddressesProvider = address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  AaveLendingPoolProvider provider = AaveLendingPoolProvider(aaveAddressesProvider);



  /**

   * @param _token : aToken address

   * @param _underlying : underlying token (eg DAI) address

   */

  constructor(address _token, address _underlying) public {

    require(_token != address(0) && _underlying != address(0), 'AAVE: some addr is 0');



    token = _token;

    underlying = _underlying;

    IERC20(_underlying).safeApprove(

      provider.getLendingPoolCore(),

      uint256(-1)

    );

  }



  /**

   * Throws if called by any account other than IdleToken contract.

   */

  modifier onlyIdle() {

    require(msg.sender == idleToken, "Ownable: caller is not IdleToken");

    _;

  }



  // onlyOwner

  /**

   * sets idleToken address

   * NOTE: can be called only once. It's not on the constructor because we are deploying this contract

   *       after the IdleToken contract

   * @param _idleToken : idleToken address

   */

  function setIdleToken(address _idleToken)

    external onlyOwner {

      require(idleToken == address(0), "idleToken addr already set");

      require(_idleToken != address(0), "_idleToken addr is 0");

      idleToken = _idleToken;

  }

  // end onlyOwner



  /**

   * Calculate next supply rate for Aave, given an `_amount` supplied (last array param)

   * and all other params supplied.

   * on calculations.

   *

   * @param params : array with all params needed for calculation (see below)

   * @return : yearly net rate

   */

  function nextSupplyRateWithParams(uint256[] calldata params)

    external view

    returns (uint256) {

      AaveLendingPoolCore core = AaveLendingPoolCore(provider.getLendingPoolCore());

      AaveInterestRateStrategy apr = AaveInterestRateStrategy(core.getReserveInterestRateStrategyAddress(underlying));

      /*

        params[0] = core.getReserveAvailableLiquidity(underlying);

        params[1] = core.getReserveTotalBorrowsStable(underlying);

        params[2] = core.getReserveTotalBorrowsVariable(underlying);

        params[3] = core.getReserveCurrentAverageStableBorrowRate(underlying);

        params[4] = _amount;

      */



      (uint256 newLiquidityRate,,) = apr.calculateInterestRates(

        underlying,

        params[0].add(params[4]),

        params[1],

        params[2],

        params[3]

      );



      // newLiquidityRate is in RAY (ie 1e27)

      // also newLiquidityRate is in the form 0.03 * 1e27

      // while we need the result in the form 3 * 1e18

      return newLiquidityRate.mul(100).div(10**9);

  }



  /**

   * Calculate next supply rate for Aave, given an `_amount` supplied

   *

   * @param _amount : new underlying amount supplied (eg DAI)

   * @return : yearly net rate

   */

  function nextSupplyRate(uint256 _amount)

    external view

    returns (uint256) {

      AaveLendingPoolCore core = AaveLendingPoolCore(provider.getLendingPoolCore());

      AaveInterestRateStrategy apr = AaveInterestRateStrategy(core.getReserveInterestRateStrategyAddress(underlying));



      (uint256 newLiquidityRate,,) = apr.calculateInterestRates(

        underlying,

        core.getReserveAvailableLiquidity(underlying).add(_amount),

        core.getReserveTotalBorrowsStable(underlying),

        core.getReserveTotalBorrowsVariable(underlying),

        core.getReserveCurrentAverageStableBorrowRate(underlying)

      );

      return newLiquidityRate.mul(100).div(10**9);

  }



  /**

   * @return current price of aToken in underlying, Aave price is always 1

   */

  function getPriceInToken()

    external view

    returns (uint256) {

      return 10**18;

  }



  /**

   * @return apr : current yearly net rate

   */

  function getAPR()

    external view

    returns (uint256) {

      AaveLendingPoolCore core = AaveLendingPoolCore(provider.getLendingPoolCore());

      return core.getReserveCurrentLiquidityRate(underlying).mul(100).div(10**9);

  }



  /**

   * Gets all underlying tokens in this contract and mints aTokens

   * tokens are then transferred to msg.sender

   * NOTE: underlying tokens needs to be sent here before calling this

   *

   * @return aTokens minted

   */

  function mint()

    external onlyIdle

    returns (uint256 aTokens) {

      uint256 balance = IERC20(underlying).balanceOf(address(this));

      if (balance == 0) {

        return aTokens;

      }

      AaveLendingPool lendingPool = AaveLendingPool(provider.getLendingPool());

      lendingPool.deposit(underlying, balance, 29); // 29 -> referral

      aTokens = IERC20(token).balanceOf(address(this));

      // transfer them to the caller

      IERC20(token).safeTransfer(msg.sender, aTokens);

  }



  /**

   * Gets all aTokens in this contract and redeems underlying tokens.

   * underlying tokens are then transferred to `_account`

   * NOTE: aTokens needs to be sent here before calling this

   *

   * @return underlying tokens redeemd

   */

  function redeem(address _account)

    external onlyIdle

    returns (uint256 tokens) {

      AToken(token).redeem(IERC20(token).balanceOf(address(this)));

      IERC20 _underlying = IERC20(underlying);



      tokens = _underlying.balanceOf(address(this));

      _underlying.safeTransfer(_account, tokens);

  }



  function availableLiquidity() external view returns (uint256) {

    AaveLendingPoolCore core = AaveLendingPoolCore(provider.getLendingPoolCore());

    return IERC20(underlying).balanceOf(address(core));

  }

}