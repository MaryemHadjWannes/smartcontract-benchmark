pragma solidity 0.6.12;



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



// File: contracts/utils/Address.sol





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



// File: contracts/token/ERC20/ERC20.sol



/**

 * @dev Implementation of the {IERC20} interface.

 *

 * This implementation is agnostic to the way tokens are created. This means

 * that a supply mechanism has to be added in a derived contract using {_mint}.

 * For a generic mechanism see {ERC20PresetMinterPauser}.

 *

 * TIP: For a detailed writeup see our guide

 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How

 * to implement supply mechanisms].

 *

 * We have followed general OpenZeppelin guidelines: functions revert instead

 * of returning `false` on failure. This behavior is nonetheless conventional

 * and does not conflict with the expectations of ERC20 applications.

 *

 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.

 * This allows applications to reconstruct the allowance for all accounts just

 * by listening to said events. Other implementations of the EIP may not emit

 * these events, as it isn't required by the specification.

 *

 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}

 * functions have been added to mitigate the well-known issues around setting

 * allowances. See {IERC20-approve}.

 */

contract ERC20 is Context, IERC20 {

    using SafeMath for uint256;

    using Address for address;



    mapping (address => uint256) private _balances;



    mapping (address => mapping (address => uint256)) private _allowances;



    uint256 private _totalSupply;



    string private _name;

    string private _symbol;

    uint8 private _decimals;



    /**

     * @dev Sets the values for {name} and {symbol}, initializes {decimals} with

     * a default value of 18.

     *

     * To select a different value for {decimals}, use {_setupDecimals}.

     *

     * All three of these values are immutable: they can only be set once during

     * construction.

     */

    constructor (string memory name, string memory symbol) public {

        _name = name;

        _symbol = symbol;

        _decimals = 18;

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

     * Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is

     * called.

     *

     * NOTE: This information is only used for _display_ purposes: it in

     * no way affects any of the arithmetic of the contract, including

     * {IERC20-balanceOf} and {IERC20-transfer}.

     */

    function decimals() public view returns (uint8) {

        return _decimals;

    }



    /**

     * @dev See {IERC20-totalSupply}.

     */

    function totalSupply() public view override returns (uint256) {

        return _totalSupply;

    }



    /**

     * @dev See {IERC20-balanceOf}.

     */

    function balanceOf(address account) public view override returns (uint256) {

        return _balances[account];

    }



    /**

     * @dev See {IERC20-transfer}.

     *

     * Requirements:

     *

     * - `recipient` cannot be the zero address.

     * - the caller must have a balance of at least `amount`.

     */

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    /**

     * @dev See {IERC20-allowance}.

     */

    function allowance(address owner, address spender) public view virtual override returns (uint256) {

        return _allowances[owner][spender];

    }



    /**

     * @dev See {IERC20-approve}.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     */

    function approve(address spender, uint256 amount) public virtual override returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }



    /**

     * @dev See {IERC20-transferFrom}.

     *

     * Emits an {Approval} event indicating the updated allowance. This is not

     * required by the EIP. See the note at the beginning of {ERC20};

     *

     * Requirements:

     * - `sender` and `recipient` cannot be the zero address.

     * - `sender` must have a balance of at least `amount`.

     * - the caller must have allowance for ``sender``'s tokens of at least

     * `amount`.

     */

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));

        return true;

    }



    /**

     * @dev Atomically increases the allowance granted to `spender` by the caller.

     *

     * This is an alternative to {approve} that can be used as a mitigation for

     * problems described in {IERC20-approve}.

     *

     * Emits an {Approval} event indicating the updated allowance.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     */

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));

        return true;

    }



    /**

     * @dev Atomically decreases the allowance granted to `spender` by the caller.

     *

     * This is an alternative to {approve} that can be used as a mitigation for

     * problems described in {IERC20-approve}.

     *

     * Emits an {Approval} event indicating the updated allowance.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     * - `spender` must have allowance for the caller of at least

     * `subtractedValue`.

     */

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));

        return true;

    }



    /**

     * @dev Moves tokens `amount` from `sender` to `recipient`.

     *

     * This is internal function is equivalent to {transfer}, and can be used to

     * e.g. implement automatic token fees, slashing mechanisms, etc.

     *

     * Emits a {Transfer} event.

     *

     * Requirements:

     *

     * - `sender` cannot be the zero address.

     * - `recipient` cannot be the zero address.

     * - `sender` must have a balance of at least `amount`.

     */

    function _transfer(address sender, address recipient, uint256 amount) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        _beforeTokenTransfer(sender, recipient, amount);



        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");

        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

    }



    /** @dev Creates `amount` tokens and assigns them to `account`, increasing

     * the total supply.

     *

     * Emits a {Transfer} event with `from` set to the zero address.

     *

     * Requirements

     *

     * - `to` cannot be the zero address.

     */

    function _mint(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: mint to the zero address");



        _beforeTokenTransfer(address(0), account, amount);



        _totalSupply = _totalSupply.add(amount);

        _balances[account] = _balances[account].add(amount);

        emit Transfer(address(0), account, amount);

    }



    /**

     * @dev Destroys `amount` tokens from `account`, reducing the

     * total supply.

     *

     * Emits a {Transfer} event with `to` set to the zero address.

     *

     * Requirements

     *

     * - `account` cannot be the zero address.

     * - `account` must have at least `amount` tokens.

     */

    function _burn(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: burn from the zero address");



        _beforeTokenTransfer(account, address(0), amount);



        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");

        _totalSupply = _totalSupply.sub(amount);

        emit Transfer(account, address(0), amount);

    }



    /**

     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.

     *

     * This internal function is equivalent to `approve`, and can be used to

     * e.g. set automatic allowances for certain subsystems, etc.

     *

     * Emits an {Approval} event.

     *

     * Requirements:

     *

     * - `owner` cannot be the zero address.

     * - `spender` cannot be the zero address.

     */

    function _approve(address owner, address spender, uint256 amount) internal virtual {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }



    /**

     * @dev Sets {decimals} to a value other than the default one of 18.

     *

     * WARNING: This function should only be called from the constructor. Most

     * applications that interact with token contracts will not expect

     * {decimals} to ever change, and may work incorrectly if it does.

     */

    function _setupDecimals(uint8 decimals_) internal {

        _decimals = decimals_;

    }



    /**

     * @dev Hook that is called before any transfer of tokens. This includes

     * minting and burning.

     *

     * Calling conditions:

     *

     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens

     * will be to transferred to `to`.

     * - when `from` is zero, `amount` tokens will be minted for `to`.

     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.

     * - `from` and `to` are never both zero.

     *

     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].

     */

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

}



