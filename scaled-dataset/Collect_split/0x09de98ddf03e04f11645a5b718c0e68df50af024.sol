// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;



interface IERC20 {

  function totalSupply() external view returns (uint256);

  function decimals() external view returns (uint8);

  function symbol() external view returns (string memory);

  function name() external view returns (string memory);

  function getOwner() external view returns (address);

  function balanceOf(address account) external view returns (uint256);

  function transfer(address recipient, uint256 amount) external returns (bool);

  function allowance(address _owner, address spender) external view returns (uint256);

  function approve(address spender, uint256 amount) external returns (bool);

  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  event Transfer(address indexed from, address indexed to, uint256 value);

  event Approval(address indexed owner, address indexed spender, uint256 value);

}



interface IFactoryV2 {

    event PairCreated(address indexed token0, address indexed token1, address lpPair, uint);

    function getPair(address tokenA, address tokenB) external view returns (address lpPair);

    function createPair(address tokenA, address tokenB) external returns (address lpPair);

}



interface IV2Pair {

    function factory() external view returns (address);

    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function sync() external;

}



interface IRouter01 {

    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidityETH(

        address token,

        uint amountTokenDesired,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

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

    function swapExactETHForTokens(

        uint amountOutMin, 

        address[] calldata path, 

        address to, uint deadline

    ) external payable returns (uint[] memory amounts);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);

}



interface IRouter02 is IRouter01 {

    function swapExactTokensForETHSupportingFeeOnTransferTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external payable;

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external;

    function swapExactTokensForTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

}



interface AntiSnipe {

    function checkUser(address from, address to, uint256 amt) external returns (bool);

    function setLaunch(address _initialLpPair, uint32 _liqAddBlock, uint64 _liqAddStamp, uint8 dec) external;

    function setLpPair(address pair, bool enabled) external;

    function setProtections(bool _as, bool _ab) external;

    function removeSniper(address account) external;

    function removeBlacklisted(address account) external;

    function isBlacklisted(address account) external view returns (bool);

    function setBlacklistEnabled(address account, bool enabled) external;

    function setBlacklistEnabledMultiple(address[] memory accounts, bool enabled) external;

    function setCooldown(uint8 amount) external;

    function getBlockCooldown() external view returns (bool, uint8);



    function fullReset() external;

}



