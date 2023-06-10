// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*
*Contrato - 0xb21EB87Bc14a97D0e302c576DcDf20c4a02cD304
*/

contract Aluguel {

    string public nomeLocador;
    string public nomeLocatario;
    uint256[36] public valorAluguel;

    constructor(string memory locador, string memory locatario, uint aluguel)  {
        nomeLocador = locador;
        nomeLocatario = locatario;
        for (uint256 i = 0; i < 36; i++) {
            valorAluguel[i] = aluguel;
        }
    }

    function buscaValorAluguel(uint mes) public view returns (uint) {
        return valorAluguel[mes-1];
    }

    function buscaLocadorLocatario() public view returns (string memory, string memory) {
        return (getLocatario(), getLocador());
    }

    function getLocador() public view returns (string memory) {
        return string.concat("Locador :", nomeLocador);
    }

    function getLocatario() public view returns (string memory) {
        return string.concat("Locatario :", nomeLocatario);
    }

    function alterarNome(uint tipoPessoa, string memory novoNome) public {
        if (tipoPessoa == 1) {
            nomeLocador = novoNome;
        } else if (tipoPessoa == 2) {
            nomeLocatario = novoNome;
        } else {
            revert("Tipo de pessoa invalido");
        }
    }

    function aplicaAjusteAluguel(uint256 mesInicial, uint256 valor) public {
        if (mesInicial > 36) {
            revert("Mes invalido");
        }
        uint256 ind = mesInicial - 1;
        for (uint i = mesInicial; i < ind; i++) {
            valorAluguel[i] += valor;
        }
    }

}