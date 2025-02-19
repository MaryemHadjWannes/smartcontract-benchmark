pragma solidity 0.4.24;



// SOURCE https://github.com/ampleforth/uFragments/blob/master/contracts/UFragments.sol

// Major portions of this contract are based on AMPL and OpenZepplin contracts

 

contract Initializable {



  bool private initialized;

  bool private initializing;



  modifier initializer() {

    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");



    bool wasInitializing = initializing;

    initializing = true;

    initialized = true;



    _;



    initializing = wasInitializing;

  }



  function isConstructor() private view returns (bool) {

    uint256 cs;

    assembly { cs := extcodesize(address) }

    return cs == 0;

  }



  uint256[50] private ______gap;

}



contract Ownable is Initializable {



  address private _owner;

  uint256 private _ownershipLocked;



  event OwnershipLocked(address lockedOwner);

  event OwnershipRenounced(address indexed previousOwner);

  event OwnershipTransferred(

    address indexed previousOwner,

    address indexed newOwner

  );





  function initialize(address sender) internal initializer {

    _owner = sender;

	_ownershipLocked = 0;

  }



  function owner() public view returns(address) {

    return _owner;

  }



  modifier onlyOwner() {

    require(isOwner());

    _;

  }



  function isOwner() public view returns(bool) {

    return msg.sender == _owner;

  }



  function transferOwnership(address newOwner) public onlyOwner {

    _transferOwnership(newOwner);

  }



  function _transferOwnership(address newOwner) internal {

    require(_ownershipLocked == 0);

    require(newOwner != address(0));

    emit OwnershipTransferred(_owner, newOwner);

    _owner = newOwner;

  }

  

  // Set _ownershipLocked flag to lock contract owner forever

  function lockOwnership() public onlyOwner {

	require(_ownershipLocked == 0);

	emit OwnershipLocked(_owner);

    _ownershipLocked = 1;

  }



  uint256[50] private ______gap;

}



interface IERC20 {

  function totalSupply() external view returns (uint256);



  function balanceOf(address who) external view returns (uint256);



  function allowance(address owner, address spender)

    external view returns (uint256);



  function transfer(address to, uint256 value) external returns (bool);



  function approve(address spender, uint256 value)

    external returns (bool);



  function transferFrom(address from, address to, uint256 value)

    external returns (bool);



  event Transfer(

    address indexed from,

    address indexed to,

    uint256 value

  );



  event Approval(

    address indexed owner,

    address indexed spender,

    uint256 value

  );

}



contract ERC20Detailed is Initializable, IERC20 {

  string private _name;

  string private _symbol;

  uint8 private _decimals;



  function initialize(string name, string symbol, uint8 decimals) internal initializer {

    _name = name;

    _symbol = symbol;

    _decimals = decimals;

  }



  function name() public view returns(string) {

    return _name;

  }



  function symbol() public view returns(string) {

    return _symbol;

  }



  function decimals() public view returns(uint8) {

    return _decimals;

  }



  uint256[50] private ______gap;

}



library SafeMath {



    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        require(c >= a, "SafeMath: addition overflow");



        return c;

    }



    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        return sub(a, b, "SafeMath: subtraction overflow");

    }



    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b <= a, errorMessage);

        uint256 c = a - b;



        return c;

    }



    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }



        uint256 c = a * b;

        require(c / a == b, "SafeMath: multiplication overflow");



        return c;

    }



    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        return div(a, b, "SafeMath: division by zero");

    }



    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b > 0, errorMessage);

        uint256 c = a / b;



        return c;

    }



    function mod(uint256 a, uint256 b) internal pure returns (uint256) {

        return mod(a, b, "SafeMath: modulo by zero");

    }



    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}