/**

 * @title SafeERC20

 * @dev Wrappers around ERC20 operations that throw on failure (when the token

 * contract returns false). Tokens that return no value (and instead revert or

 * throw on failure) are also supported, non-reverting calls are assumed to be

 * successful.

 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,

 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.

 */

library SafeERC20 {

    using SafeMath for uint256;

    using Address for address;



    function safeTransfer(IERC20 token, address to, uint256 value) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));

    }



    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));

    }



    /**

     * @dev Deprecated. This function has issues similar to the ones found in

     * {IERC20-approve}, and its usage is discouraged.

     *

     * Whenever possible, use {safeIncreaseAllowance} and

     * {safeDecreaseAllowance} instead.

     */

    function safeApprove(IERC20 token, address spender, uint256 value) internal {

        // safeApprove should only be called when setting an initial allowance,

        // or when resetting it to zero. To increase and decrease it, use

        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'

        // solhint-disable-next-line max-line-length

        require((value == 0) || (token.allowance(address(this), spender) == 0),

            "SafeERC20: approve from non-zero to non-zero allowance"

        );

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));

    }



    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).add(value);

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    /**

     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement

     * on the return value: the return value is optional (but if data is returned, it must not be false).

     * @param token The token targeted by the call.

     * @param data The call data (encoded using abi.encode or one of its variants).

     */

    function _callOptionalReturn(IERC20 token, bytes memory data) private {

        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since

        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that

        // the target address contains contract code and also asserts for success in the low-level call.



        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional

            // solhint-disable-next-line max-line-length

            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");

        }

    }

}



