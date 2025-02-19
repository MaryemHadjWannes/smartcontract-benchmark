// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.6.2;



/**

 * @dev Collection of functions related to the address type

 */

library Address {

    /**

     * @dev Returns true if `account` is a contract.

     *

     * [IMPORTANT]

     * ====

     * It is unsafe to assume that an address for which this function returns

     * false is an externally-owned account (EOA) and not a contract.

     *

     * Among others, `isContract` will return false for the following

     * types of addresses:

     *

     *  - an externally-owned account

     *  - a contract in construction

     *  - an address where a contract will be created

     *  - an address where a contract lived, but was destroyed

     * ====

     */

    function isContract(address account) internal view returns (bool) {

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts

        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned

        // for accounts without code, i.e. `keccak256('')`

        bytes32 codehash;

        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

        // solhint-disable-next-line no-inline-assembly

        assembly { codehash := extcodehash(account) }

        return (codehash != accountHash && codehash != 0x0);

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

     */

    function sendValue(address payable recipient, uint256 amount) internal {

        require(address(this).balance >= amount, "Address: insufficient balance");



        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value

        (bool success, ) = recipient.call{ value: amount }("");

        require(success, "Address: unable to send value, recipient may have reverted");

    }



    /**

     * @dev Performs a Solidity function call using a low level `call`. A

     * plain`call` is an unsafe replacement for a function call: use this

     * function instead.

     *

     * If `target` reverts with a revert reason, it is bubbled up by this

     * function (like regular Solidity function calls).

     *

     * Returns the raw returned data. To convert to the expected return value,

     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].

     *

     * Requirements:

     *

     * - `target` must be a contract.

     * - calling `target` with `data` must not revert.

     *

     * _Available since v3.1._

     */

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {

      return functionCall(target, data, "Address: low-level call failed");

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with

     * `errorMessage` as a fallback revert reason when `target` reverts.

     *

     * _Available since v3.1._

     */

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {

        return _functionCallWithValue(target, data, 0, errorMessage);

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],

     * but also transferring `value` wei to `target`.

     *

     * Requirements:

     *

     * - the calling contract must have an ETH balance of at least `value`.

     * - the called Solidity function must be `payable`.

     *

     * _Available since v3.1._

     */

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {

        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");

    }



    /**

     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but

     * with `errorMessage` as a fallback revert reason when `target` reverts.

     *

     * _Available since v3.1._

     */

    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {

        require(address(this).balance >= value, "Address: insufficient balance for call");

        return _functionCallWithValue(target, data, value, errorMessage);

    }



    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {

        require(isContract(target), "Address: call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);

        if (success) {

            return returndata;

        } else {

            // Look for revert reason and bubble it up if present

            if (returndata.length > 0) {

                // The easiest way to bubble the revert reason is using memory via assembly



                // solhint-disable-next-line no-inline-assembly

                assembly {

                    let returndata_size := mload(returndata)

                    revert(add(32, returndata), returndata_size)

                }

            } else {

                revert(errorMessage);

            }

        }

    }

}



pragma solidity ^0.6.0;



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

abstract contract Context {

    function _msgSender() internal view virtual returns (address payable) {

        return msg.sender;

    }



    function _msgData() internal view virtual returns (bytes memory) {

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

        return msg.data;

    }

}



pragma solidity ^0.6.0;



/**

 * @dev Interface of the ERC20 standard as defined in the EIP.

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



pragma solidity ^0.6.0;



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

     *

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

     *

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

     *

     * - Subtraction cannot overflow.

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

     *

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

     *

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

     *

     * - The divisor cannot be zero.

     */

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

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

     *

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

     *

     * - The divisor cannot be zero.

     */

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}



pragma solidity >=0.6.2;



interface IUniswapV2Router01 {

    function factory() external pure returns (address);

    function WETH() external pure returns (address);



    function addLiquidity(

        address tokenA,

        address tokenB,

        uint amountADesired,

        uint amountBDesired,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(

        address token,

        uint amountTokenDesired,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(

        uint amountOut,

        uint amountInMax,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);



    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);

}



pragma solidity >=0.5.0;



interface IUniswapV2Factory {

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);



    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);



    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);



    function createPair(address tokenA, address tokenB) external returns (address pair);



    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

}



pragma solidity >=0.5.0;



interface IUniswapV2Pair {

    event Approval(address indexed owner, address indexed spender, uint value);

