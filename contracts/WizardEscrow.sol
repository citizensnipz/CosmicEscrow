// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/escrow/Escrow.sol)

pragma solidity ^0.8.0;

import "./Ownable.sol";
import "./Address.sol";
import "./ERC721.sol";
import "./IERC721.sol";

import "hardhat/console.sol";

/**
 * @title Escrow
 * @dev Base escrow contract, holds funds designated for a payee until they
 * withdraw them.
 *
 */

abstract contract CosmicWizard is IERC721 {
    function _exists(uint256) external virtual view returns (bool);

}

contract WizardEscrow is ERC721, Ownable {
    using Address for address payable;

    event Deposited(address indexed payee, uint256 tokenId);
    event Withdrawn(address indexed payee, uint256 tokenId);

    mapping(address => uint256[]) private _deposits;
    mapping(uint256 => bool) private _burned;

    CosmicWizard cosmic2D;



    constructor(address _contract) ERC721("WizardEscrow", "WIZESC") {
        cosmic2D = CosmicWizard(_contract);
        console.log("Constructed the wiz escrow");
    }

    //returns false if the token is not a valid token
    function checkExistant(uint256 tokenId) internal view returns (bool) {
        return cosmic2D._exists(tokenId);
    }

    function checkBurned(uint256 tokenId) internal view returns (bool) {
        return _burned[tokenId];
    }

    function sayAgain(string memory word) public view returns (string memory) {
        return word;
    }


    //checks that user owns the NFT submitted
    function verifyOwnership(uint256 tokenId) internal view returns (bool) {
        require(cosmic2D.balanceOf(msg.sender) > 0, "User does not own any NFTs");
        require(cosmic2D.ownerOf(tokenId) == msg.sender, "User does not own this NFT");
        return true;
    }

    function depositsOf(address payee) public view returns (uint256) {
        //return _deposits[payee];
    }

    /**
     * @dev Stores the NFT.
     * This is where the magic happens
     * Runs checks to make sure the transaction is valid before burning the NFT
     * Adds the user to a list of people authorized to receive a new NFT
     * @param payee The destination address of the funds.
     */
    function deposit(address payee, uint256 tokenId) public payable virtual onlyOwner {
        
        _deposits[payee].push(tokenId);
        emit Deposited(payee, tokenId);
    }

    /**
     * @dev Withdraw accumulated balance for a payee, forwarding all gas to the
     * recipient.
     *
     * WARNING: Forwarding all gas opens the door to reentrancy vulnerabilities.
     * Make sure you trust the recipient, or are either following the
     * checks-effects-interactions pattern or using {ReentrancyGuard}.
     *
     * @param payee The address whose funds will be withdrawn and transferred to.
     */
    function withdraw(address payable payee) public virtual onlyOwner {
        //uint256 payment = _deposits[payee];

        //_deposits[payee] = 0;

        //payee.sendValue(payment);

        //emit Withdrawn(payee, payment);
    }
}