interface IVault is IERC20 {

    function token() external view returns (address);



    function claimInsurance() external; // NOTE: Only yDelegatedVault implements this



    function getRatio() external view returns (uint256);



    function deposit(uint256) external;



    function withdraw(uint256) external;



    function earn() external;

	

    function balance() external view returns (uint256);

	

    function flashLoan(address, uint256, bytes calldata) external;



    function loanFee() external view returns (uint256);



    function loanFeeMax() external view returns (uint256);

}



interface UniswapRouterV2 {

    function swapExactTokensForTokens(

        uint256 amountIn,

        uint256 amountOutMin,

        address[] calldata path,

        address to,

        uint256 deadline

    ) external returns (uint256[] memory amounts);



    function addLiquidity(

        address tokenA,

        address tokenB,

        uint256 amountADesired,

        uint256 amountBDesired,

        uint256 amountAMin,

        uint256 amountBMin,

        address to,

        uint256 deadline

    )

        external

        returns (

            uint256 amountA,

            uint256 amountB,

            uint256 liquidity

        );



    function addLiquidityETH(

        address token,

        uint256 amountTokenDesired,

        uint256 amountTokenMin,

        uint256 amountETHMin,

        address to,

        uint256 deadline

    )

        external

        payable

        returns (

            uint256 amountToken,

            uint256 amountETH,

            uint256 liquidity

        );



    function removeLiquidity(

        address tokenA,

        address tokenB,

        uint256 liquidity,

        uint256 amountAMin,

        uint256 amountBMin,

        address to,

        uint256 deadline

    ) external returns (uint256 amountA, uint256 amountB);



    function getAmountsOut(uint256 amountIn, address[] calldata path)

        external

        view

        returns (uint256[] memory amounts);



    function getAmountsIn(uint256 amountOut, address[] calldata path)

        external

        view

        returns (uint256[] memory amounts);



    function swapETHForExactTokens(

        uint256 amountOut,

        address[] calldata path,

        address to,

        uint256 deadline

    ) external payable returns (uint256[] memory amounts);



    function swapExactETHForTokens(

        uint256 amountOutMin,

        address[] calldata path,

        address to,

        uint256 deadline

    ) external payable returns (uint256[] memory amounts);

}



interface IUniswapV2Pair {

    event Approval(

        address indexed owner,

        address indexed spender,

        uint256 value

    );

    event Transfer(address indexed from, address indexed to, uint256 value);



    function name() external pure returns (string memory);



    function symbol() external pure returns (string memory);



    function decimals() external pure returns (uint8);



    function totalSupply() external view returns (uint256);



    function balanceOf(address owner) external view returns (uint256);



    function allowance(address owner, address spender)

        external

        view

        returns (uint256);



    function approve(address spender, uint256 value) external returns (bool);



    function transfer(address to, uint256 value) external returns (bool);



    function transferFrom(

        address from,

        address to,

        uint256 value

    ) external returns (bool);



    function DOMAIN_SEPARATOR() external view returns (bytes32);



    function PERMIT_TYPEHASH() external pure returns (bytes32);



    function nonces(address owner) external view returns (uint256);



    function permit(

        address owner,

        address spender,

        uint256 value,

        uint256 deadline,

        uint8 v,

        bytes32 r,

        bytes32 s

    ) external;



    event Mint(address indexed sender, uint256 amount0, uint256 amount1);

    event Burn(

        address indexed sender,

        uint256 amount0,

        uint256 amount1,

        address indexed to

    );

    event Swap(

        address indexed sender,

        uint256 amount0In,

        uint256 amount1In,

        uint256 amount0Out,

        uint256 amount1Out,

        address indexed to

    );

    event Sync(uint112 reserve0, uint112 reserve1);



