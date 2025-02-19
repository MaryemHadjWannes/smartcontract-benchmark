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

     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.

     * @dev Get it via `npm install @openzeppelin/contracts@next`.

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



     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.

     * @dev Get it via `npm install @openzeppelin/contracts@next`.

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

     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.

     * @dev Get it via `npm install @openzeppelin/contracts@next`.

     */

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}





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





/**

 * @dev Elliptic Curve Digital Signature Algorithm (ECDSA) operations.

 *

 * These functions can be used to verify that a message was signed by the holder

 * of the private keys of a given address.

 */

library ECDSA {

    /**

     * @dev Returns the address that signed a hashed message (`hash`) with

     * `signature`. This address can then be used for verification purposes.

     *

     * The `ecrecover` EVM opcode allows for malleable (non-unique) signatures:

     * this function rejects them by requiring the `s` value to be in the lower

     * half order, and the `v` value to be either 27 or 28.

     *

     * NOTE: This call _does not revert_ if the signature is invalid, or

     * if the signer is otherwise unable to be retrieved. In those scenarios,

     * the zero address is returned.

     *

     * IMPORTANT: `hash` _must_ be the result of a hash operation for the

     * verification to be secure: it is possible to craft signatures that

     * recover to arbitrary addresses for non-hashed data. A safe way to ensure

     * this is by receiving a hash of the original message (which may otherwise)

     * be too long), and then calling {toEthSignedMessageHash} on it.

     */

    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {

        // Check the signature length

        if (signature.length != 65) {

            return (address(0));

        }



        // Divide the signature in r, s and v variables

        bytes32 r;

        bytes32 s;

        uint8 v;



        // ecrecover takes the signature parameters, and the only way to get them

        // currently is to use assembly.

        // solhint-disable-next-line no-inline-assembly

        assembly {

            r := mload(add(signature, 0x20))

            s := mload(add(signature, 0x40))

            v := byte(0, mload(add(signature, 0x60)))

        }



        // EIP-2 still allows signature malleability for ecrecover(). Remove this possibility and make the signature

        // unique. Appendix F in the Ethereum Yellow paper (https://ethereum.github.io/yellowpaper/paper.pdf), defines

        // the valid range for s in (281): 0 < s < secp256k1n ÷ 2 + 1, and for v in (282): v ∈ {27, 28}. Most

        // signatures from current libraries generate a unique signature with an s-value in the lower half order.

        //

        // If your library generates malleable signatures, such as s-values in the upper range, calculate a new s-value

        // with 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - s1 and flip v from 27 to 28 or

        // vice versa. If your library also generates signatures with 0/1 for v instead 27/28, add 27 to v to accept

        // these malleable signatures as well.

        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {

            return address(0);

        }



        if (v != 27 && v != 28) {

            return address(0);

        }



        // If the signature is valid (and not malleable), return the signer address

        return ecrecover(hash, v, r, s);

    }



    /**

     * @dev Returns an Ethereum Signed Message, created from a `hash`. This

     * replicates the behavior of the

     * https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_sign[`eth_sign`]

     * JSON-RPC method.

     *

     * See {recover}.

     */

    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {

        // 32 is the length in bytes of hash,

        // enforced by the type signature above

        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));

    }

}







library IndexedMerkleProof {

    function compute(bytes memory proof, uint160 leaf) internal pure returns (uint160 root, uint256 index) {

        uint160 computedHash = leaf;



        for (uint256 i = 0; i < proof.length / 20; i++) {

            uint160 proofElement;

            // solium-disable-next-line security/no-inline-assembly

            assembly {

                proofElement := div(mload(add(proof, add(32, mul(i, 20)))), 0x1000000000000000000000000)

            }



            if (computedHash < proofElement) {

                // Hash(current computed hash + current element of the proof)

                computedHash = uint160(uint256(keccak256(abi.encodePacked(computedHash, proofElement))));

                index += (1 << i);

            } else {

                // Hash(current element of the proof + current computed hash)

                computedHash = uint160(uint256(keccak256(abi.encodePacked(proofElement, computedHash))));

            }

        }



        return (computedHash, index);

    }

}





/*

 * @dev Interface for a contract that will be called via the GSN from RelayHub.

 */

