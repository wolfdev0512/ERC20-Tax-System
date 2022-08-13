// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Tax is ERC20, Ownable {
    using SafeMath for uint256;

    address stakingAddress;
    address devAddress;
    address marketingAddress;
    uint burnFee = 2;
    uint stakingFee = 2;
    uint devFee = 3;
    uint marketingFee = 3;


    constructor(string memory tokenName, string memory tokenSymbol, address _stakingAddress, address _devAddress, address _marketingAddress) ERC20(tokenName, tokenSymbol) {
        stakingAddress = _stakingAddress;
        devAddress = _devAddress;
        marketingAddress = _marketingAddress;
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        uint realFee = 100 - burnFee - stakingFee - devFee - marketingFee;
        _burn(owner, amount.mul(burnFee).div(100));
        _transfer(owner, stakingAddress, amount.mul(stakingFee).div(100));
        _transfer(owner, devAddress, amount.mul(devFee).div(100));
        _transfer(owner, marketingAddress, amount.mul(marketingFee).div(100));
        _transfer(owner, to, amount.mul(realFee).div(100));
        return true;
    }
    
    function mint(uint amount) public onlyOwner {
        require(amount > 0, "Can't mint the token");
        address owner = owner();
        _mint(owner, amount);
    }

    function setStakingAddress(address _stakingAddress) public onlyOwner {
        stakingAddress = _stakingAddress;
    }

    function setDevAddress(address _devAddress) public onlyOwner {
        stakingAddress = _devAddress;
    }

    function setMarketingAddress(address _marketingAddress) public onlyOwner {
        stakingAddress = _marketingAddress;
    }

    function setBurnFee(uint _burnFee) public onlyOwner {
        burnFee = _burnFee;
    }

    function setStakingFee(uint _stakingFee) public onlyOwner {
        stakingFee = _stakingFee;
    }

    function setDevFee(uint _devFee) public onlyOwner {
        devFee = _devFee;
    }

    function setMarketingFee(uint _marketingFee) public onlyOwner {
        marketingFee = _marketingFee;
    }

}