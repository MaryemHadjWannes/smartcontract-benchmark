// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;



interface ERC20 {

	function balanceOf(address) external view returns (uint256);

	function transfer(address, uint256) external returns (bool);

}



contract LmaoPresale {



	uint256 public constant MAX_AMOUNT = 5e22; // Max of 50k tokens per purchase

	uint256 public constant LOCK_PERIOD = 14 days;



	// Info of each presale buyer

	struct BuyerInfo {

		uint256 initialAmount; // LMAO purchased immediately available to withdraw

		uint256 lockedAmount; // LMAO purchased locked for 2 weeks

	}



	mapping (address => BuyerInfo) public buyers;



	ERC20 public lmao;

	address public owner;

	bool public liquidityAdded;

	uint256 public lockStart;



	constructor(ERC20 _lmao) {

		lmao = _lmao;

		owner = msg.sender;

		

		// Add all of the presale buyers

		_add(0xfB7cdC3FCf977Eb35e978b3a5857466D5172D49f, MAX_AMOUNT);

		_add(0xc0ffee008Fbe30dB8116BBcf1BF8a94c9c044647, MAX_AMOUNT);

		_add(0x2b7b9a0a14921811BB55a3449e411c8dAf002b65, MAX_AMOUNT);

		_add(0x2c5a1b217f447afEc9939c270a64C10ED004e29c, MAX_AMOUNT);

		_add(0x164f867D49e5cffe24B7bA6E2AcC4a81504bd4C9, MAX_AMOUNT);

		_add(0xc60e8138e2d098a0dB897DA2fCBF6F220c337699, MAX_AMOUNT);

		_add(0xf42a339F93c1fA4c5D9ace33DB308A504E7B0bdE, MAX_AMOUNT);

		_add(0x2b732f067f440eDd49986dC6C50cB93af3698e10, MAX_AMOUNT);

		_add(0x4FF41725846525Dd25FC2B57a39B5e887C62FC4e, MAX_AMOUNT);

		_add(0x1649B7518ED8D64f07771Ee16DEF11174aFe8B12, MAX_AMOUNT);

		_add(0x4E1FE0409C2845C1Bde8fcbE21ac6889311c8aB5, MAX_AMOUNT);

		_add(0x06Ea4DDFb6B3195657D02Ff93a91AB73Fa168678, MAX_AMOUNT);

		_add(0xAc5dEFDD5b6B531B70fcA01ac14D3D5385164BBc, MAX_AMOUNT);

		_add(0x8F83Eb7ABb2bCf57347298d9BF09A2d284190643, MAX_AMOUNT);

		_add(0x3cE77e5B6207d95d20A5B9214c072B5E241E6024, MAX_AMOUNT);

		_add(0xF7c92Bd13897875548718DccC3C7e797E19ef8Cb, MAX_AMOUNT);

		_add(0xa683C1b815997a7Fa38f6178c84675FC4c79AC2B, MAX_AMOUNT);

		_add(0xFE5E167d34FF3e8621c4D283B661d37B98B1F3cF, MAX_AMOUNT);

		_add(0xC697BE0b5b82284391A878B226e2f9AfC6B94710, MAX_AMOUNT);

		_add(0x6Ed450e062C20F929CB7Ee72fCc53e9697980a18, MAX_AMOUNT);

		_add(0x95759DcAfDB6495022F48f81181981496649fb2A, MAX_AMOUNT);

		_add(0x5Dcc979c0E3c12261F73c07AD90b909C5F8B95Dd, MAX_AMOUNT);

		_add(0xFaDED72464D6e76e37300B467673b36ECc4d2ccF, MAX_AMOUNT);

		_add(0x818354e4aE0DD09dEA9283fBE1B11e4B6388A512, MAX_AMOUNT);

		_add(0xDC7360c50F9c1E7842c12ee9ED625f189992BeCc, MAX_AMOUNT);

		_add(0x9682122F8d1E140560764139d1890A85fd8f6491, MAX_AMOUNT);

		_add(0xD74E63d3545A6c045A70D68c4A8D6560Df71827C, MAX_AMOUNT);

		_add(0x98d0E5A9063C05Bc36A14c01F99f41b354d53bF3, MAX_AMOUNT);

		_add(0x000000007D46ef92967C0c69AC814cCB0236bf80, MAX_AMOUNT);

		_add(0x49df6259E9b7DeaDa5dE9f305c1bA4fe04E8f68b, MAX_AMOUNT);

		_add(0xF0208b6e0A5Dfb1A7fE28b7e8B1Ee1000aBCd881, MAX_AMOUNT);

		_add(0x4FeaE79BC99D9c195d91c19eaAE66EF2d59C4E52, MAX_AMOUNT);

		_add(0xCA3E3Ff71782cda9fB5A7F2234287061f141e881, MAX_AMOUNT);

		_add(0xaD9F9194C68BD83250A534a7DA574687e1F102Ff, MAX_AMOUNT);

		_add(0x5D18d78ef5dcD9d06C363F83Ab9A097a0dB8F89d, MAX_AMOUNT);

		_add(0x2e0d3720cb65fE49F63dbAf2a49365665b6133fe, MAX_AMOUNT);

		_add(0xA81eac3009bD6E6cCE36602d6851fDA789dDC3BB, MAX_AMOUNT);

		_add(0x71246667Ad1212A7F8c7e13Cea986959CF094d01, MAX_AMOUNT);

		_add(0xed8C27d381A5DC51D531C0c975645Bc3Ce9EafA2, 36700000000000000000000);

		_add(0xa62ae16f5B47B5D0A0ed9740952867940382adA5, 32285620000000000000000);

		_add(0x65AcBdD002aa4B56396A1ec4988E65c974f70edc, 25605100000000000000000);

		_add(0xA387BE1520dCBAa3ba9aBca3fe13a010BD10Ba7d, 20000000000000000000000);

		_add(0x22406c0a2eb0A0a1c4FdABd56F695f205E3fa2D1, 20000000000000000000000);

		_add(0xA5F4DaC116c522839AD9A8df3D39a2a1cC278Bd1, 20000000000000000000000);

		_add(0x0c90718837CAfC06602223B4EA70AE8701064a0A, 20000000000000000000000);

		_add(0x405fdCE8c8A213CdBcb691e9F55031B94E9847ef, 20000000000000000000000);

		_add(0x2B5D6b9b94d3D38DAda1aF420bA4Bcc110926508, 20000000000000000000000);

		_add(0x68Ca25764b7dD0A2972e22428bf9573D6A6484CC, 20000000000000000000000);

		_add(0xbc4fb0b0f7DA2cc2520955389Bd0d75D5Cd91187, 36242800000000000000000);

		_add(0x34b257dEeBbF3F8bAD545F39690Ef79048DE2CCE, 19000000000000000000000);

		_add(0x3EaDB55cB2B7c30C6F966a33139b338a3affBdb0, 15000000000000000000000);

		_add(0x956eC544bF8f49dB58BD5B004a7ee7A1D9cF9ADA, 29302230000000000000000);

		_add(0x7D989c3a12539856922b2d7FAD4b11904c67d895, 13000000000000000000000);

		_add(0xFD8eED8c878403976466863F649b99B2BDDEFBB0, 10650000000000000000000);

		_add(0xf7a54f82021Ec3D9dCB397F06c2D145Bf0C21c7a, 10494000000000000000000);

		_add(0x8eCee8d6DcA1960B23f7e829c40dfe8BE8B5d312, 10000000000000000000000);

		_add(0x18009cA088f7874c76333759e1Fe62ec973255B2, 10000000000000000000000);

		_add(0xa44C2DfAf0fB434D3C630808d8D5661B0D1E0D96, 10000000000000000000000);

		_add(0xD77494d1326448ed1140913893e5AB1D381E1290, 10000000000000000000000);

		_add(0x43Ff9fb6f1e3cD7BC305B133116ab28523d974de, 10000000000000000000000);

		_add(0xb6317EDDA50F3dB0bf21aAa39D85E187Da863678, 10000000000000000000000);

		_add(0xCE30AaE0b0e82246888D622858840ba0ad852002, 10000000000000000000000);

		_add(0x1079778B3F805b8030f5b9fEDc52E92D65f70cE2, 10000000000000000000000);

		_add(0x112D083EBE9FFBde9e0CeBe5f4C3964F8E8533D7, 10000000000000000000000);

		_add(0xee8AD8b5205da48a4Df1094c0fCA21620aefcdf0, 10000000000000000000000);

		_add(0x9A156226266496CfB0e4b163ba604b4c153d65FC, 10000000000000000000000);

		_add(0xed84160d0b489f7610A91b8b99783c5D8efc2808, 10000000000000000000000);

		_add(0x4b1C6855475e65446e955612cA6167d9D9E843AB, 10000000000000000000000);

		_add(0x1Ce99932fD278E00911814dC4bd403e1293d8ED2, 6500000000000000000000);

		_add(0x91962711a4D2E4a830b366ce7276D99001e8564b, 13100000000000000000000);

		_add(0x970D64DC2d3c590cB3026C9FE2F190f45a0F71E2, 5454500000000000000000);

		_add(0x896D5BE2236655a190E7C34D14cA66B739597F49, 5400000000000000000000);

		_add(0xD78D056e631D880aBA379f5A9356F0428E3ad372, 5066000000000000000000);

		_add(0x971bf950d941eb44B361FA3374ed7a39D95d1aF5, 5050460000000000000000);

		_add(0x3b0535C602078a22A9954209B3556549C4E5E987, 5000000000000000000000);

		_add(0xb1d4792f43098535Da6B589AfDd762DF94490C66, 5000000000000000000000);

		_add(0xB02Ea47b681A36D902AB5dceEAe0F7270Bea24b9, 5000000000000000000000);

		_add(0x619f64c6c49E6787CA31C5a46c4d49C7Cb315FE5, 5000000000000000000000);

		_add(0x0D26C7241c3c0540184bEe1A5427947874c17B9a, 4190000000000000000000);

		_add(0xC2444C5323cE66519b381F6d67e0229546Fef528, 2642990000000000000000);

		_add(0xD1453C1310846EC5Ba080fCb1D3E128e9D124745, 2600000000000000000000);

		_add(0x974319c70257F3115EA76d58c57400eE7668e98E, 2437800000000000000000);

		_add(0x86cC04531f53b3f23c4bC67e05ca9C0c934Cf7ED, 2382020000000000000000);

		_add(0x4396bA5C3b8Db9D79192cc2A32655046714Cb76A, 2262800000000000000000);

		_add(0xE795601714fCf813eA1A9c738D7fFA468fc27254, 2000000000000000000000);

		_add(0x335AB32962bc005F1B8297CE9585FA1D696A2d35, 2000000000000000000000);

		_add(0xA5359C3480DE097197956232394CDbd13247e9AF, 1600000000000000000000);

		_add(0xD936db4AAc5d8DFc065B23a14f1C8575892aC9c3, 1200000000000000000000);

		_add(0x0e1C291d38d136e0261C8EE5D561d7AD078800F6, 1059600000000000000000);

		_add(0x8056F6F34B6264868fB7990DAfF6BEe68DAA7Ed2, 490000000000000000000);

		_add(0x6385A4547A0F795FdE91204186439e9689Ee0cDf, 463700000000000000000);

		_add(0xA7F7f806193AB04b6C1f5401125158048D0a7D49, 226100000000000000000);

		_add(0x9f6AC750a020D3141838CbF35b444fd5B732Ec7d, 200000000000000000000);

		_add(0xd9D3A9092a2eb5fa51DAC2C21b23FD9E5090d736, 148300000000000000000);

		_add(0xC5a700312a7A8e54e60c1aCc8999B8085d21e710, 15245980000000000000000);

	}



	function _add(address _buyer, uint256 _amount) internal {

		uint256 half = _amount / 2;

		buyers[_buyer].initialAmount = half;

		buyers[_buyer].lockedAmount = _amount - half;

	}



	// Addresses can only be removed before liquidityAdded = true

	function remove(address _buyer) external {

		require(msg.sender == owner && !liquidityAdded);

		buyers[_buyer].initialAmount = 0;

		buyers[_buyer].lockedAmount = 0;

	}



	function withdraw() external {

		require(liquidityAdded);

		

		uint256 initialAmount = buyers[msg.sender].initialAmount;

		if (initialAmount > 0) {

			buyers[msg.sender].initialAmount = 0;

			_safeTransfer(msg.sender, initialAmount);

		}



		if (block.timestamp >= lockStart + LOCK_PERIOD) {

			uint256 lockedAmount = buyers[msg.sender].lockedAmount;

			if (lockedAmount > 0) {

				buyers[msg.sender].lockedAmount = 0;

				_safeTransfer(msg.sender, lockedAmount);

			}

		}

	}



	function withdrawFor(address _address) external {

		require(liquidityAdded);

		

		uint256 initialAmount = buyers[_address].initialAmount;

		if (initialAmount > 0) {

			buyers[_address].initialAmount = 0;

			_safeTransfer(_address, initialAmount);

		}



		if (block.timestamp >= lockStart + LOCK_PERIOD) {

			uint256 lockedAmount = buyers[_address].lockedAmount;

			if (lockedAmount > 0) {

				buyers[_address].lockedAmount = 0;

				_safeTransfer(_address, lockedAmount);

			}

		}

	}



	// Sets liquidityAdded to true which allows presale buyers to withdraw. Can only be called once

	function setLiquidityAdded() external {

		require(msg.sender == owner && !liquidityAdded);

		liquidityAdded = true;

		lockStart = block.timestamp;

	}



	// The owner can withdraw the LMAO in the event of a problem as long as liquidityAdded is not true

	function ownerWithdraw() public {

		require(msg.sender == owner && !liquidityAdded);

		_safeTransfer(msg.sender, lmao.balanceOf(address(this)));

	}



	// Internal function to safely transfer LMAO in case there is a rounding error

	function _safeTransfer(address _to, uint256 _amount) internal {

		uint256 lmaoBalance = lmao.balanceOf(address(this));

		if (_amount > lmaoBalance) _amount = lmaoBalance;

		lmao.transfer(_to, _amount);

	}

}