contract IRelayRecipient {

    /**

     * @dev Returns the address of the RelayHub instance this recipient interacts with.

     */

    function getHubAddr() public view returns (address);



    function acceptRelayedCall(

        address relay,

        address from,

        bytes calldata encodedFunction,

        uint256 transactionFee,

        uint256 gasPrice,

        uint256 gasLimit,

        uint256 nonce,

        bytes calldata approvalData,

        uint256 maxPossibleCharge

    )

        external

        view

        returns (uint256, bytes memory);



    function preRelayedCall(bytes calldata context) external returns (bytes32);



    function postRelayedCall(bytes calldata context, bool success, uint actualCharge, bytes32 preRetVal) external;

}





/*

 * @dev Base contract used to implement GSNBouncers.

 *

 * > This contract does not perform all required tasks to implement a GSN

 * recipient contract: end users should use `GSNRecipient` instead.

 */

contract GSNBouncerBase is IRelayRecipient {

    uint256 constant private RELAYED_CALL_ACCEPTED = 0;

    uint256 constant private RELAYED_CALL_REJECTED = 11;



    // How much gas is forwarded to postRelayedCall

    uint256 constant internal POST_RELAYED_CALL_MAX_GAS = 100000;



    // Base implementations for pre and post relayedCall: only RelayHub can invoke them, and data is forwarded to the

    // internal hook.



    /**

     * @dev See `IRelayRecipient.preRelayedCall`.

     *

     * This function should not be overriden directly, use `_preRelayedCall` instead.

     *

     * * Requirements:

     *

     * - the caller must be the `RelayHub` contract.

     */

    function preRelayedCall(bytes calldata context) external returns (bytes32) {

        require(msg.sender == getHubAddr(), "GSNBouncerBase: caller is not RelayHub");

        return _preRelayedCall(context);

    }



    /**

     * @dev See `IRelayRecipient.postRelayedCall`.

     *

     * This function should not be overriden directly, use `_postRelayedCall` instead.

     *

     * * Requirements:

     *

     * - the caller must be the `RelayHub` contract.

     */

    function postRelayedCall(bytes calldata context, bool success, uint256 actualCharge, bytes32 preRetVal) external {

        require(msg.sender == getHubAddr(), "GSNBouncerBase: caller is not RelayHub");

        _postRelayedCall(context, success, actualCharge, preRetVal);

    }



    /**

     * @dev Return this in acceptRelayedCall to proceed with the execution of a relayed call. Note that this contract

     * will be charged a fee by RelayHub

     */

    function _approveRelayedCall() internal pure returns (uint256, bytes memory) {

        return _approveRelayedCall("");

    }



    /**

     * @dev See `GSNBouncerBase._approveRelayedCall`.

     *

     * This overload forwards `context` to _preRelayedCall and _postRelayedCall.

     */

    function _approveRelayedCall(bytes memory context) internal pure returns (uint256, bytes memory) {

        return (RELAYED_CALL_ACCEPTED, context);

    }



    /**

     * @dev Return this in acceptRelayedCall to impede execution of a relayed call. No fees will be charged.

     */

    function _rejectRelayedCall(uint256 errorCode) internal pure returns (uint256, bytes memory) {

        return (RELAYED_CALL_REJECTED + errorCode, "");

    }



    // Empty hooks for pre and post relayed call: users only have to define these if they actually use them.



    function _preRelayedCall(bytes memory) internal returns (bytes32) {

        // solhint-disable-previous-line no-empty-blocks

    }



    function _postRelayedCall(bytes memory, bool, uint256, bytes32) internal {

        // solhint-disable-previous-line no-empty-blocks

    }



    /*

     * @dev Calculates how much RelaHub will charge a recipient for using `gas` at a `gasPrice`, given a relayer's

     * `serviceFee`.

     */

    function _computeCharge(uint256 gas, uint256 gasPrice, uint256 serviceFee) internal pure returns (uint256) {

        // The fee is expressed as a percentage. E.g. a value of 40 stands for a 40% fee, so the recipient will be

        // charged for 1.4 times the spent amount.

        return (gas * gasPrice * (100 + serviceFee)) / 100;

    }

}





