//Licencia
//SPDX-License-Identifier: MIT

//Version de solidity 
pragma solidity 0.8.35;

import "../src/Calculadora.sol";
import "forge-std/Test.sol";


contract CalculadoraTest is Test { //"IS" es la palabra reservada para herencia de la libreria forge-std/Test.sol
    
    Calculadora calculadora; //"calculadora" es el nombre de la variable que se va a usar en el test. Es del tipo del smart contract Calculadora.
    uint256 public firstResult = 100;
    address public owner = vm.addr(1); //el comando genera una address aleatoria usando el numero 1 como seed.
    

    // Diferencia entre unit test y fuzz test:
    // Unit test: Testea una función específica.
    // Fuzz test: Testea una función con diferentes parámetros.

    
    function setUp() public { //Defino un setup. Es para preparar el mismo estado inicial para todos los tests.
        calculadora = new Calculadora(firstResult, owner); //crear una nueva instancia de la clase Calculadora. Crea un nuevo smart contract con los paràmetros preseteados.
    }
    // Unit test:
    function test_checkFirstResult() public view {
        uint256 firstResult_ = calculadora.result();
        assert(firstResult_ == firstResult);
    }
    function test_add() public { //"test_" es la palabra reservada para que el compilador reconozca que es un test.
        uint256 firstNumber_ = 10;
        uint256 secondNumber_ = 20;
        calculadora.add(firstNumber_, secondNumber_);
        assert(calculadora.result() == (firstNumber_ + secondNumber_));
    }
    function test_subtract() public { 
        uint256 firstNumber_ = 40;
        uint256 secondNumber_ = 20;
        calculadora.subtract(firstNumber_, secondNumber_);
        assert(calculadora.result() == (firstNumber_ - secondNumber_));
    }
    function test_multiply() public { 
        uint256 firstNumber = 10;
        uint256 secondNumber = 20;
        calculadora.multiply(firstNumber, secondNumber);
        assert(calculadora.result() == (firstNumber * secondNumber));
    }
    function test_divide() public { 
        uint256 firstNumber_ = 200;
        uint256 secondNumber_ = 20; 
        vm.prank(owner);
        calculadora.divide(firstNumber_, secondNumber_);
        assert(calculadora.result() == (firstNumber_ / secondNumber_));
    }

        // divide sin ser owner
    function test_revert_divide_notOwner() public {
        uint256 firstNumber_ = 100;
        uint256 secondNumber_ = 10;
        vm.expectRevert("Not allowed");
        calculadora.divide(firstNumber_, secondNumber_);
    }

    // divide con divisor 0
    function test_revert_divide_byZero() public {
        vm.prank(owner);  
        uint256 firstNumber_ = 100;
        uint256 secondNumber_ = 0;
        vm.expectRevert("Number cannot be zero");
        calculadora.divide(firstNumber_, secondNumber_);
    }

}