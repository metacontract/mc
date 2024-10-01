# StdStyle
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/Flattened.sol)


## State Variables
### vm

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))));
```


### RED

```solidity
string constant RED = "\u001b[91m";
```


### GREEN

```solidity
string constant GREEN = "\u001b[92m";
```


### YELLOW

```solidity
string constant YELLOW = "\u001b[93m";
```


### BLUE

```solidity
string constant BLUE = "\u001b[94m";
```


### MAGENTA

```solidity
string constant MAGENTA = "\u001b[95m";
```


### CYAN

```solidity
string constant CYAN = "\u001b[96m";
```


### BOLD

```solidity
string constant BOLD = "\u001b[1m";
```


### DIM

```solidity
string constant DIM = "\u001b[2m";
```


### ITALIC

```solidity
string constant ITALIC = "\u001b[3m";
```


### UNDERLINE

```solidity
string constant UNDERLINE = "\u001b[4m";
```


### INVERSE

```solidity
string constant INVERSE = "\u001b[7m";
```


### RESET

```solidity
string constant RESET = "\u001b[0m";
```


## Functions
### styleConcat


```solidity
function styleConcat(string memory style, string memory self) private pure returns (string memory);
```

### red


```solidity
function red(string memory self) internal pure returns (string memory);
```

### red


```solidity
function red(uint256 self) internal pure returns (string memory);
```

### red


```solidity
function red(int256 self) internal pure returns (string memory);
```

### red


```solidity
function red(address self) internal pure returns (string memory);
```

### red


```solidity
function red(bool self) internal pure returns (string memory);
```

### redBytes


```solidity
function redBytes(bytes memory self) internal pure returns (string memory);
```

### redBytes32


```solidity
function redBytes32(bytes32 self) internal pure returns (string memory);
```

### green


```solidity
function green(string memory self) internal pure returns (string memory);
```

### green


```solidity
function green(uint256 self) internal pure returns (string memory);
```

### green


```solidity
function green(int256 self) internal pure returns (string memory);
```

### green


```solidity
function green(address self) internal pure returns (string memory);
```

### green


```solidity
function green(bool self) internal pure returns (string memory);
```

### greenBytes


```solidity
function greenBytes(bytes memory self) internal pure returns (string memory);
```

### greenBytes32


```solidity
function greenBytes32(bytes32 self) internal pure returns (string memory);
```

### yellow


```solidity
function yellow(string memory self) internal pure returns (string memory);
```

### yellow


```solidity
function yellow(uint256 self) internal pure returns (string memory);
```

### yellow


```solidity
function yellow(int256 self) internal pure returns (string memory);
```

### yellow


```solidity
function yellow(address self) internal pure returns (string memory);
```

### yellow


```solidity
function yellow(bool self) internal pure returns (string memory);
```

### yellowBytes


```solidity
function yellowBytes(bytes memory self) internal pure returns (string memory);
```

### yellowBytes32


```solidity
function yellowBytes32(bytes32 self) internal pure returns (string memory);
```

### blue


```solidity
function blue(string memory self) internal pure returns (string memory);
```

### blue


```solidity
function blue(uint256 self) internal pure returns (string memory);
```

### blue


```solidity
function blue(int256 self) internal pure returns (string memory);
```

### blue


```solidity
function blue(address self) internal pure returns (string memory);
```

### blue


```solidity
function blue(bool self) internal pure returns (string memory);
```

### blueBytes


```solidity
function blueBytes(bytes memory self) internal pure returns (string memory);
```

### blueBytes32


```solidity
function blueBytes32(bytes32 self) internal pure returns (string memory);
```

### magenta


```solidity
function magenta(string memory self) internal pure returns (string memory);
```

### magenta


```solidity
function magenta(uint256 self) internal pure returns (string memory);
```

### magenta


```solidity
function magenta(int256 self) internal pure returns (string memory);
```

### magenta


```solidity
function magenta(address self) internal pure returns (string memory);
```

### magenta


```solidity
function magenta(bool self) internal pure returns (string memory);
```

### magentaBytes


```solidity
function magentaBytes(bytes memory self) internal pure returns (string memory);
```

### magentaBytes32


```solidity
function magentaBytes32(bytes32 self) internal pure returns (string memory);
```

### cyan


```solidity
function cyan(string memory self) internal pure returns (string memory);
```

### cyan


```solidity
function cyan(uint256 self) internal pure returns (string memory);
```

### cyan


```solidity
function cyan(int256 self) internal pure returns (string memory);
```

### cyan


```solidity
function cyan(address self) internal pure returns (string memory);
```

### cyan


```solidity
function cyan(bool self) internal pure returns (string memory);
```

### cyanBytes


```solidity
function cyanBytes(bytes memory self) internal pure returns (string memory);
```

### cyanBytes32


```solidity
function cyanBytes32(bytes32 self) internal pure returns (string memory);
```

### bold


```solidity
function bold(string memory self) internal pure returns (string memory);
```

### bold


```solidity
function bold(uint256 self) internal pure returns (string memory);
```

### bold


```solidity
function bold(int256 self) internal pure returns (string memory);
```

### bold


```solidity
function bold(address self) internal pure returns (string memory);
```

### bold


```solidity
function bold(bool self) internal pure returns (string memory);
```

### boldBytes


```solidity
function boldBytes(bytes memory self) internal pure returns (string memory);
```

### boldBytes32


```solidity
function boldBytes32(bytes32 self) internal pure returns (string memory);
```

### dim


```solidity
function dim(string memory self) internal pure returns (string memory);
```

### dim


```solidity
function dim(uint256 self) internal pure returns (string memory);
```

### dim


```solidity
function dim(int256 self) internal pure returns (string memory);
```

### dim


```solidity
function dim(address self) internal pure returns (string memory);
```

### dim


```solidity
function dim(bool self) internal pure returns (string memory);
```

### dimBytes


```solidity
function dimBytes(bytes memory self) internal pure returns (string memory);
```

### dimBytes32


```solidity
function dimBytes32(bytes32 self) internal pure returns (string memory);
```

### italic


```solidity
function italic(string memory self) internal pure returns (string memory);
```

### italic


```solidity
function italic(uint256 self) internal pure returns (string memory);
```

### italic


```solidity
function italic(int256 self) internal pure returns (string memory);
```

### italic


```solidity
function italic(address self) internal pure returns (string memory);
```

### italic


```solidity
function italic(bool self) internal pure returns (string memory);
```

### italicBytes


```solidity
function italicBytes(bytes memory self) internal pure returns (string memory);
```

### italicBytes32


```solidity
function italicBytes32(bytes32 self) internal pure returns (string memory);
```

### underline


```solidity
function underline(string memory self) internal pure returns (string memory);
```

### underline


```solidity
function underline(uint256 self) internal pure returns (string memory);
```

### underline


```solidity
function underline(int256 self) internal pure returns (string memory);
```

### underline


```solidity
function underline(address self) internal pure returns (string memory);
```

### underline


```solidity
function underline(bool self) internal pure returns (string memory);
```

### underlineBytes


```solidity
function underlineBytes(bytes memory self) internal pure returns (string memory);
```

### underlineBytes32


```solidity
function underlineBytes32(bytes32 self) internal pure returns (string memory);
```

### inverse


```solidity
function inverse(string memory self) internal pure returns (string memory);
```

### inverse


```solidity
function inverse(uint256 self) internal pure returns (string memory);
```

### inverse


```solidity
function inverse(int256 self) internal pure returns (string memory);
```

### inverse


```solidity
function inverse(address self) internal pure returns (string memory);
```

### inverse


```solidity
function inverse(bool self) internal pure returns (string memory);
```

### inverseBytes


```solidity
function inverseBytes(bytes memory self) internal pure returns (string memory);
```

### inverseBytes32


```solidity
function inverseBytes32(bytes32 self) internal pure returns (string memory);
```

