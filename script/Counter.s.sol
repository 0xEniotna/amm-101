// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {DummyToken} from "../contracts/DummyToken.sol";
import {ERC20TD} from "../contracts/ERC20TD.sol";
import {Evaluator} from "../contracts/Evaluator.sol";
import "../contracts/utils/IUniswapV2Factory.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // vm.startBroadcast(vm.envUint("anvil"));

        ERC20TD erc20 = new ERC20TD("TD-ERC20-101", "TD-ERC20-101", 0);
        DummyToken dummytoken = new DummyToken("dummyToken", "DTK",2000000000000 ether);
        address _weth = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;
        address _factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
        Evaluator evaluator = new Evaluator(erc20, dummytoken, IUniswapV2Factory(_factory), _weth);

        erc20.setTeacher(address(evaluator), true);

        vm.stopBroadcast();
    }
}