    event Transfer(address indexed from, address indexed to, uint value);



    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);



    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);



    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint);



    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;



    event Mint(address indexed sender, uint amount0, uint amount1);

    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);

    event Swap(

        address indexed sender,

        uint amount0In,

        uint amount1In,

        uint amount0Out,

        uint amount1Out,

        address indexed to

    );

    event Sync(uint112 reserve0, uint112 reserve1);



    function MINIMUM_LIQUIDITY() external pure returns (uint);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint);

    function price1CumulativeLast() external view returns (uint);

    function kLast() external view returns (uint);



    function mint(address to) external returns (uint liquidity);

    function burn(address to) external returns (uint amount0, uint amount1);

    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;

    function skim(address to) external;

    function sync() external;



    function initialize(address, address) external;

}



pragma solidity >=0.6.2;



interface IUniswapV2Router02 is IUniswapV2Router01 {

    function removeLiquidityETHSupportingFeeOnTransferTokens(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountETH);



    function swapExactTokensForTokensSupportingFeeOnTransferTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external;

}



contract Ownable is Context {

    address private _owner;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    constructor () public {

        address msgSender = _msgSender();

        _owner = msgSender;

        emit OwnershipTransferred(address(0), msgSender);

    }



    function owner() public view returns (address) {

        return _owner;

    }   

    

    modifier onlyOwner() {

        require(_owner == _msgSender(), "Ownable: caller is not the owner");

        _;

    }

    

    function renounceOwnership() public virtual onlyOwner {

        emit OwnershipTransferred(_owner, address(0));

        _owner = address(0);

    }



    function transferOwnership(address newOwner) public virtual onlyOwner {

        require(newOwner != address(0), "Ownable: new owner is the zero address");

        emit OwnershipTransferred(_owner, newOwner);

        _owner = newOwner;

    }

}



pragma solidity ^0.6.2;