contract IRelayHub {

    // Relay management



    // Add stake to a relay and sets its unstakeDelay.

    // If the relay does not exist, it is created, and the caller

    // of this function becomes its owner. If the relay already exists, only the owner can call this function. A relay

    // cannot be its own owner.

    // All Ether in this function call will be added to the relay's stake.

    // Its unstake delay will be assigned to unstakeDelay, but the new value must be greater or equal to the current one.

    // Emits a Staked event.

    function stake(address relayaddr, uint256 unstakeDelay) external payable;



    // Emited when a relay's stake or unstakeDelay are increased

    event Staked(address indexed relay, uint256 stake, uint256 unstakeDelay);



    // Registers the caller as a relay.

    // The relay must be staked for, and not be a contract (i.e. this function must be called directly from an EOA).

    // Emits a RelayAdded event.

    // This function can be called multiple times, emitting new RelayAdded events. Note that the received transactionFee

    // is not enforced by relayCall.

    function registerRelay(uint256 transactionFee, string memory url) public;



    // Emitted when a relay is registered or re-registerd. Looking at these events (and filtering out RelayRemoved

    // events) lets a client discover the list of available relays.

    event RelayAdded(address indexed relay, address indexed owner, uint256 transactionFee, uint256 stake, uint256 unstakeDelay, string url);



    // Removes (deregisters) a relay. Unregistered (but staked for) relays can also be removed. Can only be called by

    // the owner of the relay. After the relay's unstakeDelay has elapsed, unstake will be callable.

    // Emits a RelayRemoved event.

    function removeRelayByOwner(address relay) public;



    // Emitted when a relay is removed (deregistered). unstakeTime is the time when unstake will be callable.

    event RelayRemoved(address indexed relay, uint256 unstakeTime);



    // Deletes the relay from the system, and gives back its stake to the owner. Can only be called by the relay owner,

    // after unstakeDelay has elapsed since removeRelayByOwner was called.

    // Emits an Unstaked event.

    function unstake(address relay) public;



    // Emitted when a relay is unstaked for, including the returned stake.

    event Unstaked(address indexed relay, uint256 stake);



    // States a relay can be in

    enum RelayState {

        Unknown, // The relay is unknown to the system: it has never been staked for

        Staked, // The relay has been staked for, but it is not yet active

        Registered, // The relay has registered itself, and is active (can relay calls)

        Removed    // The relay has been removed by its owner and can no longer relay calls. It must wait for its unstakeDelay to elapse before it can unstake

    }



    // Returns a relay's status. Note that relays can be deleted when unstaked or penalized.

    function getRelay(address relay) external view returns (uint256 totalStake, uint256 unstakeDelay, uint256 unstakeTime, address payable owner, RelayState state);



    // Balance management



    // Deposits ether for a contract, so that it can receive (and pay for) relayed transactions. Unused balance can only

    // be withdrawn by the contract itself, by callingn withdraw.

    // Emits a Deposited event.

    function depositFor(address target) public payable;



    // Emitted when depositFor is called, including the amount and account that was funded.

    event Deposited(address indexed recipient, address indexed from, uint256 amount);



    // Returns an account's deposits. These can be either a contnract's funds, or a relay owner's revenue.

    function balanceOf(address target) external view returns (uint256);



    // Withdraws from an account's balance, sending it back to it. Relay owners call this to retrieve their revenue, and

    // contracts can also use it to reduce their funding.

    // Emits a Withdrawn event.

    function withdraw(uint256 amount, address payable dest) public;



    // Emitted when an account withdraws funds from RelayHub.

    event Withdrawn(address indexed account, address indexed dest, uint256 amount);



    // Relaying



    // Check if the RelayHub will accept a relayed operation. Multiple things must be true for this to happen:

    //  - all arguments must be signed for by the sender (from)

    //  - the sender's nonce must be the current one

    //  - the recipient must accept this transaction (via acceptRelayedCall)

    // Returns a PreconditionCheck value (OK when the transaction can be relayed), or a recipient-specific error code if

    // it returns one in acceptRelayedCall.

    function canRelay(

        address relay,

        address from,

        address to,

        bytes memory encodedFunction,

        uint256 transactionFee,

        uint256 gasPrice,

        uint256 gasLimit,

        uint256 nonce,

        bytes memory signature,

        bytes memory approvalData

    ) public view returns (uint256 status, bytes memory recipientContext);



    // Preconditions for relaying, checked by canRelay and returned as the corresponding numeric values.

    enum PreconditionCheck {

        OK,                         // All checks passed, the call can be relayed

        WrongSignature,             // The transaction to relay is not signed by requested sender

        WrongNonce,                 // The provided nonce has already been used by the sender

        AcceptRelayedCallReverted,  // The recipient rejected this call via acceptRelayedCall

        InvalidRecipientStatusCode  // The recipient returned an invalid (reserved) status code

    }



    // Relays a transaction. For this to suceed, multiple conditions must be met:

    //  - canRelay must return PreconditionCheck.OK

    //  - the sender must be a registered relay

    //  - the transaction's gas price must be larger or equal to the one that was requested by the sender

    //  - the transaction must have enough gas to not run out of gas if all internal transactions (calls to the

    // recipient) use all gas available to them

    //  - the recipient must have enough balance to pay the relay for the worst-case scenario (i.e. when all gas is

    // spent)

    //

    // If all conditions are met, the call will be relayed and the recipient charged. preRelayedCall, the encoded

    // function and postRelayedCall will be called in order.

    //

    // Arguments:

    //  - from: the client originating the request

    //  - recipient: the target IRelayRecipient contract

    //  - encodedFunction: the function call to relay, including data

    //  - transactionFee: fee (%) the relay takes over actual gas cost

    //  - gasPrice: gas price the client is willing to pay

    //  - gasLimit: gas to forward when calling the encoded function

    //  - nonce: client's nonce

    //  - signature: client's signature over all previous params, plus the relay and RelayHub addresses

    //  - approvalData: dapp-specific data forwared to acceptRelayedCall. This value is *not* verified by the Hub, but

    //    it still can be used for e.g. a signature.

    //

    // Emits a TransactionRelayed event.

    function relayCall(

        address from,

        address to,

        bytes memory encodedFunction,

        uint256 transactionFee,

        uint256 gasPrice,

        uint256 gasLimit,

        uint256 nonce,

        bytes memory signature,

        bytes memory approvalData

    ) public;



    // Emitted when an attempt to relay a call failed. This can happen due to incorrect relayCall arguments, or the

    // recipient not accepting the relayed call. The actual relayed call was not executed, and the recipient not charged.

    // The reason field contains an error code: values 1-10 correspond to PreconditionCheck entries, and values over 10

    // are custom recipient error codes returned from acceptRelayedCall.

    event CanRelayFailed(address indexed relay, address indexed from, address indexed to, bytes4 selector, uint256 reason);



    // Emitted when a transaction is relayed. Note that the actual encoded function might be reverted: this will be

    // indicated in the status field.

    // Useful when monitoring a relay's operation and relayed calls to a contract.

    // Charge is the ether value deducted from the recipient's balance, paid to the relay's owner.

    event TransactionRelayed(address indexed relay, address indexed from, address indexed to, bytes4 selector, RelayCallStatus status, uint256 charge);



    // Reason error codes for the TransactionRelayed event

    enum RelayCallStatus {

        OK,                      // The transaction was successfully relayed and execution successful - never included in the event

        RelayedCallFailed,       // The transaction was relayed, but the relayed call failed

        PreRelayedFailed,        // The transaction was not relayed due to preRelatedCall reverting

        PostRelayedFailed,       // The transaction was relayed and reverted due to postRelatedCall reverting

        RecipientBalanceChanged  // The transaction was relayed and reverted due to the recipient's balance changing

    }



    // Returns how much gas should be forwarded to a call to relayCall, in order to relay a transaction that will spend

    // up to relayedCallStipend gas.

    function requiredGas(uint256 relayedCallStipend) public view returns (uint256);



    // Returns the maximum recipient charge, given the amount of gas forwarded, gas price and relay fee.

    function maxPossibleCharge(uint256 relayedCallStipend, uint256 gasPrice, uint256 transactionFee) public view returns (uint256);



    // Relay penalization. Any account can penalize relays, removing them from the system immediately, and rewarding the

    // reporter with half of the relay's stake. The other half is burned so that, even if the relay penalizes itself, it

    // still loses half of its stake.



    // Penalize a relay that signed two transactions using the same nonce (making only the first one valid) and

    // different data (gas price, gas limit, etc. may be different). The (unsigned) transaction data and signature for

    // both transactions must be provided.

    function penalizeRepeatedNonce(bytes memory unsignedTx1, bytes memory signature1, bytes memory unsignedTx2, bytes memory signature2) public;



    // Penalize a relay that sent a transaction that didn't target RelayHub's registerRelay or relayCall.

    function penalizeIllegalTransaction(bytes memory unsignedTx, bytes memory signature) public;



    event Penalized(address indexed relay, address sender, uint256 amount);



    function getNonce(address from) external view returns (uint256);

}







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

     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.

     * @dev Get it via `npm install @openzeppelin/contracts@next`.

     */

    function toPayable(address account) internal pure returns (address payable) {

        return address(uint160(account));

    }

}





