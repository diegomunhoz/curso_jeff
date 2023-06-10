// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Aula02 {

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