    function MINIMUM_LIQUIDITY() external pure returns (uint256);



    function factory() external view returns (address);



    function token0() external view returns (address);



    function token1() external view returns (address);



    function getReserves()

        external

        view

        returns (

            uint112 reserve0,

            uint112 reserve1,

            uint32 blockTimestampLast

        );



    function price0CumulativeLast() external view returns (uint256);



    function price1CumulativeLast() external view returns (uint256);



    function kLast() external view returns (uint256);



    function mint(address to) external returns (uint256 liquidity);



    function burn(address to)

        external

        returns (uint256 amount0, uint256 amount1);



    function swap(

        uint256 amount0Out,

        uint256 amount1Out,

        address to,

        bytes calldata data

    ) external;



    function skim(address to) external;



    function sync() external;

}



interface IUniswapV2Factory {

    event PairCreated(

        address indexed token0,

        address indexed token1,

        address pair,

        uint256

    );



    function getPair(address tokenA, address tokenB)

        external

        view

        returns (address pair);



    function allPairs(uint256) external view returns (address pair);



    function allPairsLength() external view returns (uint256);



    function feeTo() external view returns (address);



    function feeToSetter() external view returns (address);



    function createPair(address tokenA, address tokenB)

        external

        returns (address pair);

}



interface IController {

    function vaults(address) external view returns (address);



    function rewards() external view returns (address);



    function devfund() external view returns (address);



    function treasury() external view returns (address);



    function balanceOf(address) external view returns (uint256);



    function withdraw(address, uint256) external;



    function earn(address, uint256) external;

}



interface IMasterchef {

    function BONUS_MULTIPLIER() external view returns (uint256);



    function add(

        uint256 _allocPoint,

        address _lpToken,

        bool _withUpdate

    ) external;



    function bonusEndBlock() external view returns (uint256);



    function deposit(uint256 _pid, uint256 _amount) external;



    function dev(address _devaddr) external;



    function devFundDivRate() external view returns (uint256);



    function devaddr() external view returns (address);



    function emergencyWithdraw(uint256 _pid) external;



    function getMultiplier(uint256 _from, uint256 _to)

        external

        view

        returns (uint256);



    function massUpdatePools() external;



    function owner() external view returns (address);



    function pendingMM(uint256 _pid, address _user)

        external

        view

        returns (uint256);



    function mm() external view returns (address);



    function mmPerBlock() external view returns (uint256);



    function poolInfo(uint256)

        external

        view

        returns (

            address lpToken,

            uint256 allocPoint,

            uint256 lastRewardBlock,

            uint256 accMMPerShare

        );



    function poolLength() external view returns (uint256);



    function renounceOwnership() external;



    function set(

        uint256 _pid,

        uint256 _allocPoint,

        bool _withUpdate

    ) external;



    function setBonusEndBlock(uint256 _bonusEndBlock) external;



    function setDevFundDivRate(uint256 _devFundDivRate) external;



    function setMMPerBlock(uint256 _mmPerBlock) external;



    function startBlock() external view returns (uint256);



    function totalAllocPoint() external view returns (uint256);



    function transferOwnership(address newOwner) external;



    function updatePool(uint256 _pid) external;



    function userInfo(uint256, address)

        external

        view

        returns (uint256 amount, uint256 rewardDebt);



    function withdraw(uint256 _pid, uint256 _amount) external;



    function notifyBuybackReward(uint256 _amount) external;

}



