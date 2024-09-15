// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;


library DecodeErrorString {
    /**
     * @dev Decodes a revert reason from ABI-encoded data.
     * @param data ABI-encoded revert reason.
     * @return reason The decoded revert reason as a string.
     */
    function decodeRevertReason(bytes memory data) public pure returns (string memory) {
        // Ensure the data is at least 4 + 32 + 32 bytes (function selector + offset + string length)
        if (data.length == 0) {
            revert("reverted with no error message.");
        } else if (data.length < 68) {
            revert("Data too short for revert reason");
        }

        // Skip the first 4 bytes (error signature) and the next 32 bytes (offset),
        // then read the next 32 bytes to get the string length
        uint256 stringLength;
        assembly {
            stringLength := mload(add(data, 68))
        }

        // Extract the string itself
        bytes memory stringData = new bytes(stringLength);
        for (uint256 i = 0; i < stringLength; i++) {
            stringData[i] = data[i + 68];
        }

        return string(stringData);
    }

    /**
     * @dev Decodes a panic code from bytes.
     * @param data Bytes containing the panic code.
     * @return code The decoded panic code as a uint256.
     */
    function decodePanicCode(bytes memory data) internal pure returns (uint256 code) {
        if (data.length == 0) {
            revert("reverted with no error message.");
        } else if (data.length < 4) {
            revert("Data too short for panic code");
        }
        // Panic codes are 4 bytes long, following the function selector
        assembly {
            code := mload(add(data, 0x24))
        }
    }

    /**
     * @dev Attempts to decode both revert reasons and panic codes.
     * @param data Bytes containing either a revert reason or a panic code.
     * @return result The decoded message as a string.
     */
    function decodeRevertReasonAndPanicCode(bytes memory data) internal pure returns (string memory result) {
        // Check if the data length corresponds to a panic code (4 bytes for the selector + 32 bytes for the uint256)
        if (data.length == 36) {
            uint256 panicCode = decodePanicCode(data);
            result = panicCodeToString(panicCode);
        } else {
            // Assume it's a revert reason for any other length
            result = decodeRevertReason(data);
        }
    }

    /**
     * @dev Converts a panic code to a human-readable string. (These messages are not accurate and also need to be chase upstream implementation.)
     * @param code The panic code as a uint256.
     * @return reason The corresponding human-readable string.
     */
    function panicCodeToString(uint256 code) private pure returns (string memory reason) {
        if (code == 0x01) {
            return "panic: Division by zero.";
        } else if (code == 0x11) {
            return "panic: Arithmetic operation underflow.";
        } else if (code == 0x12) {
            return "panic: Arithmetic operation overflow.";
        } else if (code == 0x21) {
            return "panic: Pop from an empty array.";
        } else if (code == 0x22) {
            return "panic: Array or memory access out of bounds.";
        } else if (code == 0x31) {
            return "panic: Allocation of too much memory.";
        } else if (code == 0x32) {
            return "panic: array out-of-bounds access (0x32)";
        } else if (code == 0x41) {
            return "panic: Zero-initialized variable of internal function type.";
        } else {
            return "Unknown panic code.";
        }
    }
}
