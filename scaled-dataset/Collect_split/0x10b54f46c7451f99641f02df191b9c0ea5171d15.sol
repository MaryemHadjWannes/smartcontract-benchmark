/**									

 *Submitted for verification at Etherscan.io on 2019-03-16									

*/									

									

pragma solidity 		^0.5.1	;		// v v0.5.11				

									

contract	KGAU_ABC150CHF_20190927_0915_BUCATI				{				

									

	mapping (address => uint256) public balanceOf;								

									

	string	public		name =	"kGzzSi"	;			

	string	public		symbol =	"kGzzSi"	;			

	uint8	public		decimals =		18			;

									

	uint256 public totalSupply =		10444392196437900000000000					;	

									

	event Transfer(address indexed from, address indexed to, uint256 value);								

									

	function SimpleERC20Token() public {								

		balanceOf[msg.sender] = totalSupply;							

		emit Transfer(address(0), msg.sender, totalSupply);							

	}								

									

	function transfer(address to, uint256 value) public returns (bool success) {								

		require(balanceOf[msg.sender] >= value);							

									

		balanceOf[msg.sender] -= value;  // deduct from sender's balance							

		balanceOf[to] += value;          // add to recipient's balance							

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

		require(value <= balanceOf[from]);							

		require(value <= allowance[from][msg.sender]);							

									

		balanceOf[from] -= value;							

		balanceOf[to] += value;							

		allowance[from][msg.sender] -= value;							

		emit Transfer(from, to, value);							

		return true;							

	}								

}