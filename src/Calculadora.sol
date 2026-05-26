//Licencia
//SPDX-License-Identifier: MIT

//Version de solidity 
pragma solidity 0.8.35;

contract Calculadora {

//-----------------------variables-----------------------
uint256 public result;
address public owner;
//-----------------------constructor-----------------------
constructor(uint256 firstResult_, address owner_){
    result = firstResult_;
    owner = owner_;
}

//-----------------------modifiers-----------------------
    modifier onlyOwner(){
        require(msg.sender == owner, "Not allowed");
        _;
    }
    modifier notZero(uint256 number_){
        require(number_ != 0, "Number cannot be zero");
        _;
    }
    modifier notNegative(uint256 number_){
        require(number_ > 0, "Number cannot be negative");
        _;
    }
//-----------------------Events-----------------------
event addEvent(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
event subtractEvent(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
event multiplyEvent(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
event divideEvent(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
//-----------------------Functions-----------------------

     //External functions
     function add(uint256 firstNumber_, uint256 secondNumber_) notNegative(firstNumber_) notNegative(secondNumber_) external returns (uint256 result_) {
        result_ = firstNumber_ + secondNumber_;
        result = result_;
        emit addEvent(firstNumber_, secondNumber_, result_);
    }
    function subtract(uint256 firstNumber_, uint256 secondNumber_) notNegative(firstNumber_) notNegative(secondNumber_) external returns (uint256 result_) {
        result_ = firstNumber_ - secondNumber_;
        result = result_;
        emit subtractEvent(firstNumber_, secondNumber_, result_);
    }
    function multiply(uint256 firstNumber_, uint256 secondNumber_) notNegative(firstNumber_) notNegative(secondNumber_) external returns (uint256 result_) {
        result_ = firstNumber_ * secondNumber_;
        result = result_;
        emit multiplyEvent(firstNumber_, secondNumber_, result_);
    }
    function divide(uint256 firstNumber_, uint256 secondNumber_) onlyOwner() notZero(secondNumber_) notNegative(firstNumber_) notNegative(secondNumber_) external returns (uint256 result_) {
        result_ = firstNumber_ / secondNumber_;
        result = result_;
        emit divideEvent(firstNumber_, secondNumber_, result_);
    }
     //Internal functions
    
 }