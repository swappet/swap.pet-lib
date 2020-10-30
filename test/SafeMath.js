// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// test/SafeMath.js
const assert = require('assert');
const { contract  } = require('@openzeppelin/test-environment');

const { expect } = require('chai'); 

const {  BN,  expectRevert } = require('@openzeppelin/test-helpers'); 

const SafeMathMock = contract.fromArtifact("SafeMathMock"); 
 
const MaxUint256 = (new BN(2)).pow(new BN(256)).sub(new BN(1))
const a = new BN('18');
const b = new BN('58'); 
const a2 = new BN('324');   // a^2
const a25 = new BN('329'); // a^2+5
 
describe("SafeMath test", function () {     
    beforeEach(async function() {
        safeMathMock = await SafeMathMock.new();
    });
    it('max(a,b)', async function () {
        assert.equal(b.toString(), await safeMathMock.max(a,b));
    });
    it('max(b,a)', async function () {
        assert.equal(b.toString(), await safeMathMock.max(b,a));
    });
    it('min(a,b)', async function () {
        assert.equal(a.toString(), await safeMathMock.min(a,b));
    });
    it('min(b,a)', async function () {
        assert.equal(a.toString(), await safeMathMock.min(b,a));
    });
    it('twins(a,b)', async function () {
        twins = await safeMathMock.twins(a,b)
        assert.equal(a.toString(),twins[0] );
        assert.equal(b.toString(),twins[1] );
    });
    it('twins(b,a)', async function () {
        twins = await safeMathMock.twins(b,a)
        assert.equal(a.toString(),twins[0] );
        assert.equal(b.toString(),twins[1] );
    });
    it('avg(a,MaxUint256)', async function () {
        assert.equal((MaxUint256.add(a).div(new BN(2))).toString(), await safeMathMock.avg(a,MaxUint256));
    });
    it('add(a,b)', async function () {
        assert.equal(a.add(b).toString(), await safeMathMock.add(a,b));
    });
    it('add(a,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathMock.add(a,MaxUint256),
          'SafeMath: add overflow',
        );
    });
    it('sub(MaxUint256,a)', async function () {
        assert.equal(MaxUint256.sub(a).toString(), await safeMathMock.sub(MaxUint256,a));
    });
    it('sub(a,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathMock.sub(a,MaxUint256),
          'SafeMath: sub overflow',
        );
    });
    it('mul(a,b)', async function () {
        assert.equal(a.mul(b).toString(), await safeMathMock.mul(a,b));
    });
    it('mul(0,b)', async function () {
        assert.equal('0', await safeMathMock.mul(0,b));
    });
    it('mul(a,0)', async function () {
        assert.equal('0', await safeMathMock.mul(a,0));
    });
    it('mul(a,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathMock.mul(a,MaxUint256),
          'SafeMath: mul overflow',
        );
    });
    it('div(a,b)', async function () {
        assert.equal(a.div(b).toString(), await safeMathMock.div(a,b));
    });
    it('div(b,a)', async function () {
        assert.equal(b.div(a).toString(), await safeMathMock.div(b,a));
    });
    it('div(0,b)', async function () {
        assert.equal('0', await safeMathMock.div(0,b));
    });
    it('div(a,0)', async function () {
        await expectRevert(safeMathMock.div(a,0),
          'SafeMath: div by zero',
        );
    });
    it('mod(a,b)', async function () {
        assert.equal(a.mod(b).toString(), await safeMathMock.mod(a,b));
    });
    it('mod(b,a)', async function () {
        assert.equal(b.mod(a).toString(), await safeMathMock.mod(b,a));
    });
    it('mod(0,b)', async function () {
        assert.equal('0', await safeMathMock.mod(0,b));
    });
    it('mod(a,0)', async function () {
        await expectRevert(safeMathMock.mod(a,0),
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
    it('sqrt(a2)', async function () {
        assert.equal(a.toString(), await safeMathMock.sqrt(a2));
    });
    it('sqrt(a25)', async function () {
        assert.equal(a.toString(), await safeMathMock.sqrt(a25));
    });
});