contract TheBirdKiller is IERC20 {

    // Ownership moved to in-contract for customizability.

    address private _owner;

    address private _ownerPartial;



    mapping (address => uint256) private _tOwned;

    mapping (address => bool) lpPairs;

    uint256 private timeSinceLastPair = 0;

    mapping (address => mapping (address => uint256)) private _allowances;



    mapping (address => bool) private _liquidityHolders;

    mapping (address => bool) private _isExcludedFromProtection;

    mapping (address => bool) private _isExcludedFromFees;

    mapping (address => bool) private _isExcludedFromLimits;

   

    uint256 constant private startingSupply = 999_999_999_999;



    string constant private _name = "The Bird Killer";

    string constant private _symbol = "MEOW";

    uint8 constant private _decimals = 9;



    uint256 constant private _tTotal = startingSupply * 10**_decimals;



    struct Fees {

        uint16 buyFee;

        uint16 sellFee;

        uint16 transferFee;

    }



    struct Ratios {

        uint16 marketing;

        uint16 buyback;

        uint16 treasury;

        uint16 totalSwap;

    }



    Fees public _taxRates = Fees({

        buyFee: 1000,

        sellFee: 1000,

        transferFee: 300

        });



    Ratios public _ratios = Ratios({

        marketing: 600,

        buyback: 300,

        treasury: 100,

        totalSwap: 1000

        });



    uint256 constant public maxBuyTaxes = 2000;

    uint256 constant public maxSellTaxes = 2000;

    uint256 constant public maxTransferTaxes = 2000;

    uint256 constant masterTaxDivisor = 10000;



    IRouter02 public dexRouter;

    address public lpPair;

    address constant public DEAD = 0x000000000000000000000000000000000000dEaD;



    struct TaxWallets {

        address payable marketing;

        address payable buyback;

        address payable treasury;

    }



    TaxWallets public _taxWallets = TaxWallets({

        marketing: payable(0x9538187720993990E9F9ab773052Be9d1Cfc5cdB),

        buyback: payable(0xCED08c1713cB311DB49a19577b4fbe045455568e),

        treasury: payable(0x6B920c2C94dA80016cD30d5BB72B19E788e25675)

        });

    

    bool inSwap;

    bool public contractSwapEnabled = false;

    uint256 public swapThreshold;

    uint256 public swapAmount;

    bool public piContractSwapsEnabled;

    uint256 public piSwapPercent;

    

    uint256 private _maxTxAmount = (_tTotal * 5) / 1000;

    uint256 private _maxWalletSize = (_tTotal * 2) / 100;



    bool public tradingEnabled = false;

    bool public _hasLiqBeenAdded = false;

    AntiSnipe antiSnipe;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    event PartialOwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    event ContractSwapEnabledUpdated(bool enabled);

    event AutoLiquify(uint256 amountCurrency, uint256 amountTokens);

    

    modifier lockTheSwap {

        inSwap = true;

        _;

        inSwap = false;

    }



    modifier onlyOwner() {

        require(_owner == msg.sender, "Caller =/= owner.");

        _;

    }



    modifier partialOrFullOwner() {

        require(_owner == msg.sender || _ownerPartial == msg.sender, "Caller =/= owner or partial owner.");

        _;

    }



    constructor () payable {

        _tOwned[msg.sender] = _tTotal;

        emit Transfer(address(0), msg.sender, _tTotal);



        // Set the owner.

        _owner = msg.sender;

        // Sets the partial owner, can ONLY change taxes.

        _ownerPartial = msg.sender;



        if (block.chainid == 56) {

            dexRouter = IRouter02(0x10ED43C718714eb63d5aA57B78B54704E256024E);

        } else if (block.chainid == 97) {

            dexRouter = IRouter02(0xD99D1c33F9fC3444f8101754aBC46c52416550D1);

        } else if (block.chainid == 1 || block.chainid == 4 || block.chainid == 3) {

            dexRouter = IRouter02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

        } else if (block.chainid == 43114) {

            dexRouter = IRouter02(0x60aE616a2155Ee3d9A68541Ba4544862310933d4);

        } else if (block.chainid == 250) {

            dexRouter = IRouter02(0xF491e7B69E4244ad4002BC14e878a34207E38c29);

        } else {

            revert();

        }



        lpPair = IFactoryV2(dexRouter.factory()).createPair(dexRouter.WETH(), address(this));

        lpPairs[lpPair] = true;



        _approve(_owner, address(dexRouter), type(uint256).max);

        _approve(address(this), address(dexRouter), type(uint256).max);



        _isExcludedFromFees[_owner] = true;

        _isExcludedFromFees[address(this)] = true;

        _isExcludedFromFees[DEAD] = true;

        _liquidityHolders[_owner] = true;

    }



    receive() external payable {}



//===============================================================================================================

//===============================================================================================================

//===============================================================================================================

    // Ownable removed as a lib and added here to allow for custom transfers and renouncements.

    // This allows for removal of ownership privileges from the owner once renounced or transferred.

    function transferOwner(address newOwner) external onlyOwner {

        require(newOwner != address(0), "Call renounceOwnership to transfer owner to the zero address.");

        require(newOwner != DEAD, "Call renounceOwnership to transfer owner to the zero address.");

        setExcludedFromFees(_owner, false);

        setExcludedFromFees(newOwner, true);

        

        if(balanceOf(_owner) > 0) {

            _finalizeTransfer(_owner, newOwner, balanceOf(_owner), false, false, false, true);

        }

        

        address oldOwner = _owner;

        _owner = newOwner;

        emit OwnershipTransferred(oldOwner, newOwner);

    }



    function transferPartialOwner(address newOwner) external partialOrFullOwner {

        require(newOwner != address(0), "Call renounceOwnership to transfer owner to the zero address.");

        require(newOwner != DEAD, "Call renounceOwnership to transfer owner to the zero address.");

        

        address oldOwner = _owner;

        _ownerPartial = newOwner;

        emit PartialOwnershipTransferred(oldOwner, newOwner);

        

    }



    // The true renouncement. Make sure this is called to renounce control over ALL functions.

    function renounceOwnership() external partialOrFullOwner {

        _isExcludedFromFees[_owner] = false;

        _isExcludedFromFees[_ownerPartial] = false;

        address oldOwner = _owner;

        address oldPartial = _ownerPartial;

        _owner = address(0);

        _ownerPartial = address(0);

        emit OwnershipTransferred(oldOwner, address(0));

        emit PartialOwnershipTransferred(oldPartial, address(0));

    }



    // Allows partial renouncement. Only taxes can be changed after ownership is partially renounced.

    // For full renouncement, make sure renounceOwnership() is called.

    function renouncePartialOwnership() external onlyOwner {

        setExcludedFromFees(_owner, false);

        _owner = address(0);

        emit PartialOwnershipTransferred(_owner, address(0));

    }



//===============================================================================================================

//===============================================================================================================

//===============================================================================================================



    function totalSupply() external pure override returns (uint256) { if (_tTotal == 0) { revert(); } return _tTotal; }

    function decimals() external pure override returns (uint8) { if (_tTotal == 0) { revert(); } return _decimals; }

    function symbol() external pure override returns (string memory) { return _symbol; }

    function name() external pure override returns (string memory) { return _name; }

    function getOwner() external view override returns (address) { return _owner; }

    function getOwnerPartial() external view returns (address) { return _ownerPartial; }

    function allowance(address holder, address spender) external view override returns (uint256) { return _allowances[holder][spender]; }



    function balanceOf(address account) public view override returns (uint256) {

        return _tOwned[account];

    }



    function transfer(address recipient, uint256 amount) public override returns (bool) {

        _transfer(msg.sender, recipient, amount);

        return true;

    }



    function approve(address spender, uint256 amount) public override returns (bool) {

        _approve(msg.sender, spender, amount);

        return true;

    }



    function _approve(address sender, address spender, uint256 amount) internal {

        require(sender != address(0), "ERC20: Zero Address");

        require(spender != address(0), "ERC20: Zero Address");



        _allowances[sender][spender] = amount;

        emit Approval(sender, spender, amount);

    }



    function approveContractContingency() public onlyOwner returns (bool) {

        _approve(address(this), address(dexRouter), type(uint256).max);

        return true;

    }



    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {

        if (_allowances[sender][msg.sender] != type(uint256).max) {

            _allowances[sender][msg.sender] -= amount;

        }



        return _transfer(sender, recipient, amount);

    }



    function setNewRouter(address newRouter) public onlyOwner {

        IRouter02 _newRouter = IRouter02(newRouter);

        address get_pair = IFactoryV2(_newRouter.factory()).getPair(address(this), _newRouter.WETH());

        if (get_pair == address(0)) {

            lpPair = IFactoryV2(_newRouter.factory()).createPair(address(this), _newRouter.WETH());

        }

        else {

            lpPair = get_pair;

        }

        dexRouter = _newRouter;

        _approve(address(this), address(dexRouter), type(uint256).max);

    }



    function setLpPair(address pair, bool enabled) external onlyOwner {

        if (enabled == false) {

            lpPairs[pair] = false;

            antiSnipe.setLpPair(pair, false);

        } else {

            if (timeSinceLastPair != 0) {

                require(block.timestamp - timeSinceLastPair > 3 days, "3 Day cooldown.!");

            }

            lpPairs[pair] = true;

            timeSinceLastPair = block.timestamp;

            antiSnipe.setLpPair(pair, true);

        }

    }



    function setInitializer(address initializer) external onlyOwner {

        require(!tradingEnabled);

        require(initializer != address(this), "Can't be self.");

        antiSnipe = AntiSnipe(initializer);

    }



    function isExcludedFromLimits(address account) external view returns (bool) {

        return _isExcludedFromLimits[account];

    }



    function isExcludedFromFees(address account) external view returns(bool) {

        return _isExcludedFromFees[account];

    }



    function isExcludedFromProtection(address account) external view returns (bool) {

        return _isExcludedFromProtection[account];

    }



    function setExcludedFromLimits(address account, bool enabled) external onlyOwner {

        _isExcludedFromLimits[account] = enabled;

    }



    function setExcludedFromFees(address account, bool enabled) public onlyOwner {

        _isExcludedFromFees[account] = enabled;

    }



    function setExcludedFromProtection(address account, bool enabled) external onlyOwner {

        _isExcludedFromProtection[account] = enabled;

    }



//================================================ BLACKLIST



    function setBlacklistEnabled(address account, bool enabled) external onlyOwner {

        antiSnipe.setBlacklistEnabled(account, enabled);

    }



    function setBlacklistEnabledMultiple(address[] memory accounts, bool enabled) external onlyOwner {

        antiSnipe.setBlacklistEnabledMultiple(accounts, enabled);

    }



    function isBlacklisted(address account) public view returns (bool) {

        return antiSnipe.isBlacklisted(account);

    }



    function removeSniper(address account) external onlyOwner {

        antiSnipe.removeSniper(account);

    }



    function setProtectionSettings(bool _antiSnipe, bool _antiBlock) external onlyOwner {

        antiSnipe.setProtections(_antiSnipe, _antiBlock);

    }



    function setCooldown(uint8 amount) external onlyOwner {

        require(amount < 3, "Max block cooldown is 3.");

        antiSnipe.setCooldown(amount);

    }



    function getBlockCooldown() external view returns (bool, uint8) {

        return antiSnipe.getBlockCooldown();

    }



    function setTaxes(uint16 buyFee, uint16 sellFee, uint16 transferFee) external partialOrFullOwner {

        require(buyFee <= maxBuyTaxes

                && sellFee <= maxSellTaxes

                && transferFee <= maxTransferTaxes,

                "Cannot exceed maximums.");

        _taxRates.buyFee = buyFee;

        _taxRates.sellFee = sellFee;

        _taxRates.transferFee = transferFee;

    }



    function setRatios(uint16 marketing, uint16 buyback, uint16 treasury) external partialOrFullOwner {

        _ratios.marketing = marketing;

        _ratios.buyback = buyback;

        _ratios.treasury = treasury;

        _ratios.totalSwap = marketing + buyback + treasury;

        uint256 total = _taxRates.buyFee + _taxRates.sellFee;

        require(_ratios.totalSwap <= total, "Cannot exceed sum of buy and sell fees.");

    }





    function setWallets(address payable marketing, address payable buyback, address payable treasury) external partialOrFullOwner {

        _taxWallets.marketing = payable(marketing);

        _taxWallets.buyback = payable(buyback);

        _taxWallets.treasury = payable(treasury);

    }



    function setMaxTxPercent(uint256 percent, uint256 divisor) external onlyOwner {

        require((_tTotal * percent) / divisor >= (_tTotal / 1000), "Max Transaction amt must be above 0.1% of total supply.");

        _maxTxAmount = (_tTotal * percent) / divisor;

    }



    function setMaxWalletSize(uint256 percent, uint256 divisor) external onlyOwner {

        require((_tTotal * percent) / divisor >= (_tTotal / 100), "Max Wallet amt must be above 1% of total supply.");

        _maxWalletSize = (_tTotal * percent) / divisor;

    }



    function getMaxTX() public view returns (uint256) {

        return _maxTxAmount / (10**_decimals);

    }



    function getMaxWallet() public view returns (uint256) {

        return _maxWalletSize / (10**_decimals);

    }



    function setSwapSettings(uint256 thresholdPercent, uint256 thresholdDivisor, uint256 amountPercent, uint256 amountDivisor) external onlyOwner {

        swapThreshold = (_tTotal * thresholdPercent) / thresholdDivisor;

        swapAmount = (_tTotal * amountPercent) / amountDivisor;

        require(swapThreshold <= swapAmount, "Threshold cannot be above amount.");

    }



    function setPriceImpactSwapAmount(uint256 priceImpactSwapPercent) external onlyOwner {

        require(priceImpactSwapPercent <= 300, "Cannot set above 3%.");

        piSwapPercent = priceImpactSwapPercent;

    }



    function setContractSwapEnabled(bool swapEnabled, bool priceImpactSwapEnabled) external onlyOwner {

        contractSwapEnabled = swapEnabled;

        piContractSwapsEnabled = priceImpactSwapEnabled;

        emit ContractSwapEnabledUpdated(swapEnabled);

    }



    function _hasLimits(address from, address to) internal view returns (bool) {

        return from != _owner

            && to != _owner

            && tx.origin != _owner

            && !_liquidityHolders[to]

            && !_liquidityHolders[from]

            && to != DEAD

            && to != address(0)

            && from != address(this);

    }



    function _transfer(address from, address to, uint256 amount) internal returns (bool) {

        require(from != address(0), "ERC20: transfer from the zero address");

        require(to != address(0), "ERC20: transfer to the zero address");

        require(amount > 0, "Transfer amount must be greater than zero");

        bool buy = false;

        bool sell = false;

        bool other = false;

        if (lpPairs[from]) {

            buy = true;

        } else if (lpPairs[to]) {

            sell = true;

        } else {

            other = true;

        }

        if(_hasLimits(from, to)) {

            if(!tradingEnabled) {

                revert("Trading not yet enabled!");

            }

            if(buy || sell){

                if (!_isExcludedFromLimits[from] && !_isExcludedFromLimits[to]) {

                    require(amount <= _maxTxAmount, "Transfer amount exceeds the maxTxAmount.");

                }

            }

            if(to != address(dexRouter) && !sell) {

                if (!_isExcludedFromLimits[to]) {

                    require(balanceOf(to) + amount <= _maxWalletSize, "Transfer amount exceeds the maxWalletSize.");

                }

            }

        }



        bool takeFee = true;

        if(_isExcludedFromFees[from] || _isExcludedFromFees[to]){

            takeFee = false;

        }



        if (sell) {

            if (!inSwap

                && contractSwapEnabled

            ) {

                uint256 contractTokenBalance = balanceOf(address(this));

                if (contractTokenBalance >= swapThreshold) {

                    uint256 swapAmt = swapAmount;

                    if(piContractSwapsEnabled) { swapAmt = (balanceOf(lpPair) * piSwapPercent) / masterTaxDivisor; }

                    if(contractTokenBalance >= swapAmt) { contractTokenBalance = swapAmt; }

                    contractSwap(contractTokenBalance);

                }

            }

        } 

        return _finalizeTransfer(from, to, amount, takeFee, buy, sell, other);

    }



    function contractSwap(uint256 contractTokenBalance) internal lockTheSwap {

        Ratios memory ratios = _ratios;

        if (ratios.totalSwap == 0) {

            return;

        }



        if(_allowances[address(this)][address(dexRouter)] != type(uint256).max) {

            _allowances[address(this)][address(dexRouter)] = type(uint256).max;

        }

        

        address[] memory path = new address[](2);

        path[0] = address(this);

        path[1] = dexRouter.WETH();



        dexRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(

            contractTokenBalance,

            0,

            path,

            address(this),

            block.timestamp

        );



        uint256 amtBalance = address(this).balance;

        bool success;

        uint256 buybackBalance = (amtBalance * ratios.buyback) / ratios.totalSwap;

        uint256 treasuryBalance = (amtBalance * ratios.treasury) / ratios.totalSwap;

        uint256 marketingBalance = amtBalance - (buybackBalance + treasuryBalance);

        if (ratios.marketing > 0) {

            (success,) = _taxWallets.marketing.call{value: marketingBalance, gas: 30000}("");

        }

        if (ratios.buyback > 0) {

            (success,) = _taxWallets.buyback.call{value: buybackBalance, gas: 30000}("");

        }

        if (ratios.treasury > 0) {

            (success,) = _taxWallets.treasury.call{value: treasuryBalance, gas: 30000}("");

        }

    }



    function _checkLiquidityAdd(address from, address to) internal {

        require(!_hasLiqBeenAdded, "Liquidity already added and marked.");

        if (!_hasLimits(from, to) && to == lpPair) {

            _liquidityHolders[from] = true;

            _hasLiqBeenAdded = true;

            if(address(antiSnipe) == address(0)){

                antiSnipe = AntiSnipe(address(this));

            }

            contractSwapEnabled = true;

            emit ContractSwapEnabledUpdated(true);

        }

    }



    function enableTrading() public onlyOwner {

        require(!tradingEnabled, "Trading already enabled!");

        require(_hasLiqBeenAdded, "Liquidity must be added.");

        if(address(antiSnipe) == address(0)){

            antiSnipe = AntiSnipe(address(this));

        }

        try antiSnipe.setLaunch(lpPair, uint32(block.number), uint64(block.timestamp), _decimals) {} catch {}

        tradingEnabled = true;

        swapThreshold = (balanceOf(lpPair) * 10) / 10000;

        swapAmount = (balanceOf(lpPair) * 25) / 10000;

    }



    function sweepContingency() external onlyOwner {

        require(!_hasLiqBeenAdded, "Cannot call after liquidity.");

        payable(_owner).transfer(address(this).balance);

    }



    function multiSendTokens(address[] memory accounts, uint256[] memory amounts) external onlyOwner {

        require(accounts.length == amounts.length, "Lengths do not match.");

        for (uint8 i = 0; i < accounts.length; i++) {

            require(balanceOf(msg.sender) >= amounts[i]);

            _finalizeTransfer(msg.sender, accounts[i], amounts[i]*10**_decimals, false, false, false, true);

        }

    }



    function _finalizeTransfer(address from, address to, uint256 amount, bool takeFee, bool buy, bool sell, bool other) internal returns (bool) {

        if (!_hasLiqBeenAdded) {

            _checkLiquidityAdd(from, to);

            if (!_hasLiqBeenAdded && _hasLimits(from, to) && !_isExcludedFromProtection[from] && !_isExcludedFromProtection[to] && !other) {

                revert("Pre-liquidity transfer protection.");

            }

        }



        if (_hasLimits(from, to)) {

            bool checked;

            try antiSnipe.checkUser(from, to, amount) returns (bool check) {

                checked = check;

            } catch {

                revert();

            }



            if(!checked) {

                revert();

            }

        }



        _tOwned[from] -= amount;

        uint256 amountReceived = (takeFee) ? takeTaxes(from, buy, sell, amount) : amount;

        _tOwned[to] += amountReceived;



        emit Transfer(from, to, amountReceived);

        return true;

    }



    function takeTaxes(address from, bool buy, bool sell, uint256 amount) internal returns (uint256) {

        uint256 currentFee;

        if (buy) {

            currentFee = _taxRates.buyFee;

        } else if (sell) {

            currentFee = _taxRates.sellFee;

        } else {

            currentFee = _taxRates.transferFee;

        }



        uint256 feeAmount = amount * currentFee / masterTaxDivisor;



        _tOwned[address(this)] += feeAmount;

        emit Transfer(from, address(this), feeAmount);



        return amount - feeAmount;

    }

}