/*

 * @dev Provides information about the current execution context, including the

 * sender of the transaction and its data. While these are generally available

 * via msg.sender and msg.data, they not should not be accessed in such a direct

 * manner, since when dealing with GSN meta-transactions the account sending and

 * paying for execution may not be the actual sender (as far as an application

 * is concerned).

 *

 * This contract is only required for intermediate, library-like contracts.

 */

contract Context {

    // Empty internal constructor, to prevent people from mistakenly deploying

    // an instance of this contract, with should be used via inheritance.

    constructor () internal { }

    // solhint-disable-previous-line no-empty-blocks



    function _msgSender() internal view returns (address) {

        return msg.sender;

    }



    function _msgData() internal view returns (bytes memory) {

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

        return msg.data;

    }

}









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





/*

 * @dev Enables GSN support on `Context` contracts by recognizing calls from

 * RelayHub and extracting the actual sender and call data from the received

 * calldata.

 *

 * > This contract does not perform all required tasks to implement a GSN

 * recipient contract: end users should use `GSNRecipient` instead.

 */

contract GSNContext is Context {

    address internal _relayHub = 0xD216153c06E857cD7f72665E0aF1d7D82172F494;



    event RelayHubChanged(address indexed oldRelayHub, address indexed newRelayHub);



    constructor() internal {

        // solhint-disable-previous-line no-empty-blocks

    }



    function _upgradeRelayHub(address newRelayHub) internal {

        address currentRelayHub = _relayHub;

        require(newRelayHub != address(0), "GSNContext: new RelayHub is the zero address");

        require(newRelayHub != currentRelayHub, "GSNContext: new RelayHub is the current one");



        emit RelayHubChanged(currentRelayHub, newRelayHub);



        _relayHub = newRelayHub;

    }



    // Overrides for Context's functions: when called from RelayHub, sender and

    // data require some pre-processing: the actual sender is stored at the end

    // of the call data, which in turns means it needs to be removed from it

    // when handling said data.



    function _msgSender() internal view returns (address) {

        if (msg.sender != _relayHub) {

            return msg.sender;

        } else {

            return _getRelayedCallSender();

        }

    }



    function _msgData() internal view returns (bytes memory) {

        if (msg.sender != _relayHub) {

            return msg.data;

        } else {

            return _getRelayedCallData();

        }

    }



    function _getRelayedCallSender() private pure returns (address result) {

        // We need to read 20 bytes (an address) located at array index msg.data.length - 20. In memory, the array

        // is prefixed with a 32-byte length value, so we first add 32 to get the memory read index. However, doing

        // so would leave the address in the upper 20 bytes of the 32-byte word, which is inconvenient and would

        // require bit shifting. We therefore subtract 12 from the read index so the address lands on the lower 20

        // bytes. This can always be done due to the 32-byte prefix.



        // The final memory read index is msg.data.length - 20 + 32 - 12 = msg.data.length. Using inline assembly is the

        // easiest/most-efficient way to perform this operation.



        // These fields are not accessible from assembly

        bytes memory array = msg.data;

        uint256 index = msg.data.length;



        // solhint-disable-next-line no-inline-assembly

        assembly {

            // Load the 32 bytes word from memory with the address on the lower 20 bytes, and mask those.

            result := and(mload(add(array, index)), 0xffffffffffffffffffffffffffffffffffffffff)

        }

        return result;

    }



    function _getRelayedCallData() private pure returns (bytes memory) {

        // RelayHub appends the sender address at the end of the calldata, so in order to retrieve the actual msg.data,

        // we must strip the last 20 bytes (length of an address type) from it.



        uint256 actualDataLength = msg.data.length - 20;

        bytes memory actualData = new bytes(actualDataLength);



        for (uint256 i = 0; i < actualDataLength; ++i) {

            actualData[i] = msg.data[i];

        }



        return actualData;

    }

}











