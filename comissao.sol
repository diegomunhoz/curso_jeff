// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*
* Contrato: 0x6Fb00278D1db735f624D29EC84FB13bEC2ddB5b9
*/

contract Comissao {

    string public nomeVendedor;
    uint256 public fatorBonus;

    constructor(string memory vendedor, uint256 fator)  {
        nomeVendedor = vendedor;
        fatorBonus = fator;
    }

	function calculaComissao( uint256 valorVenda) 
    public
    view
    returns(uint256 comissao) {
        comissao = fatorBonus*valorVenda;
        return comissao;
    }

}