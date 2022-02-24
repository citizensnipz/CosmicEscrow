const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("WizardEscrow", function () {
	it("Should be accessible", async function () {
		const WizardEscrow = await ethers.getContractFactory("WizardEscrow");
		const wizardEscrow = await WizardEscrow.deploy("0x5B38Da6a701c568545dCfcB03FcB875f56beddC4");
		await wizardEscrow.deployed();

		

		expect(await wizardEscrow.sayAgain("word")).to.equal("word");

	});

	it("Should return the name of the contract", async function () {
		const WizardEscrow = await ethers.getContractFactory("WizardEscrow");
		const wizardEscrow = await WizardEscrow.deploy("0x5B38Da6a701c568545dCfcB03FcB875f56beddC4");
		await wizardEscrow.deployed();

		

		expect(await wizardEscrow.name()).to.equal("WizardEscrow");

	});


});