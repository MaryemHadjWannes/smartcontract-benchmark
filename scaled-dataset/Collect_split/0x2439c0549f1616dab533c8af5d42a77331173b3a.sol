pragma solidity >=0.4.22 <0.6.0;



contract ERC20 {

    function totalSupply() public view returns (uint supply);

    function balanceOf(address who) public view returns (uint value);

    function allowance(address owner, address spender) public view returns (uint remaining);



    function transfer(address to, uint value) public returns (bool ok);

    function transferFrom(address from, address to, uint value) public returns (bool ok);

    function approve(address spender, uint value) public returns (bool ok);



    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed spender, uint value);

}



contract KappiToken is ERC20{

    uint8 public constant decimals = 18;

    uint256 initialSupply = 8000000000*10**uint256(decimals);



    string public constant name = "Kappi Token";

    string public constant symbol = "KAPP";



    address payable constant teamAddress = address(0x345195Afa4A2aBB1698806e97431AB19c197F43D);



    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint256)) allowed;



    function totalSupply() public view returns (uint256) {

        return initialSupply;

    }



    function balanceOf(address owner) public view returns (uint256 balance) {

        return balances[owner];

    }



    function allowance(address owner, address spender) public view returns (uint remaining) {

        return allowed[owner][spender];

    }



    function transfer(address to, uint256 value) public returns (bool success) {

        if (balances[msg.sender] >= value && value > 0) {

            balances[msg.sender] -= value;

            balances[to] += value;

            emit Transfer(msg.sender, to, value);

            return true;

        } else {

            return false;

        }

    }



    function transferFrom(address from, address to, uint256 value) public returns (bool success) {

        if (balances[from] >= value && allowed[from][msg.sender] >= value && value > 0) {

            balances[to] += value;

            balances[from] -= value;

            allowed[from][msg.sender] -= value;

            emit Transfer(from, to, value);

            return true;

        } else {

            return false;

        }

    }



    function approve(address spender, uint256 value) public returns (bool success) {

        allowed[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);

        return true;

    }



    constructor () public payable {

        balances[teamAddress] = initialSupply;

    }



    function () external payable {

        teamAddress.transfer(msg.value);

    }

}