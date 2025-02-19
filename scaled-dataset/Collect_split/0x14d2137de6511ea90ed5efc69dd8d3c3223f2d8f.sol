pragma solidity ^0.5.0;



library SafeMath {

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {

    uint256 c = a * b;

    assert(a == 0 || c / a == b);

    return c;

  }



  function div(uint256 a, uint256 b) internal pure returns (uint256) {

    // assert(b > 0); // Solidity automatically throws when dividing by 0

    uint256 c = a / b;

    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;

  }



  function sub(uint256 a, uint256 b) internal pure returns (uint256) {

    assert(b <= a);

    return a - b;

  }



  function add(uint256 a, uint256 b) internal pure returns (uint256) {

    uint256 c = a + b;

    assert(c >= a);

    return c;

  }

}



contract IERC20 {

    function balanceOf(address who) public view returns (uint);

    function transfer(address to, uint value) public returns (bool);

}



contract Ownable {

  address private _owner;



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

    _owner = msg.sender;

  }



  /**

   * @return the address of the owner.

   */

  function owner() public view returns(address) {

    return _owner;

  }



  /**

   * @dev Throws if called by any account other than the owner.

   */

  modifier onlyOwner() {

    require(isOwner());

    _;

  }



  /**

   * @return true if `msg.sender` is the owner of the contract.

   */

  function isOwner() public view returns(bool) {

    return msg.sender == _owner;

  }



  /**

   * @dev Allows the current owner to relinquish control of the contract.

   * @notice Renouncing to ownership will leave the contract without an owner.

   * It will not be possible to call the functions with the `onlyOwner`

   * modifier anymore.

   */

  function renounceOwnership() public onlyOwner {

    emit OwnershipRenounced(_owner);

    _owner = address(0);

  }



  /**

   * @dev Allows the current owner to transfer control of the contract to a newOwner.

   * @param newOwner The address to transfer ownership to.

   */

  function transferOwnership(address newOwner) public onlyOwner {

    _transferOwnership(newOwner);

  }



  /**

   * @dev Transfers control of the contract to a newOwner.

   * @param newOwner The address to transfer ownership to.

   */

  function _transferOwnership(address newOwner) internal {

    require(newOwner != address(0));

    emit OwnershipTransferred(_owner, newOwner);

    _owner = newOwner;

  }

}



contract GIAToken is Ownable {

    using SafeMath for uint256;



    string public constant name = "Global Insurance Alliance Chain";

    string public constant symbol = "GIA";

    uint256 public constant decimals = 18;

    uint256 public totalSupply = 2000000000 * 1e18;  // 2 billion



    mapping (address => uint256) public balances;

    mapping (address => mapping (address => uint256)) public allowed;

    bool paused = false;



    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    event Burn(address indexed _burner, uint256 _value);



    modifier onlyWhenTransferEnabled() {

        require(!paused);

        _;

    }



    function togglePause() public onlyOwner {

        paused = !paused;

    }



    constructor () public {

        balances[msg.sender] = totalSupply;

        emit Transfer(address(0), msg.sender, totalSupply);

    }



    function transfer(address _to, uint256 _value) public onlyWhenTransferEnabled returns (bool success) {

        require(balances[msg.sender] >= _value);

        balances[msg.sender] = balances[msg.sender].sub(_value);

        balances[_to] = balances[_to].add(_value);

        emit Transfer(msg.sender, _to, _value);

        return true;

    }



    function transferFrom(address _from, address _to, uint256 _value) public onlyWhenTransferEnabled returns (bool success) {

        uint256 allowance = allowed[_from][msg.sender];

        require(balances[_from] >= _value && allowance >= _value);

        balances[_to] = balances[_to].add(_value);

        balances[_from] = balances[_from].sub(_value);

        if (allowance != uint256(-1)) {

            allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);

        }

        emit Transfer(_from, _to, _value);

        return true;

    }



    function balanceOf(address _owner) public view returns (uint256 balance) {

        return balances[_owner];

    }



    function approve(address _spender, uint256 _value) public returns (bool success) {

        allowed[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;

    }



    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {

        return allowed[_owner][_spender];

    }

    

    function burn(uint256 _value) public onlyWhenTransferEnabled returns (bool) {

        balances[msg.sender] = balances[msg.sender].sub(_value);

        totalSupply = totalSupply.sub(_value);

        emit Burn(msg.sender, _value);

        emit Transfer(msg.sender, address(0), _value);

        return true;

    }

    

    // Owner can extract tokens sent to this contract, thank you ;)

    function saveTokens(address _token, address payable _to) external onlyOwner {

        if (_token == address(0)) {

            _to.transfer(address(this).balance);

            return;

        }



        IERC20 token = IERC20(_token);

        uint balance = token.balanceOf(address(this));

        token.transfer(_to, balance);

    }

}