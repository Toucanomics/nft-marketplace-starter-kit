// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    function totalSupply() public view returns (uint256){
        return _allTokens.length;
    }
    
    uint256[] private _allTokens;
    
    mapping (uint256 => uint256) private _allTokensIndex;
    mapping (address => uint256[]) private _ownedTokens;
    mapping (uint256 => uint256) private _ownedTokensIndex;

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        _addTokensToAllTokensEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokens[to].push(tokenId);
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
    } 

    function tokenByIndex(uint256 index) public view returns(uint256) {
        require(index < totalSupply(), 'global index is out of bounds');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns(uint256) {
        require(index < balanceOf(owner), 'owner index is out of bounds');
        return _ownedTokens[owner][index];
    }

    function _addTokensToAllTokensEnumeration(uint256 tokenId) private {
         _allTokensIndex[tokenId] =  _allTokens.length;
        _allTokens.push(tokenId);
    }
}