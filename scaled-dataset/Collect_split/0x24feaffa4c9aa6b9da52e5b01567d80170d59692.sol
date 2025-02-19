// SPDX-License-Identifier: MIT

pragma solidity >=0.5.4 <0.9.0;





library SafeMath {

    function sub(uint256 a, uint256 b) internal pure returns(uint256) {

        require(b <= a);

        return a - b;

    }



    function add(uint256 a, uint256 b) internal pure returns(uint256) {

        uint256 c = a + b;

        require(c >= a);

        return c;

    }

}



contract SatoshifyToken {

    

    string public constant name = "Satoshify";



    string public constant symbol = "SFT";



    uint256 public constant decimals = 8;

    

    uint256 public constant totalSupply = 1000000000000000;



    mapping(address => uint256) public balanceOf;



    mapping(address => mapping(address => uint256)) public allowance;



    event Transfer(

        address indexed _from,

        address indexed _to,

        uint256 _value

    );

    

    event Approval(

        address indexed _owner,

        address indexed _spender,

        uint256 _value

    );



    using SafeMath for uint256;



    constructor() {

        balanceOf[msg.sender] = totalSupply;

    }



    function transfer(address _to, uint256 _value) public returns(bool success) {

        require(_value > 0);

        require(balanceOf[msg.sender] >= _value);

        

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);

        balanceOf[_to] = balanceOf[_to].add(_value);

        

        emit Transfer(msg.sender, _to, _value);

        

        return true;

    }



    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success) {

        require(_value <= balanceOf[_from]);

        require(_value <= allowance[_from][msg.sender]);



        balanceOf[_from] = balanceOf[_from].sub(_value);

        balanceOf[_to] = balanceOf[_to].add(_value);



        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);



        emit Transfer(_from, _to, _value);

        return true;

    }



    function approve(address _spender, uint256 _value) public returns(bool success) {

        allowance[msg.sender][_spender] = _value;

        

        emit Approval(msg.sender, _spender, _value);

        

        return true;

    }



}