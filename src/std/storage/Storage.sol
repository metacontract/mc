// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Schema} from "./Schema.sol";

/**
 * Storage Library v0.1.0
 */
library Storage {
    function Admin() internal pure returns (Schema.$Admin storage ref) {
        assembly { ref.slot := 0xc87a8b268af18cef58a28e8269c607186ac6d26eb9fb11e976ba7fc83fbc5b00 }
    }

    function Clones() internal pure returns (Schema.$Clone storage ref) {
        assembly { ref.slot := 0x10c209d5b202f0d4610807a7049eb641dc6976ce93261be6493809881acea600 }
    }

    function Proposal() internal pure returns (Schema.$Proposal storage ref) {
        assembly { ref.slot := 0x45b916c98aa7f2144e93d3db7f57085183272dde7ad2a807f6e0da02b595f700 }
    }

    function Member() internal pure returns (Schema.$Member storage ref) {
        assembly { ref.slot := 0xb02ea24c1f86ea07e6c09d7d408e6de4225369a86f387a049c2d2fcaeb5d4c00 }
    }

    function FeatureToggle() internal pure returns (Schema.$FeatureToggle storage ref) {
        assembly { ref.slot := 0xfbe5942bf8b77a2e1fdda5ac4fad2514a8894a997001808038d8cb6785c1d500 }
    }

    function Initialization() internal pure returns (Schema.$Initialization storage ref) {
        assembly { ref.slot := 0x3a761698c158d659b37261358fd236b3bd53eb7608e16317044a5253fc82ad00 }
    }

}