contract BRBT is Ownable, IERC20 {

    using SafeMath for uint256;

    using Address for address;



    mapping (address => uint256) private _rOwned;

    mapping (address => uint256) private _tOwned;

    mapping (address => mapping (address => uint256)) private _allowances;

    mapping (address => bool) private _blacklist;

    mapping (address => uint256) private _buys;

    mapping (address => uint256) private _sells;

    mapping (address => bool) public _collaborators;

    address[] private quicks;

    

    address private britneyFund1 = address(0xe31E1916a475A4b80dDC7c93c989f83e999124F1);

    address private britneyFund2 = address(0x026c39FB3F2907A5C4E89E35c732e92373d1ce7B);

   

    uint256 private constant MAX = ~uint256(0);

    uint256 private _tTotal = 100_000_000 * 10 ** 18;

    uint256 private _rTotal = (MAX - (MAX % _tTotal));



    bool private _midSwap;

    uint256 public _swapAmount = 30_000 ether; // 0 to disable



    IUniswapV2Router02 private _v2Router;

    address private _v2RouterAddress;

    IUniswapV2Pair private _v2Pair;

    address private _v2PairAddress;

    address private _thisAddress;

    address[] private _tokenPath = new address[](2);



    uint256 public _dat = 10;

    uint256 private _lpFee = 100;



    uint256 public _sellTxLimit = 20_000 ether;

    uint256 public _buyTxLimit = 1; // SET. 0 to disable, 1 for auto mode

    uint256 public _maxAutoBuyTxLimit = 120_000 ether;

    uint256 public _sellCooldown = 180; // 5 minutes

    uint256 public _buyCooldown = 240; // 4 minutes

    bool public autoDonate = true;

    uint256 public pairPercentage = 10;

    uint256 private _initialBuyLimit = 15_000 ether;

    uint256 private _buyLimitIncrements = 5_000 ether;

    

    // one-time flags

    bool public _limitsEnabled = true;

    bool public _blacklistEnabled = true;

    bool public _collaboratorsEnabled = true;



    bool private _takeLpFee = false;

    

    string private _name = 'BritneyBitch';

    string private _symbol = 'BRTB';

    uint8 private _decimals = 18;

    uint256 public listingTimestamp = 0;



    event LpAdded(uint256 ethAdded, uint256 tokensAdded);

    event TokensBurned(uint256 ethSpent, uint256 tokensBurned);



    constructor () public {

        _thisAddress = address(this);

        _v2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

        _v2RouterAddress = address(_v2Router);

        _v2PairAddress = IUniswapV2Factory(_v2Router.factory()).createPair(_thisAddress, _v2Router.WETH());

        _v2Pair = IUniswapV2Pair(_v2PairAddress);

        _tokenPath[0] = _thisAddress;

        _tokenPath[1] = _v2Router.WETH();

        _collaborators[owner()] = true;

        

        _rOwned[owner()] = _rTotal;

        _tOwned[owner()] = _tTotal;

        emit Transfer(address(0), owner(), _tTotal);

        

        _approve(_thisAddress, _v2RouterAddress, MAX);



    }



    receive() external payable {}



    function name() public view returns (string memory) {

        return _name;

    }



    function symbol() public view returns (string memory) {

        return _symbol;

    }



    function decimals() public view returns (uint8) {

        return _decimals;

    }



    function v2PairAddress() public view returns(address) {

        return _v2PairAddress;

    }



    function currentLiquidityFee() public view returns (uint256) {

        return _lpFee;

    }



    function totalSupply() public view override returns (uint256) {

        return _tTotal;

    }



    function balanceOf(address account) public view override returns (uint256) {

        if (account == _v2PairAddress) return _tOwned[account];

        return tokenFromReflection(_rOwned[account]);

    }



    function transfer(address recipient, uint256 amount) public override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    function allowance(address owner, address spender) public view override returns (uint256) {

        return _allowances[owner][spender];

    }



    function approve(address spender, uint256 amount) public override returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }



    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));

        return true;

    }



    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));

        return true;

    }



    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));

        return true;

    }



    function reflect(uint256 tAmount) public {

        address sender = _msgSender();

        (uint256 rAmount,,,,,) = _getTxValues(tAmount);

        _rOwned[sender] = _rOwned[sender].sub(rAmount);

        _rTotal = _rTotal.sub(rAmount);

    }



    function tokenFromReflection(uint256 rAmount) public view returns(uint256) {

        return rAmount.div(_getRate());

    }



    function reflectionFromToken(uint256 tAmount, bool deductTransferFee) public view returns(uint256) {

        (uint256 rAmount,uint256 rTransferAmount,,,,) = _getTxValues(tAmount);

        if (!deductTransferFee) return rAmount;

        return rTransferAmount;

    }



    function _approve(address owner, address spender, uint256 amount) private {

        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }



    function isBlacklisted(address sender) public view returns (bool) {

        if (_blacklistEnabled == false) {

            return false;

        }

        

        if (sender == _v2PairAddress || sender == _thisAddress) {

            return false;

        } 

        return _blacklist[sender];

    }



    function _handleSellCooldown(address sender) internal {

        if (_limitsEnabled && _sellCooldown > 0 && sender != owner() && sender != _v2PairAddress && sender != _thisAddress) {

            require(getOp() == sender, "should be same one");

            require(block.timestamp - _sells[sender] > _sellCooldown);

            _sells[sender] = block.timestamp;

        }

    }

    

    function _handleBuyCooldown(address recipient) internal {    

        if (_limitsEnabled && _buyCooldown > 0 && recipient != owner() && recipient != _v2PairAddress) {

            require(getOp() == recipient, "should be same");

            require(block.timestamp - _buys[recipient] > _buyCooldown);

            _buys[recipient] = block.timestamp;

        }

    }

    

    function currentBuyTxLimit() public view returns (uint256) {

        if (_buyTxLimit == 0) {

            return 0;

        } else if (_buyTxLimit > 1) {

            return _buyTxLimit;

        }

        

        // _buyTxLimit == 1, auto mode

        

        uint256 initial = _initialBuyLimit;

        uint256 current = initial + (_buyLimitIncrements * (block.timestamp - listingTimestamp) / 15);

        

        if (_maxAutoBuyTxLimit > 0 && current > _maxAutoBuyTxLimit) {

            current = _maxAutoBuyTxLimit;

        }

        

        return current;

    }

    

    function _transfer(address sender, address recipient, uint256 amount) private {

        require(amount > 0, "Transfer amount must be greater than zero");

        require(isBlacklisted(sender) == false, "No");

        if (sender != owner()) {

            require(recipient != _v2PairAddress || listingTimestamp > 0, "not listed yet");

        }

        

        bool tmpTakeFee = _takeLpFee;

        if (_collaborators[sender] || _collaborators[recipient]) {

            _takeLpFee = false;

        }

        

        if (sender == _v2PairAddress) {

            if (_limitsEnabled && !_midSwap && recipient != owner() && recipient != _v2RouterAddress) {

                uint256 buyLim = currentBuyTxLimit();

                require(buyLim == 0 || amount <= buyLim, "1Transfer amount must be with the TX launch limit");

                

                if (quicks.length < 12) {

                    if (!_blacklist[recipient]) {

                        _blacklist[recipient] = true;   

                        quicks.push(recipient);

                    }

                }

            }

            

            _handleBuyCooldown(recipient);

            _transferFromPool(sender, recipient, amount);

        } else if (recipient == _v2PairAddress) {

            if (_limitsEnabled && sender != owner() && !_midSwap) {

                require(_sellTxLimit == 0 || amount <= _sellTxLimit || sender == owner(), "2Transfer amount must be with the TX launch limit");

            }

            

            

            _handleSellCooldown(sender);

            _transferToPool(sender, recipient, amount);

        } else {

            _handleSellCooldown(sender);

            _transferStandard(sender, recipient, amount);

        }

        

        _takeLpFee = tmpTakeFee;

        

        if (listingTimestamp == 0 && sender == owner() && recipient == _v2PairAddress) {

            listingTimestamp = block.timestamp;

            _takeLpFee = true;

        }

    }



    function _transferFromPool(address sender, address recipient, uint256 tAmount) private {

        (uint256 rAmount, uint256 rTransferAmount, uint256 rDat, uint256 rLpFee, uint256 tTransferAmount,) = _getTxValues(tAmount);

        _tOwned[_v2PairAddress] = _tOwned[_v2PairAddress].sub(tAmount);

        _rOwned[_v2PairAddress] = _rOwned[_v2PairAddress].sub(rAmount);

        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);

        _rOwned[_thisAddress] = _rOwned[_thisAddress].add(rLpFee);

        _rTotal = _rTotal.sub(rDat);

        emit Transfer(sender, recipient, tTransferAmount);

    }



    function _transferToPool(address sender, address recipient, uint256 tAmount) private {

        (uint256 rAmount, uint256 rTransferAmount, uint256 rDat, uint256 rLpFee, uint256 tTransferAmount,) = _getTxValues(tAmount);

        swapLiquidity();

        _rOwned[sender] = _rOwned[sender].sub(rAmount);

        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);

        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);

        _rOwned[_thisAddress] = _rOwned[_thisAddress].add(rLpFee);

        _rTotal = _rTotal.sub(rDat);

        emit Transfer(sender, recipient, tTransferAmount);

    }



    function _transferStandard(address sender, address recipient, uint256 tAmount) private {

        (uint256 rAmount, uint256 rTransferAmount, uint256 rDat, uint256 rLpFee, uint256 tTransferAmount,) = _getTxValues(tAmount); 

        swapLiquidity();

        _rOwned[sender] = _rOwned[sender].sub(rAmount);

        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);

        _rOwned[_thisAddress] = _rOwned[_thisAddress].add(rLpFee);

        _rTotal = _rTotal.sub(rDat);

        emit Transfer(sender, recipient, tTransferAmount);

    }

    

    function multiTransfer(address[] memory addresses, uint256 amount, bool takeFee) public onlyOwner {

        bool tmp = _takeLpFee;

        _takeLpFee = takeFee;

        

        for (uint256 i = 0; i < addresses.length; i++) {

            transfer(addresses[i], amount);

        }

        

        _takeLpFee = tmp;

    }



    function _getTxValues(uint256 tAmount) private view returns (uint256, uint256, uint256, uint256, uint256, uint256) {

        (uint256 tTransferAmount, uint256 tDat, uint256 tLpFee) = _getTValues(tAmount);

        uint256 currentRate =  _getRate();

        (uint256 rAmount, uint256 rTransferAmount, uint256 rDat, uint256 rLpFee) = _getRValues(tAmount, tDat, tLpFee, currentRate);

        return (rAmount, rTransferAmount, rDat, rLpFee, tTransferAmount, currentRate);

    }



    function _getTValues(uint256 tAmount) private view returns (uint256, uint256, uint256) {

        uint256 tDat = tAmount.mul(_dat).div(1000);

        uint256 tLpFee = 0;

        

        if (_takeLpFee) {

            tLpFee = tAmount.mul(_lpFee).div(1000);    

        }

    

        

        return (tAmount.sub(tDat).sub(tLpFee), tDat, tLpFee);

    }



    function _getRValues(uint256 tAmount, uint256 tDat, uint256 tLpFee, uint256 currentRate) private pure returns (uint256, uint256, uint256, uint256) {

        uint256 rAmount = tAmount.mul(currentRate);

        uint256 rDat = tDat.mul(currentRate);

        uint256 rLpFee = tLpFee.mul(currentRate);

        return (rAmount, rAmount.sub(rDat).sub(rLpFee), rDat, rLpFee);

    }



    function _getRate() private view returns(uint256) {

        return (_rTotal.sub(_rOwned[_v2PairAddress])).div(_tTotal.sub(_tOwned[_v2PairAddress]));

    }



    function swapLiquidity() private returns(uint256) {

        if (_swapAmount != 0 && listingTimestamp > 0 && balanceOf(_thisAddress) > _swapAmount && !_midSwap) {

            _doSwap();

            

            if (autoDonate) {

                donateFunds();    

            }

        }

    }

    

    function getOp() public view returns (address) {

        return tx.origin;

    }



    function _doSwap() private {

        _midSwap = true;

        uint256 toConvert = balanceOf(_thisAddress);

        uint256 toConvertMax = balanceOf(_v2PairAddress).mul(pairPercentage).div(100); 

        if (toConvert > toConvertMax) {

            toConvert = toConvertMax;

        }



        if (allowance(_thisAddress, _v2RouterAddress) < toConvert) {

            _approve(_thisAddress, _v2RouterAddress, MAX);

        }

        _swapTokensForEth(toConvert);

        _midSwap = false;

    }

    

    function viewQuicks() external view returns (address[] memory) {

        return quicks;

    }



    function setSellTxLimit(uint256 amount) external onlyOwner {

        require(amount >= 10_000 ether, "limit must be reasonable");

        _sellTxLimit = amount;

    }

    

    function setBuyTxLimit(uint256 amount) external onlyOwner {

        require(amount >= 10_000 ether, "limit must be reasonable");

        _buyTxLimit = amount;

    }

    

    function setMaxAutoBuyTxLimit(uint256 amount) external onlyOwner {

        _maxAutoBuyTxLimit = amount;

    }



    function setFunds(address fund1, address fund2) external onlyOwner {

        britneyFund1 = fund1;

        britneyFund2 = fund2;

    }



    function setMinSwap(uint256 amount) external onlyOwner {

        _swapAmount = amount; // 0 to disable

    }

    

    function setPairPercentage(uint256 amount) external onlyOwner {

        pairPercentage = amount; 

    }



    function setBuyCooldown(uint256 amount) external onlyOwner {

        require(amount <= 20 minutes, "should be reasonable");

        _buyCooldown = amount; // 0 to disable

    }

    

    function setSellCooldown(uint256 amount) external onlyOwner {

        require(amount <= 20 minutes, "should be reasonable");

        _sellCooldown = amount; // 0 to disable

    }

    

    function setFees(uint256 lpFee, uint256 dat) external onlyOwner {

        require(lpFee < 150 && dat < 80, "Bad fees");



        _lpFee = lpFee;

        _dat = dat;

    }



    function disableLimits() external onlyOwner {

        _limitsEnabled = false;

    }

    

    function disableBlacklist() external onlyOwner {

        _blacklistEnabled = false;

    }

    

    function setAutoDonate(bool flag) external onlyOwner {

        autoDonate = flag;

    }

    

    function setBlacklistStatus(address sender, bool status) public onlyOwner {

        _blacklist[sender] = status;

    }

    

    function multiBlacklistSet(address[] memory addresses, bool status) external onlyOwner {

        for (uint256 i = 0; i < addresses.length; i++) {

            setBlacklistStatus(addresses[i], status);

        }

    }

    

    function setCollaboratorStatus(address a, bool status) external onlyOwner {

        if (status == true) {

            // allow adding new collabs only if _collaboratorsEnabled

            require(_collaboratorsEnabled);

        }

        

        _collaborators[a] = status;

    }

    

    function disableCollaborators() external onlyOwner {

        _collaboratorsEnabled = false;

    }



    function _swapTokensForEth(uint256 tokenAmount) private {

        if (tokenAmount == 0) {

            return;

        }

        

        try _v2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount, 0,

             _tokenPath, _thisAddress, block.timestamp) {

        } catch {

        }

    }



    function donateFunds() public {    

        if (owner() == address(0) || britneyFund1 == address(0) || britneyFund2 == address(0)) {

            return;

        }

        

        uint256 total = _thisAddress.balance;

        if (total == 0) {

            return;

        }

        uint256 fund2Share = total.mul(30).div(100); // 30%

        uint256 fund1Share = total.sub(fund2Share);



        payable(britneyFund1).transfer(fund1Share);

        payable(britneyFund2).transfer(fund2Share);

    }

}