pragma solidity ^0.4.20;





/**

 * @title SafeMath

 * @dev Math operations with safety checks that throw on error

 */

library SafeMath {



    /**

    * @dev Multiplies two numbers, throws on overflow.

    */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }

        uint256 c = a * b;

        assert(c / a == b);

        return c;

    }



    /**

    * @dev Integer division of two numbers, truncating the quotient.

    */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        // assert(b > 0); // Solidity automatically throws when dividing by 0

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;

    }



    /**

    * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).

    */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        assert(b <= a);

        return a - b;

    }



    /**

    * @dev Adds two numbers, throws on overflow.

    */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        assert(c >= a);

        return c;

    }

}





/**

 * @title ERC20Basic

 * @dev Simpler version of ERC20 interface

 * @dev see https://github.com/ethereum/EIPs/issues/179

 */

contract ERC20Basic {

    function totalSupply() public view returns (uint256);

    function balanceOf(address who) public view returns (uint256);

    function transfer(address to, uint256 value) public returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

}





/**

 * @title ERC20 interface

 * @dev see https://github.com/ethereum/EIPs/issues/20

 */

contract ERC20 is ERC20Basic {

    function allowance(address owner, address spender) public view returns (uint256);

    function transferFrom(address from, address to, uint256 value) public returns (bool);

    function approve(address spender, uint256 value) public returns (bool);

    event Approval(address indexed owner, address indexed spender, uint256 value);

}





/**

 * @title Basic token

 * @dev Basic version of StandardToken, with no allowances.

 */

contract BasicToken is ERC20Basic {

    using SafeMath for uint256;



    mapping(address => uint256) balances;



    uint256 totalSupply_;



    /**

    * @dev total number of tokens in existence

    */

    function totalSupply() public view returns (uint256) {

        return totalSupply_;

    }



    /**

    * @dev transfer token for a specified address

    * @param _to The address to transfer to.

    * @param _value The amount to be transferred.

    */

    function transfer(address _to, uint256 _value) public returns (bool) {

        require(_to != address(0));

        require(_value <= balances[msg.sender]);



        // SafeMath.sub will throw if there is not enough balance.

        balances[msg.sender] = balances[msg.sender].sub(_value);

        balances[_to] = balances[_to].add(_value);

        Transfer(msg.sender, _to, _value);

        return true;

    }



    /**

    * @dev Gets the balance of the specified address.

    * @param _owner The address to query the the balance of.

    * @return An uint256 representing the amount owned by the passed address.

    */

    function balanceOf(address _owner) public view returns (uint256 balance) {

        return balances[_owner];

    }



}



/**

 * @title Standard ERC20 token

 *

 * @dev Implementation of the basic standard token.

 * @dev https://github.com/ethereum/EIPs/issues/20

 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol

 */

contract StandardToken is ERC20, BasicToken {



    mapping (address => mapping (address => uint256)) internal allowed;





    /**

     * @dev Transfer tokens from one address to another

     * @param _from address The address which you want to send tokens from

     * @param _to address The address which you want to transfer to

     * @param _value uint256 the amount of tokens to be transferred

     */

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {

        require(_to != address(0));

        require(_value <= balances[_from]);

        require(_value <= allowed[_from][msg.sender]);



        balances[_from] = balances[_from].sub(_value);

        balances[_to] = balances[_to].add(_value);

        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);

        Transfer(_from, _to, _value);

        return true;

    }



    /**

     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.

     *

     * Beware that changing an allowance with this method brings the risk that someone may use both the old

     * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this

     * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:

     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

     * @param _spender The address which will spend the funds.

     * @param _value The amount of tokens to be spent.

     */

    function approve(address _spender, uint256 _value) public returns (bool) {

        allowed[msg.sender][_spender] = _value;

        Approval(msg.sender, _spender, _value);

        return true;

    }



    /**

     * @dev Function to check the amount of tokens that an owner allowed to a spender.

     * @param _owner address The address which owns the funds.

     * @param _spender address The address which will spend the funds.

     * @return A uint256 specifying the amount of tokens still available for the spender.

     */

    function allowance(address _owner, address _spender) public view returns (uint256) {

        return allowed[_owner][_spender];

    }



    /**

     * @dev Increase the amount of tokens that an owner allowed to a spender.

     *

     * approve should be called when allowed[_spender] == 0. To increment

     * allowed value is better to use this function to avoid 2 calls (and wait until

     * the first transaction is mined)

     * From MonolithDAO Token.sol

     * @param _spender The address which will spend the funds.

     * @param _addedValue The amount of tokens to increase the allowance by.

     */

    function increaseApproval(address _spender, uint _addedValue) public returns (bool) {

        allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);

        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

        return true;

    }



    /**

     * @dev Decrease the amount of tokens that an owner allowed to a spender.

     *

     * approve should be called when allowed[_spender] == 0. To decrement

     * allowed value is better to use this function to avoid 2 calls (and wait until

     * the first transaction is mined)

     * From MonolithDAO Token.sol

     * @param _spender The address which will spend the funds.

     * @param _subtractedValue The amount of tokens to decrease the allowance by.

     */

    function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {

        uint oldValue = allowed[msg.sender][_spender];

        if (_subtractedValue > oldValue) {

            allowed[msg.sender][_spender] = 0;

        } else {

            allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);

        }

        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

        return true;

    }



}





