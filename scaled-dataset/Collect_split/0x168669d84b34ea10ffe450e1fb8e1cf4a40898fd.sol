pragma solidity ^0.4.26;



contract Ownable {



  address public owner;



  constructor() public {

    owner = msg.sender;

  }



  modifier onlyOwner() {

    require(msg.sender == owner);

    _;

  }



  function transferOwnership(address newOwner) public onlyOwner {

    require(newOwner != address(0));

    owner = newOwner;

  }

}



interface Token {

  function transfer(address _to, uint256 _value) external returns (bool);

  function balanceOf(address _owner) external view returns (uint256 balance);

}



contract AirDrop is Ownable {



  Token token;



  event TransferredToken(address indexed to, uint256 value);

  event FailedTransfer(address indexed to, uint256 value);



  constructor() public {

      address _tokenAddr = 0xc8Cac7672f4669685817cF332a33Eb249F085475;

      token = Token(_tokenAddr);

  }



  function sendTokens(address[] dests, uint256[] values) onlyOwner external {

    uint256 i = 0;

    while (i < dests.length) {

        sendInternally(dests[i], values[i] * 10**18, values[i]);

        i++;

    }

  }



  function sendTokensSingleValue(address[] dests, uint256 value) onlyOwner external {

    uint256 i = 0;

    uint256 toSend = value * 10**18;

    while (i < dests.length) {

        sendInternally(dests[i], toSend, value);

        i++;

    }

  }  



  function sendInternally(address recipient, uint256 tokensToSend, uint256 valueToPresent) internal {

    if(recipient == address(0)) return;



    if(tokensAvailable() >= tokensToSend) {

      token.transfer(recipient, tokensToSend);

      emit TransferredToken(recipient, valueToPresent);

    } else {

      emit FailedTransfer(recipient, valueToPresent); 

    }

  }





  function tokensAvailable() public constant returns (uint256) {

    return token.balanceOf(this);

  }



  function destroy() public onlyOwner {

    uint256 balance = tokensAvailable();

    require (balance > 0);

    token.transfer(owner, balance);

    selfdestruct(owner);

  }

}