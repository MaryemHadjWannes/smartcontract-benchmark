/**

 * 2020.4.15 lim

 */



pragma solidity ^0.4.17;



/**

 * @title SafeMath

 * @dev Math operations with safety checks that throw on error

 */

library SafeMath {

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }

        uint256 c = a * b;

        assert(c / a == b);

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





contract Ownable {

    

    address public owner;



    function Ownable() public {

        owner = msg.sender;

    }

    

    modifier onlyOwner() {

        require(msg.sender == owner);

        _;

    }



    function transferOwnership(address newOwner) public onlyOwner {

        if (newOwner != address(0)) {

            owner = newOwner;

        }

    }



}



contract ERC20 {

    uint public _totalSupply;

    function totalSupply() public constant returns (uint);

    function balanceOf(address who) public constant returns (uint);

    function transfer(address to, uint value) public;

    

    function approve(address spender, uint value) public;

    function transferFrom(address from, address to, uint value) public;

    function allowance(address owner, address spender) public constant returns (uint);

    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed spender, uint value);

}





contract PZSHToken is Ownable, ERC20 {

    

    using SafeMath for uint;

    

    string public name;

    string public symbol;

    uint public decimals;

    uint public basisPointsRate = 0;

    uint public maximumFee = 0;

    uint public constant MAX_UINT = 2**256 - 1;

    

    mapping(address => uint) public balances;

    mapping (address => mapping (address => uint)) public allowed;

   

    event Issue(uint amount);

    event Redeem(uint amount);



    function PZSHToken(uint _initialSupply, string _name) public {

        _totalSupply = _initialSupply * 10**6;

        name = _name;

        symbol = _name;

        decimals = 6;

        balances[owner] = _totalSupply;

    }

    

    //array of holder address

    address[] public holders = [owner];

    //map of holder address

    mapping(address => uint) public holdersMap;

    

    /**

    * @dev Fix for the ERC20 short address attack.

    */

    modifier onlyPayloadSize(uint size) {

        require(!(msg.data.length < size + 4));

        _;

    }

    

    function totalSupply() public constant returns (uint) {

        

        return _totalSupply;

    }

    

    function balanceOf(address _owner) public constant returns (uint balance) {

        return balances[_owner];

    }

    

    function transfer(address _to, uint _value) public onlyPayloadSize(2 * 32) {

        uint fee = (_value.mul(basisPointsRate)).div(10000);

        if (fee > maximumFee) {

            fee = maximumFee;

        }

        uint sendAmount = _value.sub(fee);

        balances[msg.sender] = balances[msg.sender].sub(_value);

        balances[_to] = balances[_to].add(sendAmount);

        if (fee > 0) {

            balances[owner] = balances[owner].add(fee);

            Transfer(msg.sender, owner, fee);

        }

        if(holdersMap[_to] == 0){

            holdersMap[_to] = 1;

            holders.push(_to);

        }

        Transfer(msg.sender, _to, sendAmount);

    }



    function approve(address _spender, uint _value) public onlyPayloadSize(2 * 32) {



        require(!((_value != 0) && (allowed[msg.sender][_spender] != 0)));



        allowed[msg.sender][_spender] = _value;

        Approval(msg.sender, _spender, _value);

    }

    

    function transferFrom(address _from, address _to, uint _value) public onlyPayloadSize(3 * 32) {

        var _allowance = allowed[_from][msg.sender];

        

        uint fee = (_value.mul(basisPointsRate)).div(10000);

        if (fee > maximumFee) {

            fee = maximumFee;

        }

        if (_allowance < MAX_UINT) {

            allowed[_from][msg.sender] = _allowance.sub(_value);

        }

        uint sendAmount = _value.sub(fee);

        balances[_from] = balances[_from].sub(_value);

        balances[_to] = balances[_to].add(sendAmount);

        if (fee > 0) {

            balances[owner] = balances[owner].add(fee);

            Transfer(_from, owner, fee);

        }

        if(holdersMap[_to] == 0){

            holdersMap[_to] = 1;

            holders.push(_to);

        }

        Transfer(_from, _to, sendAmount);

    }



    function allowance(address _owner, address _spender) public constant returns (uint remaining) {

        return allowed[_owner][_spender];

    }

    

    function getRate(uint amount) public constant returns (uint){

        return amount.div(_totalSupply.div(10**6));

    }

    

    function issue(uint amount) public onlyOwner {

        require(_totalSupply + amount > _totalSupply);

        require(balances[owner] + amount > balances[owner]);



        balances[owner] += amount;

        _totalSupply += amount;

        Issue(amount);

    }



    function redeem(uint amount) public onlyOwner {

        require(_totalSupply >= amount);

        require(balances[owner] >= amount);



        _totalSupply -= amount;

        balances[owner] -= amount;

        Redeem(amount);

    }

    

    function holdersNum() public constant returns (uint){

        return holders.length;

    }

    

    function holdersAddress(uint num) public constant returns (address){

        require(holders.length >= num - 1);

        require(num >= 1);

        return holders[num];

    }

    

    //reward all address

    function award(uint amount) public onlyOwner {

        require(_totalSupply + amount > _totalSupply);

        require(balances[owner] + amount > balances[owner]);

        

        uint avg = amount.div(_totalSupply.sub(balances[owner]).div(10**6));

        if(avg == 0){

            return;

        }

        uint realityRise = 0;

        for(uint i = 2; i < holders.length; i++){

            address add = holders[i];

            if(balances[add] < 10**8){

                continue;

            }

            uint rise = avg.mul(balances[add].div(10**6));

            if(rise == 0){

                continue;

            }

            balances[add] += rise;

            realityRise += rise;

            Transfer(owner, add, rise);

        }

        if(realityRise > 0){

            _totalSupply += realityRise;

            Issue(realityRise);

        }

    }

    



}