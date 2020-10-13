# swap.pet-lib
Solidity libraries that are shared across swap.pet contracts


# usage

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

## init project with truffle and ganache-cli
```
$ npm i -g truffle
$ npm i -g ganache-cli
$ cd ~/lib
$ npx truffle init
// open new terminal
$ npx ganache-cli --deterministic
```

edit `truffle-config.js`:
```
module.exports = {
  networks: {
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 8545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
  }, 
  compilers: {
    solc: {
      // version: "0.5.1",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
         enabled: true,
         runs: 200
       },
       // evmVersion: "byzantium"  // default:istanbul
      }
    },
  },
};
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


# package with npm
update:`$ ./git.go.sh `
npm login:`$npm login` (new user:`$ npm adduser `, need active in email)
publish package:`$npm publish`
package major:`npm version major -m '[major]'`
package minor:`npm version minor -m '[minor]'`
package patch:`npm version patch -m '[patch]'`
install:`$ npm i git+https://github.com/swappet/swap.pet-lib.git`
