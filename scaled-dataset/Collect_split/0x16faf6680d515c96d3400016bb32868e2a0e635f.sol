pragma solidity ^0.4.20;



/*





   ___  ____      _    ____ _     _____   ____  ______   ______ _   _  ___    _     ___ _____ _____ 

  / _ \|  _ \    / \  / ___| |   | ____| |  _ \/ ___\ \ / / ___| | | |/ _ \  | |   |_ _|  ___| ____|

 | | | | |_) |  / _ \| |   | |   |  _|   | |_) \___ \\ V / |   | |_| | | | | | |    | || |_  |  _|  

 | |_| |  _ <  / ___ \ |___| |___| |___  |  __/ ___) || || |___|  _  | |_| | | |___ | ||  _| | |___ 

  \___/|_| \_\/_/   \_\____|_____|_____| |_|   |____/ |_| \____|_| |_|\___/  |_____|___|_|   |_____|

                                                                                                    









 /$$$$$$        /$$$$$$  /$$      /$$        /$$$$$$  /$$$$$$

|_  $$_/       /$$__  $$| $$$    /$$$       /$$__  $$|_  $$_/

  | $$        | $$  \ $$| $$$$  /$$$$      | $$  \ $$  | $$  

  | $$        | $$$$$$$$| $$ $$/$$ $$      | $$$$$$$$  | $$  

  | $$        | $$__  $$| $$  $$$| $$      | $$__  $$  | $$  

  | $$        | $$  | $$| $$\  $ | $$      | $$  | $$  | $$  

 /$$$$$$      | $$  | $$| $$ \/  | $$      | $$  | $$ /$$$$$$

|______/      |__/  |__/|__/     |__/      |__/  |__/|______/

                                                             

                                                             

                                                             







██╗    ██╗██╗  ██╗███████╗██████╗ ███████╗    ███╗   ███╗██╗   ██╗    ███████╗ ██████╗  ██████╗     ███████╗████████╗██╗  ██╗██████╗ 

██║    ██║██║  ██║██╔════╝██╔══██╗██╔════╝    ████╗ ████║╚██╗ ██╔╝    ██╔════╝██╔═████╗██╔═████╗    ██╔════╝╚══██╔══╝██║  ██║╚════██╗

██║ █╗ ██║███████║█████╗  ██████╔╝█████╗      ██╔████╔██║ ╚████╔╝     ███████╗██║██╔██║██║██╔██║    █████╗     ██║   ███████║  ▄███╔╝

██║███╗██║██╔══██║██╔══╝  ██╔══██╗██╔══╝      ██║╚██╔╝██║  ╚██╔╝      ╚════██║████╔╝██║████╔╝██║    ██╔══╝     ██║   ██╔══██║  ▀▀══╝ 

╚███╔███╔╝██║  ██║███████╗██║  ██║███████╗    ██║ ╚═╝ ██║   ██║       ███████║╚██████╔╝╚██████╔╝    ███████╗   ██║   ██║  ██║  ██╗   

 ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝   ╚═╝       ╚══════╝ ╚═════╝  ╚═════╝     ╚══════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝   

                                                                                                                                     

















d8888b. db    db db    db      d8888b. db      db    db d88888b       .o88b. db   db d888888b d8888b. 

88  `8D 88    88 `8b  d8'      88  `8D 88      88    88 88'          d8P  Y8 88   88   `88'   88  `8D 

88oooY' 88    88  `8bd8'       88oooY' 88      88    88 88ooooo      8P      88ooo88    88    88oodD' 

88~~~b. 88    88    88         88~~~b. 88      88    88 88~~~~~      8b      88~~~88    88    88~~~   

88   8D 88b  d88    88         88   8D 88booo. 88b  d88 88.          Y8b  d8 88   88   .88.   88      

Y8888P' ~Y8888P'    YP         Y8888P' Y88888P ~Y8888P' Y88888P       `Y88P' YP   YP Y888888P 88      

                                                                                                      

                                                                                                      











____ ____ _    _       ___  _    _  _ ____    ____ _  _ _ ___  

[__  |___ |    |       |__] |    |  | |___    |    |__| | |__] 

___] |___ |___ |___    |__] |___ |__| |___    |___ |  | | |    

                                                               

















                                                                                                                                                                         

                                                                                                                                                                         

________  ____   ____     ____________          ____   ____    ______________         ____  ____                _              ____      ____         _     ___       ___

`MMMMMMMb.`MM'   `MM'     `M`MMMMMMMMM         6MMMMb/ `MM'    `MM`MM`MMMMMMMb.       `MM' 6MMMMb\             dM.            6MMMMb\   6MMMMb/      dM.    `MMb     dMM'

 MM    `Mb MM     MM       M MM      \        8P    YM  MM      MM MM MM    `Mb        MM 6M'    `            ,MMb           6M'    `  8P    YM     ,MMb     MMM.   ,PMM 

 MM     MM MM     MM       M MM              6M      Y  MM      MM MM MM     MM        MM MM                  d'YM.          MM       6M      Y     d'YM.    M`Mb   d'MM 

 MM    .M9 MM     MM       M MM    ,         MM         MM      MM MM MM     MM        MM YM.                ,P `Mb          YM.      MM           ,P `Mb    M YM. ,P MM 

 MMMMMMM(  MM     MM       M MMMMMMM         MM         MMMMMMMMMM MM MM    .M9        MM  YMMMMb            d'  YM.          YMMMMb  MM           d'  YM.   M `Mb d' MM 

 MM    `Mb MM     MM       M MM    `         MM         MM      MM MM MMMMMMM9'        MM      `Mb          ,P   `Mb              `Mb MM          ,P   `Mb   M  YM.P  MM 

 MM     MM MM     MM       M MM              MM         MM      MM MM MM               MM       MM          d'    YM.              MM MM          d'    YM.  M  `Mb'  MM 

 MM     MM MM     YM       M MM              YM      6  MM      MM MM MM               MM       MM         ,MMMMMMMMb              MM YM      6  ,MMMMMMMMb  M   YP   MM 

 MM    .M9 MM    / 8b     d8 MM      /        8b    d9  MM      MM MM MM               MM L    ,M9         d'      YM.       L    ,M9  8b    d9  d'      YM. M   `'   MM 

_MMMMMMM9'_MMMMMMM  YMMMMM9 _MMMMMMMMM         YMMMM9  _MM_    _MM_MM_MM_             _MM_MYMMMM9        _dM_     _dMM_      MYMMMM9    YMMMM9 _dM_     _dMM_M_      _MM_

                                                                                                                                                                         

                                                                                                                                                                         

                                                                                                                                                                         









   ▄████████  ▄█        ▄█             ▄█  ███▄▄▄▄           ▄██████▄     ▄█    █▄       ▄████████ ███▄▄▄▄   ████████▄   ▄█       ▄█  ▄█  

  ███    ███ ███       ███            ███  ███▀▀▀██▄        ███    ███   ███    ███     ███    ███ ███▀▀▀██▄ ███   ▀███ ███      ███ ███  

  ███    ███ ███       ███            ███▌ ███   ███        ███    █▀    ███    ███     ███    ███ ███   ███ ███    ███ ███▌     ███ ███▌ 

  ███    ███ ███       ███            ███▌ ███   ███       ▄███         ▄███▄▄▄▄███▄▄   ███    ███ ███   ███ ███    ███ ███▌     ███ ███▌ 

▀███████████ ███       ███            ███▌ ███   ███      ▀▀███ ████▄  ▀▀███▀▀▀▀███▀  ▀███████████ ███   ███ ███    ███ ███▌     ███ ███▌ 

  ███    ███ ███       ███            ███  ███   ███        ███    ███   ███    ███     ███    ███ ███   ███ ███    ███ ███      ███ ███  

  ███    ███ ███▌    ▄ ███▌    ▄      ███  ███   ███        ███    ███   ███    ███     ███    ███ ███   ███ ███   ▄███ ███      ███ ███  

  ███    █▀  █████▄▄██ █████▄▄██      █▀    ▀█   █▀         ████████▀    ███    █▀      ███    █▀   ▀█   █▀  ████████▀  █▀   █▄ ▄███ █▀   

             ▀         ▀                                                                                                     ▀▀▀▀▀▀       















    ____   _       ________    __       ____  ____ _  __    __  ______  __  __

   /  _/  | |     / /  _/ /   / /      / __ \/ __ \ |/ /    \ \/ / __ \/ / / /

   / /    | | /| / // // /   / /      / / / / / / /   /      \  / / / / / / / 

 _/ /     | |/ |/ // // /___/ /___   / /_/ / /_/ /   |       / / /_/ / /_/ /  

/___/     |__/|__/___/_____/_____/  /_____/\____/_/|_|      /_/\____/\____/   

                                                                              









* ORACLE PYSCHO NETWORK

* 

* The Coin backed by Oracle's crazed mind

*

* Each token is backed by 1 gram of 100.000% pure Oracle Psychotic Synapses   ;-)

*

* Buy and Sell Fees are  33.3%

*

* Use your referral link to gain 33% of the Buy-In Fees when someone uses your Masternode

*

* HAVE SOME FUN AT THE EXPENSE OF ORACLE

*

* You can send ETH directly to the contract or play here:  https://oraclepsycho.life/

*

* Discord:   https://discord.gg/z2suXdN

*

*/