/*

 * @dev Base GSN recipient contract, adding the recipient interface and enabling

 * GSN support. Not all interface methods are implemented, derived contracts

 * must do so themselves.

 */

contract GSNRecipient is IRelayRecipient, GSNContext, GSNBouncerBase {

    /**

     * @dev Returns the RelayHub address for this recipient contract.

     */

    function getHubAddr() public view returns (address) {

        return _relayHub;

    }



    /**

     * @dev This function returns the version string of the RelayHub for which

     * this recipient implementation was built. It's not currently used, but

     * may be used by tooling.

     */

    // This function is view for future-proofing, it may require reading from

    // storage in the future.

    function relayHubVersion() public view returns (string memory) {

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

        return "1.0.0";

    }



    /**

     * @dev Triggers a withdraw of the recipient's deposits in RelayHub. Can

     * be used by derived contracts to expose the functionality in an external

     * interface.

     */

    function _withdrawDeposits(uint256 amount, address payable payee) internal {

        IRelayHub(_relayHub).withdraw(amount, payee);

    }

}



















contract BeerPoolContract is Ownable, GSNRecipient {

    using SafeMath for uint;

    using ECDSA for bytes;

    using IndexedMerkleProof for bytes;

    using SafeERC20 for IERC20;



    uint256 public constant STAKING_DURATION = 30 minutes;



    IERC20 dai = IERC20(0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359);

    uint160 merkleRoot;

    uint256 amountPerUser;

    mapping(address => uint256) stakedAt;

    uint256[1000000] redeemBitMask;



    constructor(uint160 root, uint256 amount) public {

        merkleRoot = root;

        amountPerUser = amount;

    }



    function withdrawDeposits(uint256 amount, address payable payee) public onlyOwner {

        _withdrawDeposits(amount, payee);

    }



    function acceptRelayedCall(

        address /*relay*/,

        address from,

        bytes memory encodedFunction,

        uint256 /*transactionFee*/,

        uint256 /*gasPrice*/,

        uint256 /*gasLimit*/,

        uint256 /*nonce*/,

        bytes memory /*approvalData*/,

        uint256 /*maxPossibleCharge*/

    ) public view returns (uint256, bytes memory) {



        // "Stack too deep" resolver

        address sender = from;



        bytes32 method;

        bytes memory merkleProof;

        assembly {

            method := mload(encodedFunction)

            merkleProof := add(encodedFunction, 36)

        }



        if (bytes4(method) == this.stake.selector) {

            (uint160 root,) = merkleProof.compute(uint160(sender));

            if (root == merkleRoot && stakedAt[sender] == 0) {

                return _approveRelayedCall();

            }

        }



        if (bytes4(method) == this.redeem.selector) {

            (uint160 root, uint256 index) = merkleProof.compute(uint160(sender));

            if (root == merkleRoot && stakedAt[sender] != 0 && now >= stakedAt[sender] + STAKING_DURATION && !wasRedeemed(index)) {

                return _approveRelayedCall();

            }

        }



        return _rejectRelayedCall(777);

    }



    function wasRedeemed(uint index) public view returns(bool) {

        return redeemBitMask[index / 256] & (1 << (index % 256)) != 0;

    }



    function wasRedeemedByWalletAndProof(address wallet, bytes memory merkleProof) public view returns(bool) {

        (uint160 root, uint256 index) = merkleProof.compute(uint160(wallet));

        require(root == merkleRoot, "Merkle root doesn't match");

        return wasRedeemed(index);

    }



    function stake(bytes memory merkleProof) public {

        (uint160 root,) = merkleProof.compute(uint160(_msgSender()));

        require(root == merkleRoot);

        require(stakedAt[_msgSender()] == 0);



        stakedAt[_msgSender()] = now;

    }



    function redeem(bytes memory merkleProof) public {

        (uint160 root, uint256 index) = merkleProof.compute(uint160(_msgSender()));

        require(root == merkleRoot);

        require(stakedAt[_msgSender()] != 0 && now >= stakedAt[_msgSender()] + STAKING_DURATION);

        require(!wasRedeemed(index));



        redeemBitMask[index / 256] |= (1 << (index % 256));

        dai.safeTransfer(_msgSender(), amountPerUser);

    }



    function abortAndRetrieve(IERC20 token) public onlyOwner {

        if (token == IERC20(0)) {

            msg.sender.transfer(address(this).balance);

        } else {

            token.safeTransfer(msg.sender, token.balanceOf(address(this)));

        }

    }

}