abstract contract StrategyBase {

    using SafeERC20 for IERC20;

    using Address for address;

    using SafeMath for uint256;



    // Perfomance fee 30% to buyback

    uint256 public performanceFee = 30000;

    uint256 public constant performanceMax = 100000;



    // Withdrawal fee 0.2% to buyback

    // - 0.14% to treasury

    // - 0.06% to dev fund

    uint256 public treasuryFee = 140;

    uint256 public constant treasuryMax = 100000;



    uint256 public devFundFee = 60;

    uint256 public constant devFundMax = 100000;



    // buyback ready

    bool public buybackEnabled = true;

    address public mmToken = 0xa283aA7CfBB27EF0cfBcb2493dD9F4330E0fd304;

    address public masterChef = 0xf8873a6080e8dbF41ADa900498DE0951074af577;

	

    // Tokens

    address public want;

    address public constant weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;



    // buyback coins

    address public constant usdcBuyback = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;



    // User accounts

    address public governance;

    address public controller;

    address public strategist;

    address public timelock;



    // Dex

    address public univ2Router2 = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;



    //Sushi

    address constant public sushiRouter = address(0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F);



    constructor(

        address _want,

        address _governance,

        address _strategist,

        address _controller,

        address _timelock

    ) public {

        require(_want != address(0));

        require(_governance != address(0));

        require(_strategist != address(0));

        require(_controller != address(0));

        require(_timelock != address(0));



        want = _want;

        governance = _governance;

        strategist = _strategist;

        controller = _controller;

        timelock = _timelock;

    }



    // **** Modifiers **** //



    modifier onlyBenevolent {

        require(

            msg.sender == tx.origin ||

                msg.sender == governance ||

                msg.sender == strategist

        );

        _;

    }



    // **** Views **** //



    function balanceOfWant() public view returns (uint256) {

        return IERC20(want).balanceOf(address(this));

    }



    function balanceOfPool() public virtual view returns (uint256);



    function balanceOf() public view returns (uint256) {

        return balanceOfWant().add(balanceOfPool());

    }



    function getName() external virtual pure returns (string memory);



    // **** Setters **** //



    function setDevFundFee(uint256 _devFundFee) external {

        require(msg.sender == timelock, "!timelock");

        devFundFee = _devFundFee;

    }



    function setTreasuryFee(uint256 _treasuryFee) external {

        require(msg.sender == timelock, "!timelock");

        treasuryFee = _treasuryFee;

    }



    function setPerformanceFee(uint256 _performanceFee) external {

        require(msg.sender == timelock, "!timelock");

        performanceFee = _performanceFee;

    }



    function setStrategist(address _strategist) external {

        require(msg.sender == governance, "!governance");

        strategist = _strategist;

    }



    function setGovernance(address _governance) external {

        require(msg.sender == governance, "!governance");

        governance = _governance;

    }



    function setTimelock(address _timelock) external {

        require(msg.sender == timelock, "!timelock");

        timelock = _timelock;

    }



    function setController(address _controller) external {

        require(msg.sender == timelock, "!timelock");

        controller = _controller;

    }



    function setMmToken(address _mmToken) external {

        require(msg.sender == governance, "!governance");

        mmToken = _mmToken;

    }



    function setBuybackEnabled(bool _buybackEnabled) external {

        require(msg.sender == governance, "!governance");

        buybackEnabled = _buybackEnabled;

    }



    function setMasterChef(address _masterChef) external {

        require(msg.sender == governance, "!governance");

        masterChef = _masterChef;

    }



    // **** State mutations **** //

    function deposit() public virtual;



    function withdraw(IERC20 _asset) external virtual returns (uint256 balance);



    // Controller only function for creating additional rewards from dust

    function _withdrawNonWantAsset(IERC20 _asset) internal returns (uint256 balance) {

        require(msg.sender == controller, "!controller");

        require(want != address(_asset), "want");

        balance = _asset.balanceOf(address(this));

        _asset.safeTransfer(controller, balance);

    }



    // Withdraw partial funds, normally used with a vault withdrawal

    function withdraw(uint256 _amount) external {

        require(msg.sender == controller, "!controller");

        uint256 _balance = IERC20(want).balanceOf(address(this));

        if (_balance < _amount) {

            _amount = _withdrawSome(_amount.sub(_balance));

            _amount = _amount.add(_balance);

        }

				

        uint256 _feeDev = _amount.mul(devFundFee).div(devFundMax);

        uint256 _feeTreasury = _amount.mul(treasuryFee).div(treasuryMax);



        if (buybackEnabled == true) {            

            // we want buyback mm using LP token

            (address _buybackPrinciple, uint256 _buybackAmount) = _convertWantToBuyback(_feeDev.add(_feeTreasury));

            buybackAndNotify(_buybackPrinciple, _buybackAmount);			

        } else {

            IERC20(want).safeTransfer(IController(controller).devfund(), _feeDev);

            IERC20(want).safeTransfer(IController(controller).treasury(), _feeTreasury);

        }        



        address _vault = IController(controller).vaults(address(want));

        require(_vault != address(0), "!vault"); // additional protection so we don't burn the funds



        IERC20(want).safeTransfer(_vault, _amount.sub(_feeDev).sub(_feeTreasury));

    }

	

    // buyback MM and notify MasterChef

    function buybackAndNotify(address _buybackPrinciple, uint256 _buybackAmount) internal {

        if (buybackEnabled == true) {

            _swapUniswap(_buybackPrinciple, mmToken, _buybackAmount);

            uint256 _mmBought = IERC20(mmToken).balanceOf(address(this));

            IERC20(mmToken).safeTransfer(masterChef, _mmBought);

            IMasterchef(masterChef).notifyBuybackReward(_mmBought);

        }

    }



    // Withdraw all funds, normally used when migrating strategies

    function withdrawAll() external returns (uint256 balance) {

        require(msg.sender == controller, "!controller");

        _withdrawAll();



        balance = IERC20(want).balanceOf(address(this));



        address _vault = IController(controller).vaults(address(want));

        require(_vault != address(0), "!vault"); // additional protection so we don't burn the funds

        IERC20(want).safeTransfer(_vault, balance);

    }



    function _withdrawAll() internal {

        _withdrawSome(balanceOfPool());

    }



    function _withdrawSome(uint256 _amount) internal virtual returns (uint256);	

	

    // convert LP to buyback principle token

    function _convertWantToBuyback(uint256 _lpAmount) internal virtual returns (address, uint256);



    function harvest() public virtual;



    // **** Emergency functions ****



    function execute(address _target, bytes memory _data)

        public

        payable

        returns (bytes memory response)

    {

        require(msg.sender == timelock, "!timelock");

        require(_target != address(0), "!target");



        // call contract in current context

        assembly {

            let succeeded := delegatecall(

                sub(gas(), 5000),

                _target,

                add(_data, 0x20),

                mload(_data),

                0,

                0

            )

            let size := returndatasize()



            response := mload(0x40)

            mstore(

                0x40,

                add(response, and(add(add(size, 0x20), 0x1f), not(0x1f)))

            )

            mstore(response, size)

            returndatacopy(add(response, 0x20), 0, size)



            switch iszero(succeeded)

                case 1 {

                    // throw if delegatecall failed

                    revert(add(response, 0x20), size)

                }

        }

    }



    // **** Internal functions ****

    function _swapUniswap(

        address _from,

        address _to,

        uint256 _amount

    ) internal {

        require(_to != address(0));

        if (_amount > 0){

            address[] memory sushipath;

            address[] memory path;

            address[] memory p;

            

            UniswapRouterV2 route;

            if (_to == mmToken){

                path = new address[](2);

                path[0] = _from;

                path[1] = _to;

                route = UniswapRouterV2(univ2Router2);

                p = path;

            } else{

                sushipath = new address[](3);

                sushipath[0] = _from;

                sushipath[1] = weth;	

                sushipath[2] = _to;

                route = UniswapRouterV2(sushiRouter);

                p = sushipath;

            }

            

            route.swapExactTokensForTokens(_amount, 0, p, address(this), now);

        }

    }



}



