// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// test/SignedSafeMath.js
const assert = require('assert');
const { contract  } = require('@openzeppelin/test-environment');

const { expect } = require('chai'); 

const {  BN,  expectRevert } = require('@openzeppelin/test-helpers'); 

const SignedSafeMathMock = contract.fromArtifact("SignedSafeMathMock"); 
const SafeCastMock = contract.fromArtifact("SafeCastMock"); 
 
const MaxUint256 = (new BN(2)).pow(new BN(256)).sub(new BN(1))
const minA = new BN('18');
const maxB = new BN('-58'); 
const minA2 = new BN('324');   // minA^2
const minA25 = new BN('329'); // minA^2+5
 
describe("SignedSafeMath test", function () {     
    beforeEach(async function() {
        signedSafeMathMock = await SignedSafeMathMock.new();
    });
    it('max(minA,-maxB)', async function () {
        assert.equal(minA.toString(), await signedSafeMathMock.max(minA,maxB));
    });
    it('max(-maxB,minA)', async function () {
        assert.equal(minA.toString(), await signedSafeMathMock.max(maxB,minA));
    });
    it('min(minA,-maxB)', async function () {
        assert.equal(maxB.toString(), await signedSafeMathMock.min(minA,maxB));
    });
    it('min(-maxB,minA)', async function () {
        assert.equal(maxB.toString(), await signedSafeMathMock.min(maxB,minA));
    });
    it('twins(minA,-maxB)', async function () {
        twins = await signedSafeMathMock.twins(minA,maxB)
        assert.equal(maxB.toString(),twins[0] );
        assert.equal(minA.toString(),twins[1] );
    });
    it('twins(-maxB,minA)', async function () {
        twins = await signedSafeMathMock.twins(maxB,minA)
        assert.equal(maxB.toString(),twins[0] );
        assert.equal(minA.toString(),twins[1] );
    });
    it('avg(minA,-maxB) with two even numbers', async function () {
        assert.equal((minA.add(maxB).div(new BN(2))).toString(), await signedSafeMathMock.avg(minA,maxB));
    });
    it('avg(12345,-67890) with one even and one odd number', async function () {
        let oddA = new BN('12345');
        let evenB = new BN('-67890');
        assert.equal((oddA.add(evenB).divn(new BN(2))).toString(), await signedSafeMathMock.avg(evenB,oddA));
    });
    it('avg(12345,-56789) with two odd numbers', async function () {
        let oddA = new BN('12345');
        let oddB = new BN('-56789');
        assert.equal((oddA.add(oddB).divn(new BN(2))).toString(), await signedSafeMathMock.avg(oddB,oddA));
    });
    it('add(minA,-maxB)', async function () {
        assert.equal(minA.add(maxB).toString(), await signedSafeMathMock.add(minA,maxB));
    });
    it('sub(-maxB,minA)', async function () {
        assert.equal(maxB.sub(minA).toString(), await signedSafeMathMock.sub(maxB,minA));
    }); 
    it('mul(minA,-maxB)', async function () {
        assert.equal(minA.mul(maxB).toString(), await signedSafeMathMock.mul(minA,maxB));
    });
    it('mul(0,-maxB)', async function () {
        assert.equal('0', await signedSafeMathMock.mul(0,maxB));
    });
    it('mul(minA,0)', async function () {
        assert.equal('0', await signedSafeMathMock.mul(minA,0));
    }); 
    it('div(minA,-maxB)', async function () {
        assert.equal(minA.div(maxB).toString(), await signedSafeMathMock.div(minA,maxB));
    });
    it('div(-maxB,minA)', async function () {
        assert.equal(maxB.div(minA).toString(), await signedSafeMathMock.div(maxB,minA));
    });
    it('div(0,-maxB)', async function () {
        assert.equal('0', await signedSafeMathMock.div(0,maxB));
    });
    it('div(minA,0)', async function () {
        await expectRevert(signedSafeMathMock.div(minA,0),
          'SignedSafeMath: div by zero',
        );
    }); 
});
describe("SafeCast test", function () {     
    beforeEach(async function() {
        safeCastMock = await SafeCastMock.new();
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
    it('toInt128(-2**127)', async function () {
        let maxUint127 = (new BN(2)).pow(new BN(127)).mul(new BN(-1));
        assert.equal(maxUint127.toString(), await safeCastMock.toInt128(maxUint127));
    });
    it('toInt128(-2**127-1) overflow', async function () { 
        let overUint127 = (new BN(2)).pow(new BN(127)).mul(new BN(-1)).sub(new BN(1));
        await expectRevert(safeCastMock.toInt128(overUint127),
          'SafeCast: value overflow 128 bits',
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