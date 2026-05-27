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
        calculadora.add(10, 20);
        assert(calculadora.result() == 30);
    }
    function test_subtract() public { 
        calculadora.subtract(40, 20);
        assert(calculadora.result() == 20);
    }
    function test_multiply() public { 
        calculadora.multiply(10, 20);
        assert(calculadora.result() == 200);
    }
    function test_divide() public {  
        vm.prank(owner);
        calculadora.divide(200, 20);
        assert(calculadora.result() == 10);
    }

        // divide sin ser owner
    function test_revert_divide_notOwner() public {
        vm.expectRevert("Not allowed");
        calculadora.divide(100, 10);
    }

    // divide con divisor 0
    function test_revert_divide_byZero() public {
        vm.prank(owner);    
        vm.expectRevert("Number cannot be zero");
        calculadora.divide(10, 0);
    }

}