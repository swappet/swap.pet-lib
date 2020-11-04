# swap.pet-lib
Solidity libraries that are shared across swap.pet contracts

# Summary

# Design Goals
Solidity libraries that are shared across Swap.Pet contracts. These libraries are focused on safety and gas efficiency.

# usage

# Install
Run `yarn` or `npx npm i` to install dependencies.

# Test
Run `npx npm test` test to execute the test suite.

# Usage
Install this in another project:  
`$ yarn add swap.pet-lib`  
or:`$ npx npm i swap.pet-lib`  

Then import the contracts via:  
`import 'swap.pet-lib/contracts/lib/ERC20.sol';`

# dir
abi:ABI of defi.  
defi:online contract of defi with ABI/address.  
dapps:logo of Defi App.  
contracts:sol file.  
tokens:online token info of Defi with ABI/address/symbol/decimals/logo.
interfaces: contract interfaces of Defi.  

# Quickstart

## Install

```bash
npm install swap.pet-lib
```
## Solidity Usage

```js
pragma solidity ^0.7.0;

import "swap.pet-lib/interfaces/onesplit/IOneSplit.sol";
import "swap.pet-lib/interfaces/erc/IERC20.sol"; 

contract OneSplitSwapper {
    // Uniswap Mainnet factory address
    address constant OneSplitAddress = 0xC586BeF4a0992C495Cf22e1aeEE4E446CECDee0E;

    function _swap(address from, address to, uint256 amountWei) internal {
        IERC20 fromIERC20 = IERC20(from);
        IERC20 toIERC20 = IERC20(to);

        (uint256 returnAmount, uint256[] memory distribution) = IOneSplit(
            OneSplitAddress
        ).getExpectedReturn(
            fromIERC20,
            toIERC20,
            amountWei,
            10,
            0
        );

        IOneSplit(OneSplitAddress).swap(
            fromIERC20,
            toIERC20,
            amountWei,
            returnAmount,
            distribution,
            0
        );
    }
}
```

# create
## install LTS Node with nvm
```
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
$ source ~/.bash_profile
$ command -v nvm 
$ nvm -v                
0.36.0
$ nvm ls-remote 
<!-- $ nvm install node # "node" is an alias for the latest version(--lts) -->
$ nvm install --lts
$ node --version
v12.18.4
$ npm -v
6.14.6
$ npx -v
6.14.6
$ nvm reinstall-packages
$ mkdir ~/lib
$ cd ~/lib
$ npx npm init
$ npx npm install
```

 
# Installation Instructions  
in app dir:`$ npx npm i swap.pet-lib`  
  
in sol file:  
```
import "swap.pet-lib/contracts/SafeMath.sol";
import "swap.pet-lib/interfaces/swappet/ISwapPetOracle.sol";
```

in js file:
```
const { abi } = require("swap.pet-lib/abi") 
const { defi } = require("swap.pet-lib/defi") 
const { interfaces } = require("swap.pet-lib/interfaces")
const { tokens } = require("swap.pet-lib/tokens") 
```

# sol debug
in sol file:  
`import "hardhat/console.sol";`
# create workflow  
``` 
$ npm i -g truffle
$ npm i -g ganache-cli 
$ mkdir ~/lib   
$ cd ~/lib
$ npm init  
$ npx truffle init
// open new terminal
$ npx ganache-cli --deterministic
$ npm install --save-dev hardhat  
$ npm install --save-dev @nomiclabs/hardhat-truffle5 @nomiclabs/hardhat-web3 web3  
```

edit `.gitignore`:
```
# truffle 
.secret
```

edit `.secret`:
```
$ cp .secret.sample .secret
$ vi .secret
```

edit config:`$ vi hardhat.config.js`    
  
add gas-reporter:`$ npx npm install -D eth-gas-reporter`  
get gas report:`$ npx truffle test`  
add coverage:`$ npx npm install -D @nomiclabs/buidler solidity-coverage`  
get coverage:`$ npx truffle run coverage`  
run ganache :`$ npx ganache-cli --deterministic`  
compile:`$ npx hardhat compile`  
test:`$ npx hardhat test`  
accounts:`$ npx hardhat accounts`  
account balance:`$ npx hardhat balance --account 0xFABB0ac...`
 
## init project with openzeppelin CLI
```
<!-- $ npm install --save-dev @openzeppelin/cli -->
$ npm install -g @openzeppelin/cli
$ npx openzeppelin --version
2.8.2
OR 
$ npx oz --version 
$ npx oz accounts
$ npx oz balance
$ npx oz init
$ npx npm install @openzeppelin/contracts
```

edit `.gitignore`:
```
# openzeppelin
.openzeppelin/.session
.openzeppelin/dev-*.json
.openzeppelin/unknown-*.json
build/
```

## Automated Smart Contract Tests
edit sol file in dir of `contracts`

add test file `test/SafeNamer.js` 

add test tool:
```
$ npm i --save-dev @openzeppelin/test-helpers @openzeppelin/test-environment mocha chai 
$ npm i @truffle/debug-utils 
```

edit 'package.json':
```
"scripts": {
  "test": "oz compile && mocha --exit --recursive"
}
```

run oz test:
```
$ npm test
or
$ npm run test
<!-- cause Mocha to stop immediately on the first failing test -->
$ npm test -- --bail
```
 
