// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract KingOfFools is Ownable,ReentrancyGuard{
    using SafeERC20 for IERC20;
    address constant USDC = 0xbf949EEF9DD057158e16A2e1225742c3243FC07b; //sample token contract deployed on goerli
    address public king = address(0);
    uint public deposits = 0;

        /**
     * @dev Require msg.value to be the 1.5x current value
     */
    modifier valueCheck(uint value) {
        if(deposits != 0){
            require(value >= ((deposits*15/10)) , "Value not >= 1.5x the current deposit");
        }
        _;
    }

    event kingUpdated(address newking);

    constructor() Ownable(){
    } 

            /**
     * @dev send funds to become new king of the fools
     * @param amount - amount that is sent
     * @param usdvalue - is the amount sent in udsc or eth
     */
    function becomeKing(uint amount,bool usdvalue) external payable valueCheck(amount) nonReentrant returns (bool){
        if(king != address(0)){
            if(usdvalue == true){
                IERC20(USDC).safeApprove(address(this),amount);
                IERC20(USDC).safeTransferFrom(msg.sender, king, amount);
            } 
            else{
                sendEtherTo(amount,payable(king));
            }
            
        }
        king = msg.sender;
        deposits = amount;
        emit kingUpdated(king);
        return true;
    }

        /**
     * @dev Sending funds using a call to avoid out of gas issue
     * @param reciever - gets paid
     * @param amount - The price of the sale
     */
    function sendEtherTo(uint256 amount,address payable reciever) internal{
        (bool success, ) = reciever.call{value:amount}("");
        require(success, "Transfer failed here.");
    }
}