// SPDX-License-Identifier: MIT

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

        // This method relies on extcodesize, which returns 0 for contracts in

        // construction, since the code is only stored at the end of the

        // constructor execution.



        uint256 size;

        // solhint-disable-next-line no-inline-assembly

        assembly { size := extcodesize(account) }

        return size > 0;

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



/**

 * @dev Contract module that helps prevent reentrant calls to a function.

 *

 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier

 * available, which can be applied to functions to make sure there are no nested

 * (reentrant) calls to them.

 *

 * Note that because there is a single `nonReentrant` guard, functions marked as

 * `nonReentrant` may not call one another. This can be worked around by making

 * those functions `private`, and then adding `external` `nonReentrant` entry

 * points to them.

 *

 * TIP: If you would like to learn more about reentrancy and alternative ways

 * to protect against it, check out our blog post

 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].

 */

contract ReentrancyGuard {

    // Booleans are more expensive than uint256 or any type that takes up a full

    // word because each write operation emits an extra SLOAD to first read the

    // slot's contents, replace the bits taken up by the boolean, and then write

    // back. This is the compiler's defense against contract upgrades and

    // pointer aliasing, and it cannot be disabled.



    // The values being non-zero value makes deployment a bit more expensive,

    // but in exchange the refund on every call to nonReentrant will be lower in

    // amount. Since refunds are capped to a percentage of the total

    // transaction's gas, it is best to keep them low in cases like this one, to

    // increase the likelihood of the full refund coming into effect.

    uint256 private constant _NOT_ENTERED = 1;

    uint256 private constant _ENTERED = 2;



    uint256 private _status;



    constructor () internal {

        _status = _NOT_ENTERED;

    }



    /**

     * @dev Prevents a contract from calling itself, directly or indirectly.

     * Calling a `nonReentrant` function from another `nonReentrant`

     * function is not supported. It is possible to prevent this from happening

     * by making the `nonReentrant` function external, and make it call a

     * `private` function that does the actual work.

     */

    modifier nonReentrant() {

        // On the first call to nonReentrant, _notEntered will be true

        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");



        // Any calls to nonReentrant after this point will fail

        _status = _ENTERED;



        _;



        // By storing the original value once again, a refund is triggered (see

        // https://eips.ethereum.org/EIPS/eip-2200)

        _status = _NOT_ENTERED;

    }

}



interface Burnable {

    function burn(uint256 amount) external returns (bool);

}



interface IStrategy {

    function rewards() external view returns (address);



    function gauge() external view returns (address);



    function underlying() external view returns (address);



    function timelock() external view returns (address);



    function vault() external view returns (address);



    function deposit() external;



    function withdraw(uint256) external;



    function withdrawAll() external returns (uint256);



    function balanceOf() external view returns (uint256);



    function harvest() external;



    function salvage(address) external;



    function setTimelock(address _timelock) external;



    function setGovernance(address _governance) external;



    function setTreasury(address _treasury) external;

}