interface IAlchemixStakingPool {

    function claim ( uint256 _poolId ) external;

    function deposit ( uint256 _poolId, uint256 _depositAmount ) external;

    function exit ( uint256 _poolId ) external;

    function getPoolRewardWeight ( uint256 _poolId ) external view returns ( uint256 );

    function getPoolToken ( uint256 _poolId ) external view returns ( address );

    function getStakeTotalDeposited ( address _account, uint256 _poolId ) external view returns ( uint256 );

    function getStakeTotalUnclaimed ( address _account, uint256 _poolId ) external view returns ( uint256 );

    function withdraw ( uint256 _poolId, uint256 _withdrawAmount ) external;

}



interface ICurveSwap {

    function exchange_underlying(int128 i, int128 j, uint256 dx, uint256 min_dy) external returns (uint256);

}



contract StrategyAlchemixALUSD is StrategyBase {

    address public constant alcx = 0xdBdb4d16EdA451D0503b854CF79D55697F90c8DF;

    address public constant alusd = 0xBC6DA0FE9aD5f3b0d58160288917AA56653660E9;

    address public constant stakingPool = 0xAB8e74017a8Cc7c15FFcCd726603790d26d7DeCa;

    address public constant dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    address public constant usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    address public constant curveSwapAlcx = 0x43b4FdFD4Ff969587185cDB6f0BD875c5Fc83f8c;

    uint256 public constant stakingPoolId = 0;



    constructor(address _governance, address _strategist, address _controller, address _timelock) public 

    StrategyBase(alusd, _governance, _strategist, _controller, _timelock)

    {	

        IERC20(alusd).safeApprove(stakingPool, uint256(-1));

        IERC20(alusd).safeApprove(curveSwapAlcx, uint256(-1)); 

        IERC20(dai).safeApprove(curveSwapAlcx, uint256(-1)); 

        IERC20(alcx).safeApprove(sushiRouter, uint256(-1)); 

        IERC20(usdc).safeApprove(univ2Router2, uint256(-1)); 

    }

	

    // **** Views ****



    function getName() external override pure returns (string memory) {

        return "StrategyAlchemixALUSDV1";

    }



    function balanceOfPool() public override view returns (uint256) {

        return IAlchemixStakingPool(stakingPool).getStakeTotalDeposited(address(this), stakingPoolId);

    }



    function getHarvestable() external view returns (uint256) {

        return IAlchemixStakingPool(stakingPool).getStakeTotalUnclaimed(address(this), stakingPoolId);

    }	

	

    // **** Modifications ****



    function deposit() public override {

        uint256 _want = IERC20(want).balanceOf(address(this));

        if (_want > 0) {

            IAlchemixStakingPool(stakingPool).deposit(stakingPoolId, _want);

        }

    }



    // **** State Mutations ****



    function _withdrawSome(uint256 _amount) internal override returns (uint256){

        IAlchemixStakingPool(stakingPool).withdraw(stakingPoolId, _amount);

        return _amount;

    }

	

    function _convertWantToBuyback(uint256 _lpAmount) internal override returns (address, uint256){

        require(_lpAmount > 0, '!_lpAmount');		

        ICurveSwap(curveSwapAlcx).exchange_underlying(0, 2, _lpAmount, 0); // convert from alusd to usdc

        return (usdc, IERC20(usdc).balanceOf(address(this)));

    }



    function harvest() public override onlyBenevolent {

        // Collects ALCX tokens

        IAlchemixStakingPool(stakingPool).claim(stakingPoolId);

        uint256 _profit = IERC20(alcx).balanceOf(address(this));

        if (_profit > 0) {

            // convert from alcx to alusd: alcx -> eth -> dai -> alusd

            _swapUniswap(alcx, dai, _profit);

            ICurveSwap(curveSwapAlcx).exchange_underlying(1, 0, IERC20(dai).balanceOf(address(this)), 0); 

            uint256 _alusd = IERC20(alusd).balanceOf(address(this));

            (address _buybackPrinciple, uint256 _buybackAmount) = _convertWantToBuyback(_alusd.mul(performanceFee).div(performanceMax));

            buybackAndNotify(_buybackPrinciple, _buybackAmount);

            deposit();

        }

    }



    // Controller only function for creating additional rewards from dust

    function withdraw(IERC20 _asset) external override returns (uint256 balance) {

        balance = _withdrawNonWantAsset(_asset);

    }

}