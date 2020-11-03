// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// test/buyUniswapBAT.test.js 
const { ethers } = require("ethers") 
const { expect } = require('chai');  
const { fromWei } = require("../scripts/utils")
require("dotenv").config() 

const { sdk } = require("swap.pet-sdk")  
const uniswap = require("swap.pet-sdk/uniswap")
const tokens = require("swap.pet-sdk/tokens")  
// console.log("tokens:", tokens)     

const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545") 
// const deployer = new ethers.Wallet(process.env.PRIV_KEY_DEPLOY, provider)
// const tester = new ethers.Wallet(process.env.PRIV_KEY_TEST5, provider) 

describe("test:buy Uniswap BAT with ETH", () => { 
  before(async function() {
    // get account
    const [deployer, tester] = await ethers.getSigners();
    // init Contract
    const wethContract = new ethers.Contract(
      sdk.tokens.weth.address,
      sdk.tokens.weth.abi,
      deployer
    )
    const batContract = new ethers.Contract(
      tokens.bat.address,
      tokens.bat.abi,
      deployer
    )  
    const uniswapFactoryContract = new ethers.Contract(
      uniswap.factory.address,
      uniswap.factory.abi,
      deployer
    ) 
  });
  it("deposit ETH to WETH ", async () => {
    await wethContract.connect(deployer).deposit({
      value: ethers.utils.parseEther("1.0"),
      gasLimit: 1000000, 
    })

    const wethBal = await wethContract.balanceOf(deployer.address)
    console.log(`deployer WETH Balance: ${ethers.utils.formatEther(wethBal)}`)
    expect(parseInt(wethBal)).to.above(0)   
  })

  it("initial BAT balance of 0", async () => {
    const batBalanceWei = await batContract.balanceOf(tester.address)
    const batBalance = fromWei(batBalanceWei, tokens.bat.decimals) 
    console.log(`batBalance: ${fromWei(batBalanceWei, tokens.bat.decimals)}`)
    expect(parseInt(batBalance)).to.equal(0) 
  })

  it("initial ETH balance of 100000 ETH", async () => {
    const ethBalanceWei = await tester.getBalance()
    const ethBalance = ethers.utils.formatEther(ethBalanceWei) 
    console.log(`ethBalance: ${ethers.utils.formatEther(ethBalanceWei)}`)
    expect(parseInt(ethBalance)).to.equal(100000)  
  })

  it("buy BAT from Uniswap", async () => { 
    const batExchangeAddress = await uniswapFactoryContract.getExchange(
      tokens.bat.address,
    )
    const batExchangeContract = new ethers.Contract(
      batExchangeAddress,
      uniswap.exchange.abi,
      deployer,
    )
    await batExchangeContract.connect(tester).ethToTokenSwapInput(
      1, // min amount of token retrieved
      2525800000, // random timestamp in the future 
      {
        gasLimit: 4000000,
        value: ethers.utils.parseEther("10"), 
      },
    ) 
 
    const newBatBalanceWei = await batContract.balanceOf(tester.address)
    const newBatBalance = parseFloat(fromWei(newBatBalanceWei, tokens.bat.decimals))
    console.log(`newBatBalance: ${fromWei(newBatBalanceWei, tokens.bat.decimals)}`)
    expect(newBatBalance).to.above(0)   
  })
}) 
