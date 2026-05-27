//Licencia
//SPDX-License-Identifier: MIT

//Version de solidity 
pragma solidity 0.8.35;

import "../src/Calculadora.sol";
import "forge-std/Test.sol";


contract CalculadoraTest is Test { //"IS" es la palabra reservada para herencia de la libreria forge-std/Test.sol
    
    Calculadora calculadora; //"calculadora" es el nombre de la variable que se va a usar en el test. Es del tipo del smart contract Calculadora.
    uint256 public result = 100;
    address public owner = vm.addr(1); //el comando genera una address aleatoria usando el numero 1 como seed.
    
    function setUp() public { //Defino un setup. Es para preparar el mismo estado inicial para todos los tests.
        calculadora = new Calculadora(result, owner); //crear una nueva instancia de la clase Calculadora. Crea un nuevo smart contract con los paràmetros preseteados.
    }
    function test_add() public { //"test_" es la palabra reservada para definir un test
        calculadora.add(10, 20);
        assertEq(calculadora.result(), 30);
    }
    function test_subtract() public { 
        calculadora.subtract(10, 20);
        assertEq(calculadora.result(), -10);
    }
    function test_multiply() public { 
        calculadora.multiply(10, 20);
        assertEq(calculadora.result(), 200);
    }
    function test_divide() public {  
        calculadora.divide(10, 20);
        assertEq(calculadora.result(), 0.5);
    }
}