/**

 * @title Ownable

 * @dev The Ownable contract has an owner address, and provides basic authorization control

 * functions, this simplifies the implementation of "user permissions".

 */

contract Ownable {

    address public owner;





    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);





    /**

     * @dev The Ownable constructor sets the original `owner` of the contract to the sender

     * account.

     */

    function Ownable() public {

        owner = msg.sender;

    }



    /**

     * @dev Throws if called by any account other than the owner.

     */

    modifier onlyOwner() {

        require(msg.sender == owner);

        _;

    }



    /**

     * @dev Allows the current owner to transfer control of the contract to a newOwner.

     * @param newOwner The address to transfer ownership to.

     */

    function transferOwnership(address newOwner) public onlyOwner {

        require(newOwner != address(0));

        OwnershipTransferred(owner, newOwner);

        owner = newOwner;

    }



}





/**

 * @title Pausable

 * @dev Base contract which allows children to implement an emergency stop mechanism.

 */

contract Pausable is Ownable {

    event Pause();



    event Unpause();



    bool public paused = false;





    /**

     * @dev Modifier to make a function callable only when the contract is not paused.

     */

    modifier whenNotPaused() {

        require(!paused);

        _;

    }



    /**

     * @dev Modifier to make a function callable only when the contract is paused.db.getCollection('transactions').find({})

     */

    modifier whenPaused() {

        require(paused);

        _;

    }



    /**

     * @dev called by the owner to pause, triggers stopped state

     */

    function pause() onlyOwner whenNotPaused public {

        paused = true;

        Pause();

    }



    /**

     * @dev called by the owner to unpause, returns to normal state

     */

    function unpause() onlyOwner whenPaused public {

        paused = false;

        Unpause();

    }

}





contract MintableToken is StandardToken, Ownable, Pausable {

    event Mint(address indexed to, uint256 amount);



    event MintFinished();



    bool public mintingFinished = false;



    uint256 public constant maxTokensToMint = 1500000000 ether;



    modifier canMint() {

        require(!mintingFinished);

        _;

    }



    /**

    * @dev Function to mint tokens

    * @param _to The address that will recieve the minted tokens.

    * @param _amount The amount of tokens to mint.

    * @return A boolean that indicates if the operation was successful.

    */

    function mint(address _to, uint256 _amount) whenNotPaused onlyOwner returns (bool) {

        return mintInternal(_to, _amount);

    }



    /**

    * @dev Function to stop minting new tokens.

    * @return True if the operation was successful.

    */

    function finishMinting() whenNotPaused onlyOwner returns (bool) {

        mintingFinished = true;

        MintFinished();

        return true;

    }



    function mintInternal(address _to, uint256 _amount) internal canMint returns (bool) {

        require(totalSupply_.add(_amount) <= maxTokensToMint);

        totalSupply_ = totalSupply_.add(_amount);

        balances[_to] = balances[_to].add(_amount);

        Mint(_to, _amount);

        Transfer(address(0), _to, _amount);

        return true;

    }

}





