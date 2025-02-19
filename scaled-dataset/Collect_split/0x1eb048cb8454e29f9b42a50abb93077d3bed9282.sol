pragma solidity ^0.5.17;



interface IERC20 {



    function totalSupply() external view returns (uint256);



    function balanceOf(address account) external view returns (uint256);



    function transfer(address recipient, uint256 amount) external returns (bool);



    function allowance(address owner, address spender) external view returns (uint256);



    function approve(address spender, uint256 amount) external returns (bool);



    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);



    event Transfer(address indexed from, address indexed to, uint256 value);



    event Approval(address indexed owner, address indexed spender, uint256 value);

}





contract ERC20Detailed is IERC20 {

    string private _name;

    string private _symbol;

    uint8 private _decimals;



    constructor (string memory name, string memory symbol, uint8 decimals) public {

        _name = name;

        _symbol = symbol;

        _decimals = decimals;

    }



    function name() public view returns (string memory) {

        return _name;

    }



    function symbol() public view returns (string memory) {

        return _symbol;

    }



    function decimals() public view returns (uint8) {

        return _decimals;

    }

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

}





contract Context {

 

    constructor () internal { }

   



    function _msgSender() internal view returns (address payable) {

        return msg.sender;

    }



    function _msgData() internal view returns (bytes memory) {

        this; 

        return msg.data;

    }

}





contract ERC20 is Context, IERC20 {

    using SafeMath for uint256;



    address Owner;



    mapping (address => uint256) private _balances;



    mapping (address => mapping (address => uint256)) private _allowances;

    

    mapping (address => bool) private _lock;



    uint256 private _totalSupply;

    

    modifier onlyOwner() {

        require (Owner == _msgSender(),"you don't have access to block");

        _;

    }



    function totalSupply() public view returns (uint256) {

        return _totalSupply;

    }



    function balanceOf(address account) public view returns (uint256) {

        return _balances[account];

    }



    function transfer(address recipient, uint256 amount) public returns (bool) {

       

        _transfer(_msgSender(), recipient, amount);

        return true;

    }





    function allowance(address owner, address spender) public view returns (uint256) {

        return _allowances[owner][spender];

    }



    function approve(address spender, uint256 amount) public returns (bool) {

        require(!_lock[spender],"ERC20: spender is blocked");

        _approve(_msgSender(), spender, amount);

        return true;

    }



    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {

        require(!_lock[sender],"ERC20: sender is blocked");

        require(!_lock[recipient],"ERC20: recipient is blocked");

        _transfer(sender, recipient, amount);

        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));

        return true;

    }

    

    function lock (address addr) public onlyOwner returns(bool) {

        _lock[addr] = true;

        return _lock[addr];

    }

    

    function Unlock (address addr) public onlyOwner returns(bool) {

        _lock[addr] = false;

        return _lock[addr];

    }

    

    function accountStatus (address addr) public view returns (bool) {

        return _lock[addr];

    }



    function _transfer(address sender, address recipient, uint256 amount) internal {

        require(!_lock[sender],"ERC20: sender is blocked");

        require(!_lock[recipient],"ERC20: recipient is blocked");

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");

        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

    }



    function _mint(address account, uint256 amount) internal {

        require(account != address(0), "ERC20: mint to the zero address");

        Owner = account;

        _totalSupply = _totalSupply.add(amount);

        _balances[account] = _balances[account].add(amount);

        emit Transfer(address(0), account, amount);

    }



    function _approve(address owner, address spender, uint256 amount) internal {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }

}



contract DELETOSSOOCIAL is ERC20, ERC20Detailed {

    constructor() ERC20Detailed("DELETOS SOOCIAL", "DLTS", 0) public {

        _mint(msg.sender, 200000000);

    }

}