contract ORACLEPSYCHOLIFE {

    /*=================================

    =            MODIFIERS            =

    =================================*/

    // only people with tokens

    modifier onlyBagholders() {

        require(myTokens() > 0);

        _;

    }

    

    // only people with profits

    modifier onlyStronghands() {

        require(myDividends(true) > 0);

        _;

    }

    

    // administrators can:

    // -> change the name of the contract

    // -> change the name of the token

    // -> change the PoS difficulty (How many tokens it costs to hold a masternode, in case it gets crazy high later)

    // they CANNOT:

    // -> take funds

    // -> disable withdrawals

    // -> kill the contract

    // -> change the price of tokens

    modifier onlyAdministrator(){

        address _customerAddress = msg.sender;



        require(administrators[_customerAddress]);

        _;

    }

    

    

    // ensures that the first tokens in the contract will be equally distributed

    // meaning, no divine dump will be ever possible

    // result: healthy longevity.

    modifier antiEarlyWhale(uint256 _amountOfEthereum){

        address _customerAddress = msg.sender;

        

        // are we still in the vulnerable phase?

        // if so, enact anti early whale protocol 

        if( onlyAmbassadors && ((totalEthereumBalance() - _amountOfEthereum) <= ambassadorQuota_ )){

            require(

                // is the customer in the ambassador list?

                ambassadors_[_customerAddress] == true &&

                

                // does the customer purchase exceed the max ambassador quota?

                (ambassadorAccumulatedQuota_[_customerAddress] + _amountOfEthereum) <= ambassadorMaxPurchase_

                

            );

            

            // updated the accumulated quota    

            ambassadorAccumulatedQuota_[_customerAddress] = SafeMath.add(ambassadorAccumulatedQuota_[_customerAddress], _amountOfEthereum);

        

            // execute

            _;

        } else {

            // in case the ether count drops low, the ambassador phase won't reinitiate

            onlyAmbassadors = false;

            _;    

        }

        

    }

    

    

    /*==============================

    =            EVENTS            =

    ==============================*/

    event onTokenPurchase(

        address indexed customerAddress,

        uint256 incomingEthereum,

        uint256 tokensMinted,

        address indexed referredBy

    );

    

    event onTokenSell(

        address indexed customerAddress,

        uint256 tokensBurned,

        uint256 ethereumEarned

    );

    

    event onReinvestment(

        address indexed customerAddress,

        uint256 ethereumReinvested,

        uint256 tokensMinted

    );

    

    event onWithdraw(

        address indexed customerAddress,

        uint256 ethereumWithdrawn

    );

    

    // ERC20

    event Transfer(

        address indexed from,

        address indexed to,

        uint256 tokens

    );



    

    /*=====================================

    =            CONFIGURABLES            =

    =====================================*/

    string public name = "ORACLEPSYCHOLIFE";

    string public symbol = "DONUTS";

    uint8 constant public decimals = 18;

    uint8 constant internal dividendFee_ = 3;

    uint256 constant internal tokenPriceInitial_ = 0.000000001 ether;

    uint256 constant internal tokenPriceIncremental_ = 0.0000000001 ether;

    uint256 constant internal magnitude = 2**64;

    

    uint256 public stakingRequirement = 100e18;

    

    // ambassador program

    mapping(address => bool) internal ambassadors_;

    uint256 constant internal ambassadorMaxPurchase_ = 1 ether;

    uint256 constant internal ambassadorQuota_ = 20 ether;

    

    

    

   /*================================

    =            DATASETS            =

    ================================*/

    // amount of shares for each address (scaled number)

    mapping(address => uint256) internal tokenBalanceLedger_;

    mapping(address => uint256) internal referralBalance_;

    mapping(address => int256) internal payoutsTo_;

    mapping(address => uint256) internal ambassadorAccumulatedQuota_;

    uint256 internal tokenSupply_ = 0;

    uint256 internal profitPerShare_;

    

    // administrator list (see above on what they can do)

    //mapping(bytes32 => bool) public administrators;

    mapping(address => bool) public administrators;

    

    // when this is set to true, only ambassadors can purchase tokens (this prevents a whale premine, it ensures a fairly distributed upper pyramid)

    bool public onlyAmbassadors = true;



    address Admin;

    





    /*=======================================

    =            PUBLIC FUNCTIONS            =

    =======================================*/

    /*

    * -- APPLICATION ENTRY POINTS --  

    */

    function ORACLEPSYCHOLIFE()

        public

    {

        // add administrators here





        administrators[msg.sender] = true;



        Admin = msg.sender;



        onlyAmbassadors = false;



    }

    

     

    /**

     * Converts all incoming ethereum to tokens for the caller, and passes down the referral addy (if any)

     */

    function buy(address _referredBy)

        public

        payable

        returns(uint256)

    {

        purchaseTokens(msg.value, _referredBy);

    }

    

    /**

     * Fallback function to handle ethereum that was send straight to the contract

     * Unfortunately we cannot use a referral address this way.

     */

    function()

        payable

        public

    {

        purchaseTokens(msg.value, 0x0);

    }

    

    /**

     * Converts all of caller's dividends to tokens.

     */

    function reinvest()

        onlyStronghands()

        public

    {

        // fetch dividends

        uint256 _dividends = myDividends(false); // retrieve ref. bonus later in the code

        

        // pay out the dividends virtually

        address _customerAddress = msg.sender;

        payoutsTo_[_customerAddress] +=  (int256) (_dividends * magnitude);

        

        // retrieve ref. bonus

        _dividends += referralBalance_[_customerAddress];

        referralBalance_[_customerAddress] = 0;

        

        // dispatch a buy order with the virtualized "withdrawn dividends"

        uint256 _tokens = purchaseTokens(_dividends, 0x0);

        

        // fire event

        onReinvestment(_customerAddress, _dividends, _tokens);

    }

    

    /**

     * Alias of sell() and withdraw().

     */

    function exit()

        public

    {

        // get token count for caller & sell them all

        address _customerAddress = msg.sender;

        uint256 _tokens = tokenBalanceLedger_[_customerAddress];

        if(_tokens > 0) sell(_tokens);

        

        // lambo delivery service

        withdraw();

    }



    /**

     * Withdraws all of the callers earnings.

     */

    function withdraw()

        onlyStronghands()

        public

    {

        // setup data

        address _customerAddress = msg.sender;

        uint256 _dividends = myDividends(false); // get ref. bonus later in the code

        

        // update dividend tracker

        payoutsTo_[_customerAddress] +=  (int256) (_dividends * magnitude);

        

        // add ref. bonus

        _dividends += referralBalance_[_customerAddress];

        referralBalance_[_customerAddress] = 0;

        

        // lambo delivery service

        _customerAddress.transfer(_dividends);

        

        // fire event

        onWithdraw(_customerAddress, _dividends);

    }

    

    /**

     * Liquifies tokens to ethereum.

     */

    function sell(uint256 _amountOfTokens)

        onlyBagholders()

        public

    {

        // setup data

        address _customerAddress = msg.sender;

        // russian hackers BTFO

        require(_amountOfTokens <= tokenBalanceLedger_[_customerAddress]);

        uint256 _tokens = _amountOfTokens;

        uint256 _ethereum = tokensToEthereum_(_tokens);

        uint256 _dividends = SafeMath.div(_ethereum, dividendFee_);

        uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);

        

        // burn the sold tokens

        tokenSupply_ = SafeMath.sub(tokenSupply_, _tokens);

        tokenBalanceLedger_[_customerAddress] = SafeMath.sub(tokenBalanceLedger_[_customerAddress], _tokens);

        

        // update dividends tracker

        int256 _updatedPayouts = (int256) (profitPerShare_ * _tokens + (_taxedEthereum * magnitude));

        payoutsTo_[_customerAddress] -= _updatedPayouts;       

        

        // dividing by zero is a bad idea

        if (tokenSupply_ > 0) {

            // update the amount of dividends per token

            profitPerShare_ = SafeMath.add(profitPerShare_, (_dividends * magnitude) / tokenSupply_);

        }

        

        // fire event

        onTokenSell(_customerAddress, _tokens, _taxedEthereum);

    }

    

    

    /**

     * Transfer tokens from the caller to a new holder.

     * Remember, there's a 10% fee here as well.

     */

    function transfer(address _toAddress, uint256 _amountOfTokens)

        onlyBagholders()

        public

        returns(bool)

    {

        // setup

        address _customerAddress = msg.sender;

        

        // make sure we have the requested tokens

        // also disables transfers until ambassador phase is over

        // ( we dont want whale premines )

        require(!onlyAmbassadors && _amountOfTokens <= tokenBalanceLedger_[_customerAddress]);

        

        // withdraw all outstanding dividends first

        if(myDividends(true) > 0) withdraw();

        

        // liquify 10% of the tokens that are transfered

        // these are dispersed to shareholders

        uint256 _tokenFee = SafeMath.div(_amountOfTokens, dividendFee_);

        uint256 _taxedTokens = SafeMath.sub(_amountOfTokens, _tokenFee);

        uint256 _dividends = tokensToEthereum_(_tokenFee);

  

        // burn the fee tokens

        tokenSupply_ = SafeMath.sub(tokenSupply_, _tokenFee);



        // exchange tokens

        tokenBalanceLedger_[_customerAddress] = SafeMath.sub(tokenBalanceLedger_[_customerAddress], _amountOfTokens);

        tokenBalanceLedger_[_toAddress] = SafeMath.add(tokenBalanceLedger_[_toAddress], _taxedTokens);

        

        // update dividend trackers

        payoutsTo_[_customerAddress] -= (int256) (profitPerShare_ * _amountOfTokens);

        payoutsTo_[_toAddress] += (int256) (profitPerShare_ * _taxedTokens);

        

        // disperse dividends among holders

        profitPerShare_ = SafeMath.add(profitPerShare_, (_dividends * magnitude) / tokenSupply_);

        

        // fire event

        Transfer(_customerAddress, _toAddress, _taxedTokens);

        

        // ERC20

        return true;

       

    }

    

    /*----------  ADMINISTRATOR ONLY FUNCTIONS  ----------*/

    /**

     * In case the amassador quota is not met, the administrator can manually disable the ambassador phase.

     */

    function disableInitialStage()

        onlyAdministrator()

        public

    {

        onlyAmbassadors = false;

    }

    

    /**

     * In case one of us dies, we need to replace ourselves.

     */

    function setAdministrator(address _identifier, bool _status)

        onlyAdministrator()

        public

    {

        administrators[_identifier] = _status;

    }

    

    /**

     * Precautionary measures in case we need to adjust the masternode rate.

     */

    function setStakingRequirement(uint256 _amountOfTokens)

        onlyAdministrator()

        public

    {

        stakingRequirement = _amountOfTokens;

    }

    

    /**

     * If we want to rebrand, we can.

     */

    function setName(string _name)

        onlyAdministrator()

        public

    {

        name = _name;

    }

    

    /**

     * If we want to rebrand, we can.

     */

    function setSymbol(string _symbol)

        onlyAdministrator()

        public

    {

        symbol = _symbol;

    }



    

    /*----------  HELPERS AND CALCULATORS  ----------*/

    /**

     * Method to view the current Ethereum stored in the contract

     * Example: totalEthereumBalance()

     */

    function totalEthereumBalance()

        public

        view

        returns(uint)

    {

        return address (this).balance;

    }

    

    /**

     * Retrieve the total token supply.

     */

    function totalSupply()

        public

        view

        returns(uint256)

    {

        return tokenSupply_;

    }

    

    /**

     * Retrieve the tokens owned by the caller.

     */

    function myTokens()

        public

        view

        returns(uint256)

    {

        address _customerAddress = msg.sender;

        return balanceOf(_customerAddress);

    }

    

    /**

     * Retrieve the dividends owned by the caller.

     * If `_includeReferralBonus` is to to 1/true, the referral bonus will be included in the calculations.

     * The reason for this, is that in the frontend, we will want to get the total divs (global + ref)

     * But in the internal calculations, we want them separate. 

     */ 

    function myDividends(bool _includeReferralBonus) 

        public 

        view 

        returns(uint256)

    {

        address _customerAddress = msg.sender;

        return _includeReferralBonus ? dividendsOf(_customerAddress) + referralBalance_[_customerAddress] : dividendsOf(_customerAddress) ;

    }

    

    /**

     * Retrieve the token balance of any single address.

     */

    function balanceOf(address _customerAddress)

        view

        public

        returns(uint256)

    {

        return tokenBalanceLedger_[_customerAddress];

    }

    

    /**

     * Retrieve the dividend balance of any single address.

     */

    function dividendsOf(address _customerAddress)

        view

        public

        returns(uint256)

    {

        return (uint256) ((int256)(profitPerShare_ * tokenBalanceLedger_[_customerAddress]) - payoutsTo_[_customerAddress]) / magnitude;

    }

    

    /**

     * Return the buy price of 1 individual token.

     */

    function sellPrice() 

        public 

        view 

        returns(uint256)

    {

        // our calculation relies on the token supply, so we need supply. Doh.

        if(tokenSupply_ == 0){

            return tokenPriceInitial_ - tokenPriceIncremental_;

        } else {

            uint256 _ethereum = tokensToEthereum_(1e18);

            uint256 _dividends = SafeMath.div(_ethereum, dividendFee_  );

            uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);

            return _taxedEthereum;

        }

    }

    

    /**

     * Return the sell price of 1 individual token.

     */

    function buyPrice() 

        public 

        view 

        returns(uint256)

    {

        // our calculation relies on the token supply, so we need supply. Doh.

        if(tokenSupply_ == 0){

            return tokenPriceInitial_ + tokenPriceIncremental_;

        } else {

            uint256 _ethereum = tokensToEthereum_(1e18);

            uint256 _dividends = SafeMath.div(_ethereum, dividendFee_  );

            uint256 _taxedEthereum = SafeMath.add(_ethereum, _dividends);

            return _taxedEthereum;

        }

    }

    

    /**

     * Function for the frontend to dynamically retrieve the price scaling of buy orders.

     */

    function calculateTokensReceived(uint256 _ethereumToSpend) 

        public 

        view 

        returns(uint256)

    {

        uint256 _dividends = SafeMath.div(_ethereumToSpend, dividendFee_);

        uint256 _taxedEthereum = SafeMath.sub(_ethereumToSpend, _dividends);

        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);

        

        return _amountOfTokens;

    }

    

    /**

     * Function for the frontend to dynamically retrieve the price scaling of sell orders.

     */

    function calculateEthereumReceived(uint256 _tokensToSell) 

        public 

        view 

        returns(uint256)

    {

        require(_tokensToSell <= tokenSupply_);

        uint256 _ethereum = tokensToEthereum_(_tokensToSell);

        uint256 _dividends = SafeMath.div(_ethereum, dividendFee_);

        uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);

        return _taxedEthereum;

    }

    

    

    /*==========================================

    =            INTERNAL FUNCTIONS            =

    ==========================================*/

    function purchaseTokens(uint256 _incomingEthereum, address _referredBy)

        antiEarlyWhale(_incomingEthereum)

        internal

        returns(uint256)

    {

        // data setup

        address _customerAddress = msg.sender;

        uint256 _undividedDividends = SafeMath.div(_incomingEthereum, dividendFee_);

        uint256 _referralBonus = SafeMath.div(_undividedDividends, 3);

        uint256 _dividends = SafeMath.sub(_undividedDividends, _referralBonus);

        uint256 _taxedEthereum = SafeMath.sub(_incomingEthereum, _undividedDividends);

        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);

        uint256 _fee = _dividends * magnitude;

 

        // no point in continuing execution if OP is a poorfag russian hacker

        // prevents overflow in the case that the pyramid somehow magically starts being used by everyone in the world

        // (or hackers)

        // and yes we know that the safemath function automatically rules out the "greater then" equasion.

        require(_amountOfTokens > 0 && (SafeMath.add(_amountOfTokens,tokenSupply_) > tokenSupply_));

        

        // is the user referred by a masternode?

        if(

          

            // is this a referred purchase?

            _referredBy != 0x0000000000000000000000000000000000000000 &&



            // no cheating!

            _referredBy != _customerAddress &&

            

            // does the referrer have at least X whole tokens?

            // i.e is the referrer a godly chad masternode

            tokenBalanceLedger_[_referredBy] >= stakingRequirement

        ){

            // wealth redistribution

            referralBalance_[_referredBy] = SafeMath.add(referralBalance_[_referredBy], _referralBonus);

            

        } else {

            // no ref purchase

            // add the referral bonus back to the global dividends cake

            _dividends = SafeMath.add(_dividends, _referralBonus);

            _fee = _dividends * magnitude;

        }

        

        // we can't give people infinite ethereum

        if(tokenSupply_ > 0){

            

            // add tokens to the pool

            tokenSupply_ = SafeMath.add(tokenSupply_, _amountOfTokens);

 

            // take the amount of dividends gained through this transaction, and allocates them evenly to each shareholder

            profitPerShare_ += (_dividends * magnitude / (tokenSupply_));

            

            // calculate the amount of tokens the customer receives over his purchase 

            _fee = _fee - (_fee-(_amountOfTokens * (_dividends * magnitude / (tokenSupply_))));

        

        } else {

            // add tokens to the pool

            tokenSupply_ = _amountOfTokens;

        }

        

        // update circulating supply & the ledger address for the customer

        tokenBalanceLedger_[_customerAddress] = SafeMath.add(tokenBalanceLedger_[_customerAddress], _amountOfTokens);

        

        // Tells the contract that the buyer doesn't deserve dividends for the tokens before they owned them;

        //really i know you think you do but you don't

        int256 _updatedPayouts = (int256) ((profitPerShare_ * _amountOfTokens) - _fee);

        payoutsTo_[_customerAddress] += _updatedPayouts;

        

        // fire event

        onTokenPurchase(_customerAddress, _incomingEthereum, _amountOfTokens, _referredBy);

        

        return _amountOfTokens;

    }



    /**

     * Calculate Token price based on an amount of incoming ethereum

     * It's an algorithm, hopefully we gave you the whitepaper with it in scientific notation;

     * Some conversions occurred to prevent decimal errors or underflows / overflows in solidity code.

     */

    function ethereumToTokens_(uint256 _ethereum)

        internal

        view

        returns(uint256)

    {

        uint256 _tokenPriceInitial = tokenPriceInitial_ * 1e18;

        uint256 _tokensReceived = 

         (

            (

                // underflow attempts BTFO

                SafeMath.sub(

                    (sqrt

                        (

                            (_tokenPriceInitial**2)

                            +

                            (2*(tokenPriceIncremental_ * 1e18)*(_ethereum * 1e18))

                            +

                            (((tokenPriceIncremental_)**2)*(tokenSupply_**2))

                            +

                            (2*(tokenPriceIncremental_)*_tokenPriceInitial*tokenSupply_)

                        )

                    ), _tokenPriceInitial

                )

            )/(tokenPriceIncremental_)

        )-(tokenSupply_)

        ;

  

        return _tokensReceived;

    }

    

    /**

     * Calculate token sell value.

     * It's an algorithm, hopefully we gave you the whitepaper with it in scientific notation;

     * Some conversions occurred to prevent decimal errors or underflows / overflows in solidity code.

     */

     function tokensToEthereum_(uint256 _tokens)

        internal

        view

        returns(uint256)

    {



        uint256 tokens_ = (_tokens + 1e18);

        uint256 _tokenSupply = (tokenSupply_ + 1e18);

        uint256 _etherReceived =

        (

            // underflow attempts BTFO

            SafeMath.sub(

                (

                    (

                        (

                            tokenPriceInitial_ +(tokenPriceIncremental_ * (_tokenSupply/1e18))

                        )-tokenPriceIncremental_

                    )*(tokens_ - 1e18)

                ),(tokenPriceIncremental_*((tokens_**2-tokens_)/1e18))/2

            )

        /1e18);

        return _etherReceived;

    }

    

    

    //This is where all your gas goes, sorry

    //Not sorry, you probably only paid 1 gwei

    function sqrt(uint x) internal pure returns (uint y) {

        uint z = (x + 1) / 2;

        y = x;

        while (z < y) {

            y = z;

            z = (x / z + z) / 2;

        }

    }

}



/**

 * @title SafeMath

 * @dev Math operations with safety checks that throw on error

 */

library SafeMath {



    /**

    * @dev Multiplies two numbers, throws on overflow.

    */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }

        uint256 c = a * b;

        assert(c / a == b);

        return c;

    }



    /**

    * @dev Integer division of two numbers, truncating the quotient.

    */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        // assert(b > 0); // Solidity automatically throws when dividing by 0

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;

    }



    /**

    * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).

    */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        assert(b <= a);

        return a - b;

    }



    /**

    * @dev Adds two numbers, throws on overflow.

    */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        assert(c >= a);

        return c;

    }

}