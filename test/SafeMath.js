// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// test/SafeMath.js
const assert = require('assert');
const { contract  } = require('@openzeppelin/test-environment');

const { expect } = require('chai'); 

const {  BN,  expectRevert } = require('@openzeppelin/test-helpers'); 

const SafeMathMock = contract.fromArtifact("SafeMathMock"); 
const SafeCastMock = contract.fromArtifact("SafeCastMock"); 
 
const MaxUint256 = (new BN(2)).pow(new BN(256)).sub(new BN(1))
const minA = new BN('18');
const maxB = new BN('58'); 
const minA2 = new BN('324');   // minA^2
const minA25 = new BN('329'); // minA^2+5
 
describe("SafeMath test", function () {     
    beforeEach(async function() {
        safeMathMock = await SafeMathMock.new();
    });
    it('max(minA,maxB)', async function () {
        assert.equal(maxB.toString(), await safeMathMock.max(minA,maxB));
    });
    it('max(maxB,minA)', async function () {
        assert.equal(maxB.toString(), await safeMathMock.max(maxB,minA));
    });
    it('min(minA,maxB)', async function () {
        assert.equal(minA.toString(), await safeMathMock.min(minA,maxB));
    });
    it('min(maxB,minA)', async function () {
        assert.equal(minA.toString(), await safeMathMock.min(maxB,minA));
    });
    it('twins(minA,maxB)', async function () {
        twins = await safeMathMock.twins(minA,maxB)
        assert.equal(minA.toString(),twins[0] );
        assert.equal(maxB.toString(),twins[1] );
    });
    it('twins(maxB,minA)', async function () {
        twins = await safeMathMock.twins(maxB,minA)
        assert.equal(minA.toString(),twins[0] );
        assert.equal(maxB.toString(),twins[1] );
    });
    it('avg(minA,MaxUint256) with two even numbers', async function () {
        assert.equal((MaxUint256.add(minA).div(new BN(2))).toString(), await safeMathMock.avg(minA,MaxUint256));
    });
    it('avg(12345,67890) with one even and one odd number', async function () {
        let oddA = new BN('12345');
        let evenB = new BN('67890');
        assert.equal((oddA.add(evenB).divn(new BN(2))).toString(), await safeMathMock.avg(evenB,oddA));
    });
    it('avg(12345,56789) with two odd numbers', async function () {
        let oddA = new BN('12345');
        let oddB = new BN('56789');
        assert.equal((oddA.add(oddB).divn(new BN(2))).toString(), await safeMathMock.avg(oddB,oddA));
    });
    it('add(minA,maxB)', async function () {
        assert.equal(minA.add(maxB).toString(), await safeMathMock.add(minA,maxB));
    });
    it('add(minA,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathMock.add(minA,MaxUint256),
          'SafeMath: add overflow',
        );
    });
    it('sub(MaxUint256,minA)', async function () {
        assert.equal(MaxUint256.sub(minA).toString(), await safeMathMock.sub(MaxUint256,minA));
    });
    it('sub(minA,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathMock.sub(minA,MaxUint256),
          'SafeMath: sub overflow',
        );
    });
    it('mul(minA,maxB)', async function () {
        assert.equal(minA.mul(maxB).toString(), await safeMathMock.mul(minA,maxB));
    });
    it('mul(0,maxB)', async function () {
        assert.equal('0', await safeMathMock.mul(0,maxB));
    });
    it('mul(minA,0)', async function () {
        assert.equal('0', await safeMathMock.mul(minA,0));
    });
    it('mul(minA,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathMock.mul(minA,MaxUint256),
          'SafeMath: mul overflow',
        );
    });
    it('div(minA,maxB)', async function () {
        assert.equal(minA.div(maxB).toString(), await safeMathMock.div(minA,maxB));
    });
    it('div(maxB,minA)', async function () {
        assert.equal(maxB.div(minA).toString(), await safeMathMock.div(maxB,minA));
    });
    it('div(0,maxB)', async function () {
        assert.equal('0', await safeMathMock.div(0,maxB));
    });
    it('div(minA,0)', async function () {
        await expectRevert(safeMathMock.div(minA,0),
          'SafeMath: div by zero',
        );
    });
    it('mod(minA,maxB)', async function () {
        assert.equal(minA.mod(maxB).toString(), await safeMathMock.mod(minA,maxB));
    });
    it('mod(maxB,minA)', async function () {
        assert.equal(maxB.mod(minA).toString(), await safeMathMock.mod(maxB,minA));
    });
    it('mod(0,maxB)', async function () {
        assert.equal('0', await safeMathMock.mod(0,maxB));
    });
    it('mod(minA,0)', async function () {
        await expectRevert(safeMathMock.mod(minA,0),
          'SafeMath: mod by zero',
        );
    });
    it('sqrt(0)', async function () {
        assert.equal('0', await safeMathMock.sqrt(0));
    });
    it('sqrt(1)', async function () {
        assert.equal('1', await safeMathMock.sqrt(1));
    });
    it('sqrt(2)', async function () {
        assert.equal('1', await safeMathMock.sqrt(2));
    });
    it('sqrt(3)', async function () {
        assert.equal('1', await safeMathMock.sqrt(3));
    });
    it('sqrt(4)', async function () {
        assert.equal('2', await safeMathMock.sqrt(4));
    });
    it('sqrt(minA2)', async function () {
        assert.equal(minA.toString(), await safeMathMock.sqrt(minA2));
    });
    it('sqrt(minA25)', async function () {
        assert.equal(minA.toString(), await safeMathMock.sqrt(minA25));
    }); 
});
describe("SafeCast test", function () {     
    beforeEach(async function() {
        safeCastMock = await SafeCastMock.new();
    }); 
    it('toInt256(2**255-1)', async function () {
        let maxUint255 = (new BN(2)).pow(new BN(255)).sub(new BN(1));
        assert.equal(maxUint255.toString(), await safeCastMock.toInt256(maxUint255));
    });
    it('toInt256(2**255) overflow', async function () { 
        let overUint255 = (new BN(2)).pow(new BN(255));
        await expectRevert(safeCastMock.toInt256(overUint255),
          'SafeCast: value overflow int256',
        );
    });   
    it('toInt128(2**127-1)', async function () {
        let maxUint127 = (new BN(2)).pow(new BN(127)).sub(new BN(1));
        assert.equal(maxUint127.toString(), await safeCastMock.toInt128(maxUint127));
    });
    it('toInt128(2**127) overflow', async function () { 
        let overUint127 = (new BN(2)).pow(new BN(127));
        await expectRevert(safeCastMock.toInt128(overUint127),
          'SafeCast: value overflow 128 bits',
        );
    }); 
    it('toInt128(-2**127+1)', async function () {
        let maxUint127 = (new BN(2)).pow(new BN(127)).mul(new BN(-1)).add(new BN(1));
        assert.equal(maxUint127.toString(), await safeCastMock.toInt128(maxUint127));
    });
    it('toInt128(-2**127) overflow', async function () { 
        let overUint127 = (new BN(2)).pow(new BN(127)).mul(new BN(-1));
        await expectRevert(safeCastMock.toInt128(overUint127),
          'SafeCast: value overflow 128 bits',
        );
    }); 
    it('toUint256(2**255-1)', async function () {
        let maxUint255 = (new BN(2)).pow(new BN(255)).sub(new BN(1));
        assert.equal(maxUint255.toString(), await safeCastMock.toUint256(maxUint255));
    });
    it('toUint256(-1) overflow', async function () { 
        let overUint255 = new BN(-1);
        await expectRevert(safeCastMock.toUint256(overUint255),
          'SafeCast: value must be positive',
        );
    }); 
    it('toUint128(2**128-1)', async function () {
        let maxUint128 = (new BN(2)).pow(new BN(128)).sub(new BN(1));
        assert.equal(maxUint128.toString(), await safeCastMock.toUint128(maxUint128));
    });
    it('toUint128(2**128) overflow', async function () { 
        let overUint128 = (new BN(2)).pow(new BN(128));
        await expectRevert(safeCastMock.toUint128(overUint128),
          'SafeCast: value overflow 128 bits',
        );
    });   
});