contract EXBASE is ERC20Detailed, Ownable {

    // PLEASE READ BEFORE CHANGING ANY ACCOUNTING OR MATH

    // Anytime there is division, there is a risk of numerical instability from rounding errors. In

    // order to minimize this risk, we adhere to the following guidelines:

    // 1) The conversion rate adopted is the number of gons that equals 1 fragment.

    //    The inverse rate must not be used--TOTAL_GONS is always the numerator and _totalSupply is

    //    always the denominator. (i.e. If you want to convert gons to fragments instead of

    //    multiplying by the inverse rate, you should divide by the normal rate)

    // 2) Gon balances converted into Fragments are always rounded down (truncated).

    //

    // We make the following guarantees:

    // - If address 'A' transfers x Fragments to address 'B'. A's resulting external balance will

    //   be decreased by precisely x Fragments, and B's external balance will be precisely

    //   increased by x Fragments.

    //

    // We do not guarantee that the sum of all balances equals the result of calling totalSupply().

    // This is because, for any conversion function 'f()' that has non-zero rounding error,

    // f(x0) + f(x1) + ... + f(xn) is not always equal to f(x0 + x1 + ... xn).

    using SafeMath for uint256;



    modifier validRecipient(address to) {

        require(to != address(0x0));

        require(to != address(this));

        _;

    }



    uint256 private constant DECIMALS = 9;

    uint256 private constant MAX_UINT256 = ~uint256(0);

    uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 20000 * 10**DECIMALS;



    // TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment is an integer.

    // Use the highest value that fits in a uint256 for max granularity.

    uint256 private constant TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);



    // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2

    uint256 private constant MAX_SUPPLY = ~uint128(0);  // (2^128) - 1



    uint256 private _totalSupply;

    uint256 private _gonsPerFragment;

    mapping(address => uint256) private _gonBalances;

    

    IERC20 BASETOKEN;

    uint256 public lastTrackedBaseSupply;

    bool public baseSupplyHasBeenInitilized = false;



    // This is denominated in Fragments, because the gons-fragments conversion might change before

    // it's fully paid.

    mapping (address => mapping (address => uint256)) private _allowedFragments;

    

    event LogRebase(uint256 indexed epoch, uint256 totalSupply);

    

    function setBASEAddress (IERC20 _basetoken) onlyOwner public {

        BASETOKEN = _basetoken;

    }

    

    // only callable once

    function initBaseTotalSupply (uint256 _ts) onlyOwner public {

        require(!baseSupplyHasBeenInitilized, 'SUPPLY ALREADY SET');

        lastTrackedBaseSupply = _ts;

        baseSupplyHasBeenInitilized = true;

    }

    

    function nextRebaseInfo()

        external view

        returns (uint256, bool)

    {

        uint256 baseTotalSupply = BASETOKEN.totalSupply();

        uint256 multiplier;

        bool rebaseIsPositive = true;

        if (baseTotalSupply > lastTrackedBaseSupply) {

            multiplier = (baseTotalSupply.sub(lastTrackedBaseSupply)).mul(10000).div(lastTrackedBaseSupply).mul(2);

        } else if (lastTrackedBaseSupply > baseTotalSupply) {

            multiplier = (lastTrackedBaseSupply.sub(baseTotalSupply)).mul(10000).div(lastTrackedBaseSupply).div(2);

            rebaseIsPositive = false;

        }



        return (multiplier, rebaseIsPositive);

    }



    /**

     * @dev Notifies Fragments contract about a new rebase cycle.

     * @return The total number of fragments after the supply adjustment.

     */

    function rebase()

        external

        returns (uint256)

    {

        

        uint256 baseTotalSupply = BASETOKEN.totalSupply();

        uint256 multiplier;

        require(baseTotalSupply != lastTrackedBaseSupply, 'NOT YET');

        if (baseTotalSupply > lastTrackedBaseSupply) {

            multiplier = (baseTotalSupply.sub(lastTrackedBaseSupply)).mul(10000).div(lastTrackedBaseSupply).mul(2);

        } else if (lastTrackedBaseSupply > baseTotalSupply) {

            multiplier = (lastTrackedBaseSupply.sub(baseTotalSupply)).mul(10000).div(lastTrackedBaseSupply).div(2);

        }

        

        uint256 modification;

        modification = _totalSupply.mul(multiplier).div(10000);

        if (baseTotalSupply > lastTrackedBaseSupply) {

            _totalSupply = _totalSupply.add(modification);

            // _totalSupply = _totalSupply.add(modification.mul(2));

        } else {

            _totalSupply = _totalSupply.sub(modification);

        }



        if (_totalSupply > MAX_SUPPLY) {

            _totalSupply = MAX_SUPPLY;

        }



        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);

        

        lastTrackedBaseSupply = baseTotalSupply;



        // From this point forward, _gonsPerFragment is taken as the source of truth.

        // We recalculate a new _totalSupply to be in agreement with the _gonsPerFragment

        // conversion rate.

        // This means our applied supplyDelta can deviate from the requested supplyDelta,

        // but this deviation is guaranteed to be < (_totalSupply^2)/(TOTAL_GONS - _totalSupply).

        //

        // In the case of _totalSupply <= MAX_UINT128 (our current supply cap), this

        // deviation is guaranteed to be < 1, so we can omit this step. If the supply cap is

        // ever increased, it must be re-included.

        // _totalSupply = TOTAL_GONS.div(_gonsPerFragment)



        emit LogRebase(block.timestamp, _totalSupply);

        return _totalSupply;

    }

    

    constructor() public {

		Ownable.initialize(msg.sender);

		ERC20Detailed.initialize("exbase.finance", "EXBASE", uint8(DECIMALS));

        

        _totalSupply = INITIAL_FRAGMENTS_SUPPLY;

        _gonBalances[msg.sender] = TOTAL_GONS;

        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);



        emit Transfer(address(0x0), msg.sender, _totalSupply);

    }



    /**

     * @return The total number of fragments.

     */

    function totalSupply()

        public

        view

        returns (uint256)

    {

        return _totalSupply;

    }



    /**

     * @param who The address to query.

     * @return The balance of the specified address.

     */

    function balanceOf(address who)

        public

        view

        returns (uint256)

    {

        return _gonBalances[who].div(_gonsPerFragment);

    }



    /**

     * @dev Transfer tokens to a specified address.

     * @param to The address to transfer to.

     * @param value The amount to be transferred.

     * @return True on success, false otherwise.

     */

    function transfer(address to, uint256 value)

        public

        validRecipient(to)

        returns (bool)

    {

        uint256 gonValue = value.mul(_gonsPerFragment);

        _gonBalances[msg.sender] = _gonBalances[msg.sender].sub(gonValue);

        _gonBalances[to] = _gonBalances[to].add(gonValue);

        emit Transfer(msg.sender, to, value);

        return true;

    }



    /**

     * @dev Function to check the amount of tokens that an owner has allowed to a spender.

     * @param owner_ The address which owns the funds.

     * @param spender The address which will spend the funds.

     * @return The number of tokens still available for the spender.

     */

    function allowance(address owner_, address spender)

        public

        view

        returns (uint256)

    {

        return _allowedFragments[owner_][spender];

    }



    /**

     * @dev Transfer tokens from one address to another.

     * @param from The address you want to send tokens from.

     * @param to The address you want to transfer to.

     * @param value The amount of tokens to be transferred.

     */

    function transferFrom(address from, address to, uint256 value)

        public

        validRecipient(to)

        returns (bool)

    {

        _allowedFragments[from][msg.sender] = _allowedFragments[from][msg.sender].sub(value);



        uint256 gonValue = value.mul(_gonsPerFragment);

        _gonBalances[from] = _gonBalances[from].sub(gonValue);

        _gonBalances[to] = _gonBalances[to].add(gonValue);

        emit Transfer(from, to, value);



        return true;

    }



    /**

     * @dev Approve the passed address to spend the specified amount of tokens on behalf of

     * msg.sender. This method is included for ERC20 compatibility.

     * increaseAllowance and decreaseAllowance should be used instead.

     * Changing an allowance with this method brings the risk that someone may transfer both

     * the old and the new allowance - if they are both greater than zero - if a transfer

     * transaction is mined before the later approve() call is mined.

     *

     * @param spender The address which will spend the funds.

     * @param value The amount of tokens to be spent.

     */

    function approve(address spender, uint256 value)

        public

        returns (bool)

    {

        _allowedFragments[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);

        return true;

    }



    /**

     * @dev Increase the amount of tokens that an owner has allowed to a spender.

     * This method should be used instead of approve() to avoid the double approval vulnerability

     * described above.

     * @param spender The address which will spend the funds.

     * @param addedValue The amount of tokens to increase the allowance by.

     */

    function increaseAllowance(address spender, uint256 addedValue)

        public

        returns (bool)

    {

        _allowedFragments[msg.sender][spender] =

            _allowedFragments[msg.sender][spender].add(addedValue);

        emit Approval(msg.sender, spender, _allowedFragments[msg.sender][spender]);

        return true;

    }



    /**

     * @dev Decrease the amount of tokens that an owner has allowed to a spender.

     *

     * @param spender The address which will spend the funds.

     * @param subtractedValue The amount of tokens to decrease the allowance by.

     */

    function decreaseAllowance(address spender, uint256 subtractedValue)

        public

        returns (bool)

    {

        uint256 oldValue = _allowedFragments[msg.sender][spender];

        if (subtractedValue >= oldValue) {

            _allowedFragments[msg.sender][spender] = 0;

        } else {

            _allowedFragments[msg.sender][spender] = oldValue.sub(subtractedValue);

        }

        emit Approval(msg.sender, spender, _allowedFragments[msg.sender][spender]);

        return true;

    }

}