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

describe("CosmicWizard", function () {
	it("Should be accessible", async function () {
		const CosmicWizard = await ethers.getContractFactory("ComicWizard");
		const cosmic = await CosmicWizard.deploy("Cosmic Wizards", "WIZARDS");
		await cosmic.deployed();

		expect(await cosmic.name()).to.equal("Cosmic Wizards");

	});

	it("Should mint an NFT to an address", async function () {
		const CosmicWizard = await ethers.getContractFactory("ComicWizard");
		const cosmic = await CosmicWizard.deploy("Cosmic Wizards", "WIZARDS");
		await cosmic.deployed();

		await cosmic.mintTokenId(1);

		const owner = await cosmic.owner();

		expect (await cosmic.ownerOf(1)).to.equal(owner);
	})

});