contract YvsVault is ERC20, ReentrancyGuard {

    using SafeERC20 for IERC20;

    using Address for address;

    using SafeMath for uint256;



    IERC20 internal token;

    IERC20 internal yvs;



    // Underlying token address

    address public underlying;



    // Address of controller

    address public controller;



    // Minimum/maximum allowed to be invested

    uint256 public min = 9500;

    uint256 public constant max = 10000;



    // Burn fee on purchases

    uint256 public burnFee = 5000;

    uint256 public constant burnFeeMax = 7500;

    uint256 public constant burnFeeMin = 2500;

    uint256 public constant burnFeeBase = 10000;



    // Withdrawal fee

    uint256 public withdrawalFee = 25;

    uint256 public constant withdrawalFeeMax = 25;

    uint256 public constant withdrawalFeeBase = 10000;



    // Minimum deposit period

    uint256 public minDepositPeriod = 7 days;



    // Is the strategy active (inactive on deploy)

    bool public isActive = false;



    // Addresses

    address public governance;

    address public treasury;

    address public timelock;

    address public strategy;



    mapping(address => uint256) public depositBlocks;

    mapping(address => uint256) public deposits;

    mapping(address => uint256) public issued;

    mapping(address => uint256) public tiers;

    uint256[] public multiplierCosts;

    uint256 internal constant tierMultiplier = 5;

    uint256 internal constant tierBase = 100;

    uint256 public totalDeposited = 0;



    // EVENTS

    event Deposit(address indexed user, uint256 amount);

    event Withdraw(address indexed user, uint256 amount);

    event SharesIssued(address indexed user, uint256 amount);

    event SharesPurged(address indexed user, uint256 amount);

    event ClaimRewards(address indexed user, uint256 amount);

    event MultiplierPurchased(address indexed user, uint256 tiers, uint256 totalCost);



    constructor(address _underlying, address _yvs, address _governance, address _treasury, address _timelock)

        public

        ERC20(

            string(abi.encodePacked("yvsie ", ERC20(_underlying).name())),

            string(abi.encodePacked("yvs", ERC20(_underlying).symbol()))

        )

    {

        require(address(_underlying) != address(_yvs), "!underlying");



        _setupDecimals(ERC20(_underlying).decimals());

        token = IERC20(_underlying);

        yvs = IERC20(_yvs);

        underlying = _underlying;

        governance = _governance;

        treasury = _treasury;

        timelock = _timelock;



        // multiplier costs from tier 1 to 5

        multiplierCosts.push(5000000000000000000); // 5 $yvs

        multiplierCosts.push(10000000000000000000); // 10 $yvs

        multiplierCosts.push(20000000000000000000); // 20 $yvs

        multiplierCosts.push(40000000000000000000); // 40 $yvs

        multiplierCosts.push(80000000000000000000); // 80 $yvs

    }



    // Check the total underyling token balance to see if we should earn();

    function balance() public view returns (uint256) {

        return

            token.balanceOf(address(this)).add(

                IStrategy(strategy).balanceOf()

            );

    }



    // Sets whether deposits are accepted by the vault

    function setActive(bool _isActive) external isGovernance {

        isActive = _isActive;

    }



    // Set the minimum percentage of tokens that can be deposited to earn 

    function setMin(uint256 _min) external isGovernance {

        require(_min <= max, "min>max");

        min = _min;

    }



    // Set a new governance address, can only be triggered by the old address

    function setGovernance(address _governance) external isGovernance {

        governance = _governance;

    }



    // Set a new treasury address, can only be triggered by the governance

    function setTreasury(address _treasury) external isGovernance {

        treasury = _treasury;

    }



    // Set the timelock address, can only be triggered by the old address

    function setTimelock(address _timelock) external isTimelock {

        timelock = _timelock;

    }



    // Set a new strategy address, can only be triggered by the timelock

    function setStrategy(address _strategy) external isTimelock {

        require(IStrategy(_strategy).underlying() == address(token), '!underlying');

        strategy = _strategy;

    }



    // Set the controller address, can only be set once after deployment

    function setController(address _controller) external isGovernance {

        require(controller == address(0), "!controller");

        controller = _controller;

    }



    // Set the burn fee for multipliers

    function setBurnFee(uint256 _burnFee) public isTimelock {

        require(_burnFee <= burnFeeMax, 'max');

        require(_burnFee >= burnFeeMin, 'min');

        burnFee = _burnFee;

    }



    // Set withdrawal fee for the vault

    function setWithdrawalFee(uint256 _withdrawalFee) external isTimelock {

        require(_withdrawalFee <= withdrawalFeeMax, "!max");

        withdrawalFee = _withdrawalFee;

    }



    // Add a new multplier with the selected cost

    function addMultiplier(uint256 _cost) public isTimelock returns (uint256 index) {

        multiplierCosts.push(_cost);

        index = multiplierCosts.length - 1;

    }



    // Set new cost for multiplier, can only be triggered by the timelock

    function setMultiplier(uint256 index, uint256 _cost) public isTimelock {

        multiplierCosts[index] = _cost;

    }



    // Custom logic in here for how much of the underlying asset can be deposited

    // Sets the minimum required on-hand to keep small withdrawals cheap

    function available() public view returns (uint256) {

        return token.balanceOf(address(this)).mul(min).div(max);

    }



    // Deposits collected underlying assets into the strategy and starts earning

    function earn() public {

        require(isActive, 'earn: !active');

        require(strategy != address(0), 'earn: !strategy');

        uint256 _bal = available();

        token.safeTransfer(strategy, _bal);

        IStrategy(strategy).deposit();

    }



    // Deposits underlying assets from the user into the vault contract

    function deposit(uint256 _amount) public nonReentrant {

        require(!address(msg.sender).isContract() && msg.sender == tx.origin, "deposit: !contract");

        require(isActive, 'deposit: !vault');

        require(strategy != address(0), 'deposit: !strategy');

        

        uint256 _pool = balance();

        uint256 _before = token.balanceOf(address(this));

        token.safeTransferFrom(msg.sender, address(this), _amount);

        uint256 _after = token.balanceOf(address(this));

        _amount = _after.sub(_before); // Additional check for deflationary tokens

        deposits[msg.sender] = deposits[msg.sender].add(_amount);

        totalDeposited = totalDeposited.add(_amount);

        uint256 shares = 0;

        if (totalSupply() == 0) {

            uint256 userMultiplier = tiers[msg.sender].mul(tierMultiplier).add(tierBase); // 5 %, 10 %, 15 %, 20 %, 25 %

            shares = _amount.mul(userMultiplier).div(tierBase);

        } else {

            uint256 userMultiplier = tiers[msg.sender].mul(tierMultiplier).add(tierBase); // 5 %, 10 %, 15 %, 20 %, 25 %

            shares = (_amount.mul(userMultiplier).div(tierBase).mul(totalSupply())).div(_pool);

        }



        _mint(msg.sender, shares);

        issued[msg.sender] = issued[msg.sender].add(shares);

        depositBlocks[msg.sender] = block.number;

        emit Deposit(msg.sender, _amount);

        emit SharesIssued(msg.sender, shares);

    }



    // Deposits all the funds of the user

    function depositAll() external {

        deposit(token.balanceOf(msg.sender));

    }



    // No rebalance implementation for lower fees and faster swaps

    function withdraw(uint256 _amount) public nonReentrant {

        require(!address(msg.sender).isContract() && msg.sender == tx.origin, "withdraw: !no contract");

        require(block.number >= depositBlocks[msg.sender].add(minDepositPeriod), 'withdraw: !minDepositPeriod');

        require(_amount > 0, '!positive');

        require(_amount <= deposits[msg.sender], '>deposit');

        require(issued[msg.sender] > 0, '!deposit');



        // Get the amount of user shares

        uint256 shares = issued[msg.sender];

        // Calculate percentage of principal being withdrawn

        uint256 p = (_amount.mul(1e18).div(deposits[msg.sender]));

        // Calculate amount of shares to be burned

        uint256 r = shares.mul(p).div(1e18);



        // Make sure the user has the required amount in his balance

        require(balanceOf(msg.sender) >= r, "!shares");

        // Burn the proportion of shares that are being withdrawn

        _burn(msg.sender, r);

        // Reduce the amount from user's issued amount

        issued[msg.sender] = issued[msg.sender].sub(r);



        // Calculate amount of rewards the user has gained

        uint256 rewards = balance().sub(totalDeposited);

        uint256 userRewards = 0;

        if (rewards > 0) {

            userRewards = (rewards.mul(shares)).div(totalSupply());

        }



        // Receive the correct proportion of the rewards

        if (userRewards > 0) {

            userRewards = userRewards.mul(p).div(1e18);

        }



        // Calculate the withdrawal amount as _amount + user rewards

        uint256 withdrawAmount = _amount.add(userRewards);



        // Check balance

        uint256 b = token.balanceOf(address(this));

        if (b < withdrawAmount) {

            uint256 _withdraw = withdrawAmount.sub(b);

            IStrategy(strategy).withdraw(_withdraw);

            uint256 _after = token.balanceOf(address(this));

            uint256 _diff = _after.sub(b);

            if (_diff < _withdraw) {

                withdrawAmount = b.add(_diff);

            }

        }



        // Remove the withdrawn principal from total and user deposits

        deposits[msg.sender] = deposits[msg.sender].sub(_amount);

        totalDeposited = totalDeposited.sub(_amount);



        // Calculate withdrawal fee and deduct from amount

        uint256 _withdrawalFee = _amount.mul(withdrawalFee).div(withdrawalFeeBase);

        token.safeTransfer(treasury, _withdrawalFee);

        token.safeTransfer(msg.sender, withdrawAmount.sub(_withdrawalFee));



        // Emit events

        emit Withdraw(msg.sender, _amount);

        emit SharesPurged(msg.sender, r);

        emit ClaimRewards(msg.sender, userRewards);

    }



    // Withdraws all underlying assets belonging to the user

    function withdrawAll() external {

        withdraw(deposits[msg.sender]);

    }



    function pendingRewards(address account) external view returns (uint256 pending) {

        // Calculate amount of rewards the user has gained

        uint256 rewards = balance().sub(totalDeposited);

        uint256 shares = issued[account];

        if (rewards > 0) {

            pending = (rewards.mul(shares)).div(totalSupply());

        }

    }



    // Purchase a multiplier tier for the user

    function purchaseMultiplier(uint256 _tiers) external returns (uint256 newTier) {

        require(isActive, '!active');

        require(strategy != address(0), '!strategy');

        require(_tiers > 0, '!tiers');

        uint256 multipliersLength = multiplierCosts.length;

        require(tiers[msg.sender].add(_tiers) <= multipliersLength, '!max');



        uint256 totalCost = 0;

        uint256 lastMultiplier = tiers[msg.sender].add(_tiers);

        for (uint256 i = tiers[msg.sender]; i < multipliersLength; i++) {

            if (i == lastMultiplier) {

                break;

            }

            totalCost = totalCost.add(multiplierCosts[i]);

        }



        require(IERC20(yvs).balanceOf(msg.sender) >= totalCost, '!yvs');

        yvs.safeTransferFrom(msg.sender, address(this), totalCost);

        newTier = tiers[msg.sender].add(_tiers);

        tiers[msg.sender] = newTier;

        emit MultiplierPurchased(msg.sender, _tiers, totalCost);

    }



    // Distribute the YVS tokens collected by the multiplier purchases

    function distribute() external restricted {

        uint256 b = yvs.balanceOf(address(this));

        if (b > 0) {

            uint256 toBurn = b.mul(burnFee).div(burnFeeBase);

            uint256 leftover = b.sub(toBurn);

            Burnable(address(yvs)).burn(toBurn);

            yvs.safeTransfer(treasury, leftover);

        }

    }



    // Used to salvage any non-underlying assets to governance

    function salvage(address reserve, uint256 amount) external isGovernance {

        require(reserve != address(token), "!token");

        require(reserve != address(yvs), "!yvs");

        IERC20(reserve).safeTransfer(treasury, amount);

    }



    // Returns the current multiplier tier for the user

    function getMultiplier() external view returns (uint256) {

        return tiers[msg.sender];

    }



    // Returns the next multiplier tier cost for the user

    function getNextMultiplierCost() external view returns (uint256) {

        require(tiers[msg.sender] < multiplierCosts.length, '!all');

        return multiplierCosts[tiers[msg.sender]];

    }



    // Returns the total number of multipliers

    function getCountOfMultipliers() external view returns (uint256) {

        return multiplierCosts.length;

    }



    // Returns the current ratio between earned assets and deposited assets

    function getRatio() public view returns (uint256) {

        return (balance().sub(totalDeposited)).mul(1e18).div(totalSupply());

    }



    // **** Modifiers **** //



    modifier restricted {

        require(

            (msg.sender == tx.origin && !address(msg.sender).isContract()) ||

                msg.sender == governance ||

                msg.sender == controller

        );



        _;

    }



    modifier isTimelock {

        require(

            msg.sender == timelock, 

            "!timelock"

        );



        _;

    }



    modifier isGovernance {

        require(

            msg.sender == governance, 

            "!governance"

        );



        _;

    }

}