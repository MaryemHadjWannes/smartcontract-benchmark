pragma solidity ^0.4.23;





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



pragma solidity ^0.4.23;





/**

 * @title ERC20 interface

 * @dev see https://github.com/ethereum/EIPs/issues/20

 */

contract ERC20 is ERC20Basic {

  function allowance(address owner, address spender)

    public view returns (uint256);



  function transferFrom(address from, address to, uint256 value)

    public returns (bool);



  function approve(address spender, uint256 value) public returns (bool);

  event Approval(

    address indexed owner,

    address indexed spender,

    uint256 value

  );

}



pragma solidity ^0.4.23;





/**

 * @title SafeMath

 * @dev Math operations with safety checks that throw on error

 */

library SafeMath {



  /**

  * @dev Multiplies two numbers, throws on overflow.

  */

  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {

    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the

    // benefit is lost if 'b' is also tested.

    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522

    if (a == 0) {

      return 0;

    }



    c = a * b;

    assert(c / a == b);

    return c;

  }



  /**

  * @dev Integer division of two numbers, truncating the quotient.

  */

  function div(uint256 a, uint256 b) internal pure returns (uint256) {

    // assert(b > 0); // Solidity automatically throws when dividing by 0

    // uint256 c = a / b;

    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return a / b;

  }



  /**

  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).

  */

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {

    assert(b <= a);

    return a - b;

  }



  /**

  * @dev Adds two numbers, throws on overflow.

  */

  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {

    c = a + b;

    assert(c >= a);

    return c;

  }

}





pragma solidity ^0.4.23;





/**

 * @title Ownable

 * @dev The Ownable contract has an owner address, and provides basic authorization control

 * functions, this simplifies the implementation of "user permissions".

 */

contract Ownable {

  address public owner;





  event OwnershipRenounced(address indexed previousOwner);

  event OwnershipTransferred(

    address indexed previousOwner,

    address indexed newOwner

  );





  /**

   * @dev The Ownable constructor sets the original `owner` of the contract to the sender

   * account.

   */

  constructor() public {

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

   * @dev Allows the current owner to relinquish control of the contract.

   */

  function renounceOwnership() public onlyOwner {

    emit OwnershipRenounced(owner);

    owner = address(0);

  }



  /**

   * @dev Allows the current owner to transfer control of the contract to a newOwner.

   * @param _newOwner The address to transfer ownership to.

   */

  function transferOwnership(address _newOwner) public onlyOwner {

    _transferOwnership(_newOwner);

  }



  /**

   * @dev Transfers control of the contract to a newOwner.

   * @param _newOwner The address to transfer ownership to.

   */

  function _transferOwnership(address _newOwner) internal {

    require(_newOwner != address(0));

    emit OwnershipTransferred(owner, _newOwner);

    owner = _newOwner;

  }

}



pragma solidity ^0.4.23;





/**

 * @title Roles

 * @author Francisco Giordano (@frangio)

 * @dev Library for managing addresses assigned to a Role.

 *      See RBAC.sol for example usage.

 */

library Roles {

  struct Role {

    mapping (address => bool) bearer;

  }



  /**

   * @dev give an address access to this role

   */

  function add(Role storage role, address addr)

    internal

  {

    role.bearer[addr] = true;

  }



  /**

   * @dev remove an address' access to this role

   */

  function remove(Role storage role, address addr)

    internal

  {

    role.bearer[addr] = false;

  }



  /**

   * @dev check if an address has this role

   * // reverts

   */

  function check(Role storage role, address addr)

    view

    internal

  {

    require(has(role, addr));

  }



  /**

   * @dev check if an address has this role

   * @return bool

   */

  function has(Role storage role, address addr)

    view

    internal

    returns (bool)

  {

    return role.bearer[addr];

  }

}



pragma solidity ^0.4.23;



/**

 * @title RBAC (Role-Based Access Control)

 * @author Matt Condon (@Shrugs)

 * @dev Stores and provides setters and getters for roles and addresses.

 * @dev Supports unlimited numbers of roles and addresses.

 * @dev See //contracts/mocks/RBACMock.sol for an example of usage.

 * This RBAC method uses strings to key roles. It may be beneficial

 *  for you to write your own implementation of this interface using Enums or similar.

 * It's also recommended that you define constants in the contract, like ROLE_ADMIN below,

 *  to avoid typos.

 */

contract RBAC {

  using Roles for Roles.Role;



  mapping (string => Roles.Role) private roles;



  event RoleAdded(address addr, string roleName);

  event RoleRemoved(address addr, string roleName);



  /**

   * @dev reverts if addr does not have role

   * @param addr address

   * @param roleName the name of the role

   * // reverts

   */

  function checkRole(address addr, string roleName)

    view

    public

  {

    roles[roleName].check(addr);

  }



  /**

   * @dev determine if addr has role

   * @param addr address

   * @param roleName the name of the role

   * @return bool

   */

  function hasRole(address addr, string roleName)

    view

    public

    returns (bool)

  {

    return roles[roleName].has(addr);

  }



  /**

   * @dev add a role to an address

   * @param addr address

   * @param roleName the name of the role

   */

  function addRole(address addr, string roleName)

    internal

  {

    roles[roleName].add(addr);

    emit RoleAdded(addr, roleName);

  }



  /**

   * @dev remove a role from an address

   * @param addr address

   * @param roleName the name of the role

   */

  function removeRole(address addr, string roleName)

    internal

  {

    roles[roleName].remove(addr);

    emit RoleRemoved(addr, roleName);

  }



  /**

   * @dev modifier to scope access to a single role (uses msg.sender as addr)

   * @param roleName the name of the role

   * // reverts

   */

  modifier onlyRole(string roleName)

  {

    checkRole(msg.sender, roleName);

    _;

  }



  /**

   * @dev modifier to scope access to a set of roles (uses msg.sender as addr)

   * @param roleNames the names of the roles to scope access to

   * // reverts

   *

   * @TODO - when solidity supports dynamic arrays as arguments to modifiers, provide this

   *  see: https://github.com/ethereum/solidity/issues/2467

   */

  // modifier onlyRoles(string[] roleNames) {

  //     bool hasAnyRole = false;

  //     for (uint8 i = 0; i < roleNames.length; i++) {

  //         if (hasRole(msg.sender, roleNames[i])) {

  //             hasAnyRole = true;

  //             break;

  //         }

  //     }



  //     require(hasAnyRole);



  //     _;

  // }

}



pragma solidity ^0.4.23;



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



    balances[msg.sender] = balances[msg.sender].sub(_value);

    balances[_to] = balances[_to].add(_value);

    emit Transfer(msg.sender, _to, _value);

    return true;

  }



  /**

  * @dev Gets the balance of the specified address.

  * @param _owner The address to query the the balance of.

  * @return An uint256 representing the amount owned by the passed address.

  */

  function balanceOf(address _owner) public view returns (uint256) {

    return balances[_owner];

  }



}



