// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {PausableUpgradeable} from "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import {ReentrancyGuardUpgradeable} from "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import {SafeMathUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
//import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";


contract StakingV2 is Initializable,OwnableUpgradeable,PausableUpgradeable,ReentrancyGuardUpgradeable{
    using SafeMathUpgradeable for uint256;
    using SafeERC20 for IERC20;

    uint256 public minStakeAmount ;
    uint256 public maxStakeAmount ;

    struct User {
        uint256 amount;
        uint256 deadline;
    }

    

    mapping(address => mapping(uint256 => User)) public userMonthToAmount;
    mapping(uint256 => uint256) public monthToInterestRate;

    IERC20 public token;

    function initialize() public initializer {
        __Ownable_init();
        monthToInterestRate[3] = 22;
        monthToInterestRate[6] = 45;
        monthToInterestRate[12] = 100;
        minStakeAmount = 20 * 10**14;
        maxStakeAmount = 200 * 10**14;

    }

    function setAddress(address _address) external onlyOwner {
        token = IERC20(_address);
    }

    function stake(uint256 _amount, uint256 _month)
        external
        whenNotPaused
        nonReentrant
    {
        require(_amount >= minStakeAmount, "add more amount");
        require(_amount <= maxStakeAmount, "add less amount");
        uint256 interestRate = monthToInterestRate[_month];
        require(interestRate > 0, "invalid month");

        User storage user = userMonthToAmount[msg.sender][_month];
        require(user.amount == 0, "already staked");

        user.amount = _amount;
        user.deadline = block.timestamp.add(_month * 60); /* CHANGE THE TIME BEFORE DEPLOY */

        token.safeTransferFrom(msg.sender, address(this), _amount);
    }

    function unstake(uint256 _month) external nonReentrant {
        User storage user = userMonthToAmount[msg.sender][_month];
        uint256 amount = user.amount;
        require(amount > 0, "no unstake data found");
        require(block.timestamp > user.deadline, "period is not expired");
        uint256 interestRate = monthToInterestRate[_month];
        uint256 reward = calculateReward(amount, interestRate, _month);

        token.safeTransfer(msg.sender, amount.add(reward));
        delete userMonthToAmount[msg.sender][_month];
    }

    function calculateReward(
        uint256 _amount,
        uint256 _interestRate,
        uint256 _month
    ) public pure returns (uint256) {
        uint256 reward = _amount.mul(_interestRate).mul(_month).div(1000 * 12);
        return reward;
    }

    function updateMinAmount(uint256 _minAmount) external onlyOwner {
        minStakeAmount = _minAmount;
    }

    function updateMaxAmount(uint256 _maxAmount) external onlyOwner {
        maxStakeAmount = _maxAmount;
    }

    function withdraw(uint256 _amount) external onlyOwner {
        uint256 contractBalance = token.balanceOf(address(this));
        require(
            contractBalance >= _amount,
            "Contract does not have enough balance to withdraw"
        );
        token.safeTransfer(msg.sender, _amount);
    }

    function setMonthInterestRate(uint256 _month, uint256 _interestRate)
        external
        onlyOwner
    {
        monthToInterestRate[_month] = _interestRate;
    }
    
        function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner{
        _unpause();
    }
}
