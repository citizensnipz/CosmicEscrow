// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/escrow/Escrow.sol)

pragma solidity ^0.8.0;

import "./Ownable.sol";
import "./Address.sol";
import "./ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721.sol";


/**
 * @title Escrow
 * @dev Base escrow contract, holds funds designated for a payee until they
 * withdraw them.
 *
 * Intended usage: This contract (and derived escrow contracts) should be a
 * standalone contract, that only interacts with the contract that instantiated
 * it. That way, it is guaranteed that all Ether will be handled according to
 * the `Escrow` rules, and there is no need to check for payable functions or
 * transfers in the inheritance tree. The contract that uses the escrow as its
 * payment method should be its owner, and provide public methods redirecting
 * to the escrow's deposit and withdraw.
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
    }

    //returns false if the token is not a valid token
    function checkExistant(uint256 tokenId) internal view returns (bool) {
        return cosmic2D._exists(tokenId);
    }

    function checkBurned(uint256 tokenId) internal view returns (bool) {
        return _burned[tokenId];
    }

    function verifyOwnership(uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "NFT does not exist");
        require(cosmic2D.balanceOf(msg.sender) > 0, "User does not own any NFTs");
        require(cosmic2D.ownerOf(tokenId) == msg.sender, "User does not own this NFT");
        return true;
    }

    function depositsOf(address payee) public view returns (uint256) {
        //return _deposits[payee];
    }

    /**
     * @dev Stores the NFT.
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