pragma solidity ^0.4.23;





/**

 * @title Burnable Token

 * @dev Token that can be irreversibly burned (destroyed).

 */

contract BurnableToken is BasicToken {



  event Burn(address indexed burner, uint256 value);



  /**

   * @dev Burns a specific amount of tokens.

   * @param _value The amount of token to be burned.

   */

  function burn(uint256 _value) public {

    _burn(msg.sender, _value);

  }



  function _burn(address _who, uint256 _value) internal {

    require(_value <= balances[_who]);

    // no need to require value <= totalSupply, since that would imply the

    // sender's balance is greater than the totalSupply, which *should* be an assertion failure



    balances[_who] = balances[_who].sub(_value);

    totalSupply_ = totalSupply_.sub(_value);

    emit Burn(_who, _value);

    emit Transfer(_who, address(0), _value);

  }

}



pragma solidity ^0.4.23;



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

  function transferFrom(

    address _from,

    address _to,

    uint256 _value

  )

    public

    returns (bool)

  {

    require(_to != address(0));

    require(_value <= balances[_from]);

    require(_value <= allowed[_from][msg.sender]);



    balances[_from] = balances[_from].sub(_value);

    balances[_to] = balances[_to].add(_value);

    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);

    emit Transfer(_from, _to, _value);

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

    emit Approval(msg.sender, _spender, _value);

    return true;

  }



  /**

   * @dev Function to check the amount of tokens that an owner allowed to a spender.

   * @param _owner address The address which owns the funds.

   * @param _spender address The address which will spend the funds.

   * @return A uint256 specifying the amount of tokens still available for the spender.

   */

  function allowance(

    address _owner,

    address _spender

   )

    public

    view

    returns (uint256)

  {

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

  function increaseApproval(

    address _spender,

    uint _addedValue

  )

    public

    returns (bool)

  {

    allowed[msg.sender][_spender] = (

      allowed[msg.sender][_spender].add(_addedValue));

    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

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

  function decreaseApproval(

    address _spender,

    uint _subtractedValue

  )

    public

    returns (bool)

  {

    uint oldValue = allowed[msg.sender][_spender];

    if (_subtractedValue > oldValue) {

      allowed[msg.sender][_spender] = 0;

    } else {

      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);

    }

    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

    return true;

  }



}



pragma solidity ^0.4.23;



/**

 * @title Mintable token

 * @dev Simple ERC20 Token example, with mintable token creation

 * @dev Issue: * https://github.com/OpenZeppelin/openzeppelin-solidity/issues/120

 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol

 */

