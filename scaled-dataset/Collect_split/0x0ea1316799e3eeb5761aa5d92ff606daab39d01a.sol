pragma solidity ^0.4.24;



/**

 * @title Math

 * @dev Assorted math operations

 */

library Math {

  function max64(uint64 a, uint64 b) internal pure returns (uint64) {

    return a >= b ? a : b;

  }



  function min64(uint64 a, uint64 b) internal pure returns (uint64) {

    return a < b ? a : b;

  }



  function max256(uint256 a, uint256 b) internal pure returns (uint256) {

    return a >= b ? a : b;

  }



  function min256(uint256 a, uint256 b) internal pure returns (uint256) {

    return a < b ? a : b;

  }

}





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







contract ETDM {



  using SafeMath for uint256;





  uint256 totalSupply_;

  event Transfer(address indexed from, address indexed to, uint256 value);

  event Approval(address indexed owner, address indexed spender, uint256 value);



  function totalSupply() public view returns (uint256) {

    return totalSupply_;

  }



  function transfer(address _to, uint256 _value) public returns (bool) {

    require(_to != address(0));

    require(_value <= balances[msg.sender]);



    balances[msg.sender] = balances[msg.sender].sub(_value);

    balances[_to] = balances[_to].add(_value);

    emit Transfer(msg.sender, _to, _value);

    return true;

  }



  function balanceOf(address _owner) public view returns (uint256) {

    return balances[_owner];

  }



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



  function approve(address _spender, uint256 _value) public returns (bool) {

    allowed[msg.sender][_spender] = _value;

    emit Approval(msg.sender, _spender, _value);

    return true;

  }



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



  function increaseApproval(

    address _spender,

    uint256 _addedValue

  )

    public

    returns (bool)

  {

    allowed[msg.sender][_spender] = (

    allowed[msg.sender][_spender].add(_addedValue));

    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

    return true;

  }



  function decreaseApproval(

    address _spender,

    uint256 _subtractedValue

  )

    public

    returns (bool)

  {

    uint256 oldValue = allowed[msg.sender][_spender];

    if (_subtractedValue > oldValue) {

      allowed[msg.sender][_spender] = 0;

    } else {

      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);

    }

    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

    return true;

  }

  



  

  string public constant name = "ETDM"; // solium-disable-line uppercase

  string public constant symbol = "ETDM"; // solium-disable-line uppercase

  uint8 public constant decimals = 6; // solium-disable-line uppercase

  

  mapping(address => uint256) balances;

  mapping (address => mapping (address => uint256)) internal allowed;

  

  uint256 public constant INITIAL_SUPPLY = 70 * 10000 * (10 ** uint256(decimals));





  constructor() public {

    totalSupply_ = INITIAL_SUPPLY;

    balances[msg.sender] = INITIAL_SUPPLY;

    emit Transfer(address(0), msg.sender, INITIAL_SUPPLY);

  }



}