contract Well is MintableToken {



    string public constant name = "Token Well";



    string public constant symbol = "WELL";



    bool public transferEnabled = false;



    uint8 public constant decimals = 18;



    uint256 public rate = 9000;



    uint256 public constant hardCap = 30000 ether;



    uint256 public weiFounded = 0;



    uint256 public icoTokensCount = 0;



    address public approvedUser = 0x1ca815aBdD308cAf6478d5e80bfc11A6556CE0Ed;



    address public wallet = 0x1ca815aBdD308cAf6478d5e80bfc11A6556CE0Ed;





    bool public icoFinished = false;



    uint256 public constant maxTokenToBuy = 600000000 ether;



    event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 amount);





    /**

    * @dev transfer token for a specified address

    * @param _to The address to transfer to.

    * @param _value The amount to be transferred.

    */

    function transfer(address _to, uint _value) whenNotPaused canTransfer returns (bool) {

        require(_to != address(this));

        return super.transfer(_to, _value);

    }



    /**

    * @dev Transfer tokens from one address to another

    * @param _from address The address which you want to send tokens from

    * @param _to address The address which you want to transfer to

    * @param _value uint256 the amout of tokens to be transfered

    */

    function transferFrom(address _from, address _to, uint _value) whenNotPaused canTransfer returns (bool) {

        require(_to != address(this));

        return super.transferFrom(_from, _to, _value);

    }



    /**

     * @dev Aprove the passed address to spend the specified amount of tokens on behalf of msg.sender.

     * @param _spender The address which will spend the funds.

     * @param _value The amount of tokens to be spent.

     */

    function approve(address _spender, uint256 _value) whenNotPaused returns (bool) {

        return super.approve(_spender, _value);

    }



    /**

     * @dev Modifier to make a function callable only when the transfer is enabled.

     */

    modifier canTransfer() {

        require(transferEnabled);

        _;

    }



    modifier onlyOwnerOrApproved() {

        require(msg.sender == owner || msg.sender == approvedUser);

        _;

    }



    /**

    * @dev Function to start transfering tokens.

    * @return True if the operation was successful.

    */

    function enableTransfer() onlyOwner returns (bool) {

        transferEnabled = true;

        return true;

    }



    function finishIco() onlyOwner returns (bool) {

        icoFinished = true;

        icoTokensCount = totalSupply_;

        return true;

    }



    modifier canBuyTokens() {

        require(!icoFinished && weiFounded.add(msg.value) <= hardCap);

        _;

    }



    function setApprovedUser(address _user) onlyOwner returns (bool) {

        require(_user != address(0));

        approvedUser = _user;

        return true;

    }





    function changeRate(uint256 _rate) onlyOwnerOrApproved returns (bool) {

        require(_rate > 0);

        rate = _rate;

        return true;

    }



    function() payable {

        buyTokens(msg.sender);

    }



    function buyTokens(address beneficiary) canBuyTokens whenNotPaused payable {

        require(msg.value != 0);

        require(beneficiary != 0x0);



        uint256 weiAmount = msg.value;

        uint256 bonus = 0;



        bonus = getBonusByDate();



        uint256 tokens = weiAmount.mul(rate);





        if (bonus > 0) {

            tokens += tokens.mul(bonus).div(100);

            // add bonus

        }



        require(totalSupply_.add(tokens) <= maxTokenToBuy);



        require(mintInternal(beneficiary, tokens));

        weiFounded = weiFounded.add(weiAmount);

        TokenPurchase(msg.sender, beneficiary, tokens);

        forwardFunds();

    }



    // send ether to the fund collection wallet

    function forwardFunds() internal {

        wallet.transfer(msg.value);

    }





    function changeWallet(address _newWallet) onlyOwner returns (bool) {

        require(_newWallet != 0x0);

        wallet = _newWallet;

        return true;

    }



    function getBonusByDate() view returns (uint256){

        if (block.timestamp < 1514764800) return 0;

        if (block.timestamp < 1521158400) return 40;

        if (block.timestamp < 1523836800) return 30;

        if (block.timestamp < 1523923200) return 25;

        if (block.timestamp < 1524441600) return 20;

        if (block.timestamp < 1525046400) return 10;

        if (block.timestamp < 1525651200) return 5;

        return 0;

    }



}