contract MintableToken is StandardToken, Ownable {

  event Mint(address indexed to, uint256 amount);

  event MintFinished();



  bool public mintingFinished = false;





  modifier canMint() {

    require(!mintingFinished);

    _;

  }



  modifier hasMintPermission() {

    require(msg.sender == owner);

    _;

  }



  /**

   * @dev Function to mint tokens

   * @param _to The address that will receive the minted tokens.

   * @param _amount The amount of tokens to mint.

   * @return A boolean that indicates if the operation was successful.

   */

  function mint(

    address _to,

    uint256 _amount

  )

    hasMintPermission

    canMint

    public

    returns (bool)

  {

    totalSupply_ = totalSupply_.add(_amount);

    balances[_to] = balances[_to].add(_amount);

    emit Mint(_to, _amount);

    emit Transfer(address(0), _to, _amount);

    return true;

  }



  /**

   * @dev Function to stop minting new tokens.

   * @return True if the operation was successful.

   */

  function finishMinting() onlyOwner canMint public returns (bool) {

    mintingFinished = true;

    emit MintFinished();

    return true;

  }

}



pragma solidity ^0.4.23;



/**

 * @title Whitelist

 * @dev The Whitelist contract has a whitelist of addresses, and provides basic authorization control functions.

 * @dev This simplifies the implementation of "user permissions".

 */

contract Whitelist is Ownable, RBAC {

  event WhitelistedAddressAdded(address addr);

  event WhitelistedAddressRemoved(address addr);



  string public constant ROLE_WHITELISTED = "whitelist";



  /**

   * @dev Throws if called by any account that's not whitelisted.

   */

  modifier onlyWhitelisted() {

    checkRole(msg.sender, ROLE_WHITELISTED);

    _;

  }



  /**

   * @dev add an address to the whitelist

   * @param addr address

   * @return true if the address was added to the whitelist, false if the address was already in the whitelist

   */

  function addAddressToWhitelist(address addr)

    onlyOwner

    public

  {

    addRole(addr, ROLE_WHITELISTED);

    emit WhitelistedAddressAdded(addr);

  }



  /**

   * @dev getter to determine if address is in whitelist

   */

  function whitelist(address addr)

    public

    view

    returns (bool)

  {

    return hasRole(addr, ROLE_WHITELISTED);

  }



  /**

   * @dev add addresses to the whitelist

   * @param addrs addresses

   * @return true if at least one address was added to the whitelist,

   * false if all addresses were already in the whitelist

   */

  function addAddressesToWhitelist(address[] addrs)

    onlyOwner

    public

  {

    for (uint256 i = 0; i < addrs.length; i++) {

      addAddressToWhitelist(addrs[i]);

    }

  }



  /**

   * @dev remove an address from the whitelist

   * @param addr address

   * @return true if the address was removed from the whitelist,

   * false if the address wasn't in the whitelist in the first place

   */

  function removeAddressFromWhitelist(address addr)

    onlyOwner

    public

  {

    removeRole(addr, ROLE_WHITELISTED);

    emit WhitelistedAddressRemoved(addr);

  }



  /**

   * @dev remove addresses from the whitelist

   * @param addrs addresses

   * @return true if at least one address was removed from the whitelist,

   * false if all addresses weren't in the whitelist in the first place

   */

  function removeAddressesFromWhitelist(address[] addrs)

    onlyOwner

    public

  {

    for (uint256 i = 0; i < addrs.length; i++) {

      removeAddressFromWhitelist(addrs[i]);

    }

  }



}



pragma solidity 0.4.24;



contract DS_AAPL is StandardToken, MintableToken, BurnableToken, Whitelist {

  string public symbol;

  string public name;

  uint8 public decimals;

  address[] public WhiteListAddresses;



  constructor (

    string symbol_,

    string name_,

    uint8 decimals_,

    uint256 totalSupply,

    address owner,

    address supplyOwnerAddress

  ) public {

    symbol = symbol_;

    name = name_;

    decimals = decimals_;

    totalSupply_ = totalSupply;

    balances[supplyOwnerAddress] = totalSupply;

    

    WhiteListAddresses.push(owner); 

    WhiteListAddresses.push(supplyOwnerAddress);



    addAddressesToWhitelist(WhiteListAddresses);

    transferOwnership(owner);

    emit Transfer(0x0, owner, totalSupply);

  }

  

  modifier onlyRecipientWhitelisted(address _to) {

    checkRole(_to, ROLE_WHITELISTED);

    _;

  }



  function transfer(

    address _to,

    uint256 _value

  ) 

    public

    onlyRecipientWhitelisted(_to)

    returns (bool) 

  {

    BasicToken.transfer(_to, _value);

  }



  function transferFrom(

    address _from,

    address _to,

    uint256 _value

  )

    public

    onlyRecipientWhitelisted(_to)

    returns (bool)

  {

    StandardToken.transferFrom(_from, _to, _value);

  }



  function approve(

    address _spender,

    uint256 _value

  ) public

    onlyRecipientWhitelisted(_spender)

    returns (bool)

  {

    StandardToken.approve(_spender, _value);

  }



  function mint(

    address _to,

    uint256 _amount

  )

    hasMintPermission

    canMint

    onlyRecipientWhitelisted(_to)

    public

    returns (bool)

  {

    MintableToken.mint(_to, _amount);

  }



}