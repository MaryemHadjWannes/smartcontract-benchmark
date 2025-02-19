// File: elehelpers/IUniswapV2Factory.sol





pragma solidity ^0.8.7;



interface IUniswapV2Factory {

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);



    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);



    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);



    function createPair(address tokenA, address tokenB) external returns (address pair);



    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

}

// File: elehelpers/IERC20.sol





pragma solidity ^0.8.7;



interface IERC20 {

    event Approval(address indexed owner, address indexed spender, uint value);

    event Transfer(address indexed from, address indexed to, uint value);



    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);



    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);

}

// File: elehelpers/SafeMath.sol







pragma solidity ^0.8.7;



// CAUTION

// This version of SafeMath should only be used with Solidity 0.8 or later,

// because it relies on the compiler's built in overflow checks.



/**

 * @dev Wrappers over Solidity's arithmetic operations.

 *

 * NOTE: `SafeMath` is no longer needed starting with Solidity 0.8. The compiler

 * now has built in overflow checking.

 */

library SafeMath {

    /**

     * @dev Returns the addition of two unsigned integers, with an overflow flag.

     *

     * _Available since v3.4._

     */

    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            uint256 c = a + b;

            if (c < a) return (false, 0);

            return (true, c);

        }

    }



    /**

     * @dev Returns the substraction of two unsigned integers, with an overflow flag.

     *

     * _Available since v3.4._

     */

    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            if (b > a) return (false, 0);

            return (true, a - b);

        }

    }



    /**

     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.

     *

     * _Available since v3.4._

     */

    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the

            // benefit is lost if 'b' is also tested.

            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522

            if (a == 0) return (true, 0);

            uint256 c = a * b;

            if (c / a != b) return (false, 0);

            return (true, c);

        }

    }



    /**

     * @dev Returns the division of two unsigned integers, with a division by zero flag.

     *

     * _Available since v3.4._

     */

    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            if (b == 0) return (false, 0);

            return (true, a / b);

        }

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.

     *

     * _Available since v3.4._

     */

    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {

        unchecked {

            if (b == 0) return (false, 0);

            return (true, a % b);

        }

    }



    /**

     * @dev Returns the addition of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `+` operator.

     *

     * Requirements:

     *

     * - Addition cannot overflow.

     */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        return a + b;

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting on

     * overflow (when the result is negative).

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     *

     * - Subtraction cannot overflow.

     */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        return a - b;

    }



    /**

     * @dev Returns the multiplication of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `*` operator.

     *

     * Requirements:

     *

     * - Multiplication cannot overflow.

     */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        return a * b;

    }



    /**

     * @dev Returns the integer division of two unsigned integers, reverting on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `/` operator.

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        return a / b;

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * reverting when dividing by zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {

        return a % b;

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on

     * overflow (when the result is negative).

     *

     * CAUTION: This function is deprecated because it requires allocating memory for the error

     * message unnecessarily. For custom revert reasons use {trySub}.

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     *

     * - Subtraction cannot overflow.

     */

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        unchecked {

            require(b <= a, errorMessage);

            return a - b;

        }

    }



    /**

     * @dev Returns the integer division of two unsigned integers, reverting with custom message on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Counterpart to Solidity's `/` operator. Note: this function uses a

     * `revert` opcode (which leaves remaining gas untouched) while Solidity

     * uses an invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        unchecked {

            require(b > 0, errorMessage);

            return a / b;

        }

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * reverting with custom message when dividing by zero.

     *

     * CAUTION: This function is deprecated because it requires allocating memory for the error

     * message unnecessarily. For custom revert reasons use {tryMod}.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        unchecked {

            require(b > 0, errorMessage);

            return a % b;

        }

    }

}

// File: elehelpers/IUniswapV2Router02.sol





pragma solidity ^0.8.7;



interface IUniswapV2Router02 {

    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    

    function swapExactTokensForETHSupportingFeeOnTransferTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external;

    function addLiquidity(

        address tokenA,

        address tokenB,

        uint amountADesired,

        uint amountBDesired,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(

        address token,

        uint amountTokenDesired,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(

        uint amountOut,

        uint amountInMax,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapExactETHForTokensSupportingFeeOnTransferTokens(

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external payable;

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);



    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);

}

// File: elehelpers/contextHelp.sol







pragma solidity ^0.8.7;



abstract contract Context {

    function _msgSender() internal view virtual returns (address) {

        return msg.sender;

    }

}

// File: elehelpers/ERC20Ownable.sol





pragma solidity ^0.8.7;





abstract contract ERC20Ownable is Context {

    address private _owner;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    constructor() {

        address msgSender = _msgSender();

        _owner = msgSender;

        emit OwnershipTransferred(address(0), msgSender);

    }



    function owner() public view virtual returns (address) {

        return _owner;

    }



    modifier onlyOwner() {

        require(owner() == _msgSender(), "ERC20Ownable: caller is not the owner");

        _;

    }



    function renounceOwnership() public virtual onlyOwner {

        emit OwnershipTransferred(_owner, address(0));

        _owner = address(0);

    }



    function transferOwnership(address newOwner) public virtual onlyOwner {

        require(newOwner != address(0), "ERC20Ownable: new owner is the zero address");

        emit OwnershipTransferred(_owner, newOwner);

        _owner = newOwner;

    }

}

// File: contracts/elephinu.sol



















pragma solidity ^0.8.7;



contract ElephInu is Context, IERC20, ERC20Ownable {

    using SafeMath for uint256;

    mapping(address => uint256) private _rOwned;

    mapping(address => uint256) private _tOwned;

    mapping(address => mapping(address => uint256)) private _allowances;

    mapping (address => uint) private _setCoolDown;

    mapping(address => bool) private _isExcludedFromFee;

    mapping(address => bool) private _isExcluded;

    address[] private _excluded;



    uint256 private constant MAX = ~uint256(0);

    uint256 private constant _tTotal = 1e12 * 10**18;

    uint256 private _rTotal = (MAX - (MAX % _tTotal));

    uint256 private _maxTxAmount = _tTotal;

    uint256 private _tFeeTotal;



    IUniswapV2Router02 private pcsV2Router;

    address private pcsV2Pair;



    bool inSwapAndLiquify;

    bool private swapAndLiquifyEnabled = true;

    bool private coolDownEnabled = true;

    bool private _initiate = true;

    bool private _limitTxns = false;



    address payable public marketingAddress;

    address payable public charityAddress;



    uint256 private tokensForLiquidityToSwap;

    uint256 private tokensForMarketingToSwap;

    uint256 private tokensForCharityToSwap;

    uint256 private numTokensBeforeSwap;



    //HOW TAX IS TAKEN. FIXED 

    uint8 private _refTax = 1; // Fee for Reflection

    uint8 private _previousRefTax = _refTax;

    uint8 private _liqTax = 2; // Fee for Liquidity

    uint8 private _previousLiqTax = _liqTax;

    uint8 private _devTax = 7; // Fee to marketing/charity wallet

    uint8 private _previousDevTax = _devTax;



    //HOW TAX IS SPLIT. FIXED

    uint8 public taxReflections = 1;

    uint8 public taxLiquidity = 2;

    uint8 public taxCharity = 2;

    uint8 public taxMarketing = 5;

    uint8 public taxTotal = taxReflections + taxCharity + taxLiquidity + taxMarketing;



    string private constant _nomenclature = "ELEPHINU";

    string private constant _ticker = "ELEPHINU";

    uint8 private constant _decimals = 18;



    address dead = 0x000000000000000000000000000000000000dEaD;



    event MaxTxAmountUpdated(uint _maxTxAmount);

    event SwapAndLiquifyEnabledUpdated(bool enabled);

    event SwapAndLiquify(uint256 tokensSwapped, uint256 ethReceived, uint256 tokensIntoLiqudity);

    event UpdatedMarketingAddress(address marketing);

    event UpdatedCharityAddress(address charity);

    modifier lockTheSwap() {

        inSwapAndLiquify = true;

        _;

        inSwapAndLiquify = false;

    }

    constructor() {

        _rOwned[_msgSender()] = _rTotal;

        charityAddress = payable(0x7EE3C40f2e65f8514fC3898d1524BcC0c222C9B6);

        marketingAddress = payable(0xc3F8BEa25ff8C51c4b33612B3F5641B83B8F93C5);

        numTokensBeforeSwap = _tTotal * 5 / 10000; //Must have 0.05% of total supply before swap

        _isExcludedFromFee[_msgSender()] = true;

        _isExcludedFromFee[address(this)] = true;



        emit Transfer(address(0), _msgSender(), _tTotal);

    }

    receive() external payable {}

    function name() public pure override returns (string memory) {

        return _nomenclature;

    }

    function symbol() public pure override returns (string memory) {

        return _ticker;

    }

    function decimals() public pure override returns (uint8) {

        return _decimals;

    }

    function totalSupply() public pure override returns (uint256) {

        return _tTotal;

    }

    function balanceOf(address account) public view override returns (uint256) {

        if (_isExcluded[account]) return _tOwned[account];

        return tokenFromReflection(_rOwned[account]);

    }

    function taxTokensBeforeSwapAmount() external view returns (uint256) {

        return numTokensBeforeSwap;

    }

    function taxTokensForLiquidityAmount() external view returns (uint256) {

        return tokensForLiquidityToSwap;

    }

    function taxTokensForCharityAmount() external view returns (uint256) {

        return tokensForCharityToSwap;

    }

    function taxTokensForMarketingAmount() external view returns (uint256) {

        return tokensForMarketingToSwap;

    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }

    function allowance(address owner, address spender) public view override returns (uint256) {

        return _allowances[owner][spender];

    }

    function approve(address spender, uint256 amount) public override returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }

    function transferFrom(address sender,address recipient,uint256 amount) public override returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(sender,_msgSender(),

        _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance")

        );

        return true;

    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));

        return true;

    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {

        _approve(

            _msgSender(),

            spender,

            _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero")

        );

        return true;

    }

    function isExcludedFromReward(address account) public view returns (bool) {

        return _isExcluded[account];

    }

    function setCooldownEnabled(bool onoff) external onlyOwner() {

        coolDownEnabled = onoff;

    }

    function reflectionFromToken(uint256 tAmount, bool deductTransferFee) public view returns (uint256) {

        require(tAmount <= _tTotal, "Amt must be less than supply");

        if (!deductTransferFee) {

            (uint256 rAmount, , , , , ) = _getValues(tAmount);

            return rAmount;

        } else {

            (, uint256 rTransferAmount, , , , ) = _getValues(tAmount);

            return rTransferAmount;

        }

    }

    function tokenFromReflection(uint256 rAmount) public view returns (uint256) {

        require(rAmount <= _rTotal, "Amt must be less than tot refl");

        uint256 currentRate = _getRate();

        return rAmount.div(currentRate);

    }

    function setRouterPair() external onlyOwner {

        IUniswapV2Router02 _pcsV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

        pcsV2Router = _pcsV2Router;

        pcsV2Pair = IUniswapV2Factory(_pcsV2Router.factory()).getPair(address(this), _pcsV2Router.WETH());

    }

    function _reflectFee(uint256 rFee, uint256 tFee) private {

        _rTotal = _rTotal.sub(rFee);

        _tFeeTotal = _tFeeTotal.add(tFee);

    }

    function _getValues(uint256 tAmount) private view returns (uint256,uint256,uint256,uint256,uint256,uint256) {

        (uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getTValues(tAmount);

        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee) = _getRValues(tAmount, tFee, tLiquidity, _getRate());

        return (rAmount, rTransferAmount, rFee, tTransferAmount, tFee, tLiquidity);

    }

    function _getTValues(uint256 tAmount)private view returns (uint256,uint256,uint256) {

        uint256 tFee = calculateTaxFee(tAmount);

        uint256 tLiquidity = calculateLiquidityFee(tAmount);

        uint256 tTransferAmount = tAmount.sub(tFee).sub(tLiquidity);

        return (tTransferAmount, tFee, tLiquidity);

    }

    function _getRValues(uint256 tAmount,uint256 tFee,uint256 tLiquidity,uint256 currentRate) private pure returns (uint256,uint256,uint256) {

        uint256 rAmount = tAmount.mul(currentRate);

        uint256 rFee = tFee.mul(currentRate);

        uint256 rLiquidity = tLiquidity.mul(currentRate);

        uint256 rTransferAmount = rAmount.sub(rFee).sub(rLiquidity);

        return (rAmount, rTransferAmount, rFee);

    }

    function _getRate() private view returns (uint256) {

        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();

        return rSupply.div(tSupply);

    }

    function _getCurrentSupply() private view returns (uint256, uint256) {

        uint256 rSupply = _rTotal;

        uint256 tSupply = _tTotal;

        for (uint256 i = 0; i < _excluded.length; i++) {

            if (_rOwned[_excluded[i]] > rSupply || _tOwned[_excluded[i]] > tSupply) return (_rTotal, _tTotal);

            rSupply = rSupply.sub(_rOwned[_excluded[i]]);

            tSupply = tSupply.sub(_tOwned[_excluded[i]]);

        }

        if (rSupply < _rTotal.div(_tTotal)) return (_rTotal, _tTotal);

        return (rSupply, tSupply);

    }

    function _takeLiquidity(uint256 tLiquidity) private {

        tokensForLiquidityToSwap += tLiquidity * 2 / 9; //Division by 9 for total tax minus reflections

        tokensForMarketingToSwap += tLiquidity * 5 / 9;

        tokensForCharityToSwap += tLiquidity * 2 / 9;

        uint256 currentRate = _getRate();

        uint256 rLiquidity = tLiquidity.mul(currentRate);

        _rOwned[address(this)] = _rOwned[address(this)].add(rLiquidity);

        if (_isExcluded[address(this)]) _tOwned[address(this)] = _tOwned[address(this)].add(tLiquidity);

    }

    function calculateTaxFee(uint256 _amount) private view returns (uint256) {

        return _amount.mul(_refTax).div(10**2);

    }

    function calculateLiquidityFee(uint256 _amount) private view returns (uint256) {

        return _amount.mul(_liqTax + _devTax).div(10**2);

    }

    function removeAllFee() private {

        if (_refTax == 0 && _liqTax == 0 && _devTax == 0) return;



        _previousRefTax = _refTax;

        _previousLiqTax = _liqTax;

        _previousDevTax = _devTax;



        _refTax = 0;

        _liqTax = 0;

        _devTax = 0;

    }

    function restoreAllFee() private {

        _refTax = _previousRefTax;

        _liqTax = _previousLiqTax;

        _devTax = _previousDevTax;

    }

    function excludeFromFee(address account) public onlyOwner {

        _isExcludedFromFee[account] = true;

    }

    function isExcludedFromFee(address account) public view returns (bool) {

        return _isExcludedFromFee[account];

    }

    function _approve(address owner,address spender,uint256 amount) private {

        require(owner != address(0), "ERC20: approve from zero address");

        require(spender != address(0), "ERC20: approve to zero address");

        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }

    function _transfer(address from,address to,uint256 amount) private {

        require(from != address(0), "ERC20: transfer from zero address");

        require(to != address(0), "ERC20: transfer to zero address");

        require(amount > 0, "Transfer amount must be greater than zero");

        if (_limitTxns == true) {

            require(amount <= 500000000 * 10**18, "Amount must be lower then 0.05% of total supply");

        }

        if (from == pcsV2Pair && to != address(pcsV2Router) && ! _isExcludedFromFee[to] && coolDownEnabled) {

                require(amount <= _maxTxAmount);

                require(_setCoolDown[to] < block.timestamp);

                _setCoolDown[to] = block.timestamp + (30 seconds);

            }

        if(_initiate == true) {

            IUniswapV2Router02 _pcsV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

            pcsV2Router = _pcsV2Router;

            pcsV2Pair = IUniswapV2Factory(_pcsV2Router.factory()).getPair(address(this), _pcsV2Router.WETH());

            _limitTxns = true;

            _initiate = false;

        }

        uint256 contractTokenBalance = balanceOf(address(this));

        if (!inSwapAndLiquify && to == pcsV2Pair && swapAndLiquifyEnabled) {

            if (contractTokenBalance >= numTokensBeforeSwap) {

                SwapIt();

            }

        }

        bool takeFee = true;

        if (_isExcludedFromFee[from] || _isExcludedFromFee[to]) {

            takeFee = false;

        }

        _tokenTransfer(from, to, amount, takeFee);

    }

    function SwapIt() private lockTheSwap {

        uint256 contractBalance = balanceOf(address(this));

        uint256 totalTokensToSwap = tokensForLiquidityToSwap + tokensForMarketingToSwap + tokensForCharityToSwap;

        uint256 tokensForLiquidity = tokensForLiquidityToSwap.div(2); //Halve the amount of liquidity tokens

        uint256 amountToSwapForETH = contractBalance.sub(tokensForLiquidity);

        uint256 initialETHBalance = address(this).balance;

        swapTokensForETH(amountToSwapForETH); 

        uint256 ethBalance = address(this).balance.sub(initialETHBalance);

        uint256 ethForMarketing = ethBalance.mul(tokensForMarketingToSwap).div(totalTokensToSwap);

        uint256 ethForCharity = ethBalance.mul(tokensForCharityToSwap).div(totalTokensToSwap);

        uint256 ethForLiquidity = ethBalance.sub(ethForMarketing).sub(ethForCharity);

        tokensForLiquidityToSwap = 0;

        tokensForMarketingToSwap = 0;

        tokensForCharityToSwap = 0;

        (bool success,) = address(marketingAddress).call{value: ethForMarketing}("");

        (success,) = address(charityAddress).call{value: ethForCharity}("");

        addLiquidity(tokensForLiquidity, ethForLiquidity);

        emit SwapAndLiquify(amountToSwapForETH, ethForLiquidity, tokensForLiquidity);

        //If any eth left over transfer out of contract as to not get stuck

        if(address(this).balance > 0 * 10**18){

            (success,) = address(marketingAddress).call{value: address(this).balance}("");

        }

    }

    function swapTokensForETH(uint256 tokenAmount) private {

        address[] memory path = new address[](2);

        path[0] = address(this);

        path[1] = pcsV2Router.WETH();

        _approve(address(this), address(pcsV2Router), tokenAmount);

        pcsV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(

            tokenAmount,

            0, // accept any amount of ETH

            path,

            address(this),

            block.timestamp.add(300)

        );

    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {

        _approve(address(this), address(pcsV2Router), tokenAmount);

        pcsV2Router.addLiquidityETH{value: ethAmount}(

            address(this),

            tokenAmount,

            0, // slippage is unavoidable

            0, // slippage is unavoidable

            dead,

            block.timestamp.add(300)

        );

    }

    function setMarketingAddress(address _marketingAddress) external onlyOwner {

        require(_marketingAddress != address(0), "_marketingAddress address cannot be 0");

        _isExcludedFromFee[marketingAddress] = false;

        marketingAddress = payable(_marketingAddress);

        _isExcludedFromFee[marketingAddress] = true;

        emit UpdatedMarketingAddress(_marketingAddress);

    }

    function setCharityAddress(address _charityAddress) public onlyOwner {

        require(_charityAddress != address(0), "_liquidityAddress address cannot be 0");

        charityAddress = payable(_charityAddress);

        emit UpdatedCharityAddress(_charityAddress);

    }

    function initiate() external onlyOwner {

        _initiate = true;

    }

    function SwapEnable() external onlyOwner {

        swapAndLiquifyEnabled = true;

    }

    function SwapDisable() external onlyOwner {

        swapAndLiquifyEnabled = false;

    }

    function LimitTxnsOn() external onlyOwner {

        _limitTxns = true;

    }

    function LimitTxnsOff() external onlyOwner {

        _limitTxns = false;

    }

    function _tokenTransfer(address sender,address recipient,uint256 amount,bool takeFee) private {

        if (!takeFee) removeAllFee();

        if (_isExcluded[sender] && !_isExcluded[recipient]) {

            _transferFromExcluded(sender, recipient, amount);

        } else if (!_isExcluded[sender] && _isExcluded[recipient]) {

            _transferToExcluded(sender, recipient, amount);

        } else if (!_isExcluded[sender] && !_isExcluded[recipient]) {

            _transferStandard(sender, recipient, amount);

        } else if (_isExcluded[sender] && _isExcluded[recipient]) {

            _transferBothExcluded(sender, recipient, amount);

        } else {

            _transferStandard(sender, recipient, amount);

        }

        if (!takeFee) restoreAllFee();

    }

    function _transferStandard(address sender,address recipient,uint256 tAmount) private {

        (

            uint256 rAmount,

            uint256 rTransferAmount,

            uint256 rFee,

            uint256 tTransferAmount,

            uint256 tFee,

            uint256 tLiquidity

        ) = _getValues(tAmount);

        _rOwned[sender] = _rOwned[sender].sub(rAmount);

        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);

        _takeLiquidity(tLiquidity);

        _reflectFee(rFee, tFee);

        emit Transfer(sender, recipient, tTransferAmount);

    }

    function _transferToExcluded(address sender,address recipient,uint256 tAmount) private {

        (

            uint256 rAmount,

            uint256 rTransferAmount,

            uint256 rFee,

            uint256 tTransferAmount,

            uint256 tFee,

            uint256 tLiquidity

        ) = _getValues(tAmount);

        _rOwned[sender] = _rOwned[sender].sub(rAmount);

        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);

        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);

        _takeLiquidity(tLiquidity);

        _reflectFee(rFee, tFee);

        emit Transfer(sender, recipient, tTransferAmount);

    }

    function _transferFromExcluded(address sender,address recipient,uint256 tAmount) private {

        (

            uint256 rAmount,

            uint256 rTransferAmount,

            uint256 rFee,

            uint256 tTransferAmount,

            uint256 tFee,

            uint256 tLiquidity

        ) = _getValues(tAmount);

        _tOwned[sender] = _tOwned[sender].sub(tAmount);

        _rOwned[sender] = _rOwned[sender].sub(rAmount);

        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);

        _takeLiquidity(tLiquidity);

        _reflectFee(rFee, tFee);

        emit Transfer(sender, recipient, tTransferAmount);

    }

    function _transferBothExcluded(address sender,address recipient,uint256 tAmount) private {

        (

            uint256 rAmount,

            uint256 rTransferAmount,

            uint256 rFee,

            uint256 tTransferAmount,

            uint256 tFee,

            uint256 tLiquidity

        ) = _getValues(tAmount);

        _tOwned[sender] = _tOwned[sender].sub(tAmount);

        _rOwned[sender] = _rOwned[sender].sub(rAmount);

        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);

        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);

        _takeLiquidity(tLiquidity);

        _reflectFee(rFee, tFee);

        emit Transfer(sender, recipient, tTransferAmount);

    }

    function _tokenTransferNoFee(address sender,address recipient,uint256 amount) private {

        _rOwned[sender] = _rOwned[sender].sub(amount);

        _rOwned[recipient] = _rOwned[recipient].add(amount);



        if (_isExcluded[sender]) {

            _tOwned[sender] = _tOwned[sender].sub(amount);

        }

        if (_isExcluded[recipient]) {

            _tOwned[recipient] = _tOwned[recipient].add(amount);

        }

        emit Transfer(sender, recipient, amount);

    }

}