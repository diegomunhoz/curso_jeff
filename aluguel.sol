// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*
*Contrato - 0xb21EB87Bc14a97D0e302c576DcDf20c4a02cD304
*/

contract Aluguel {

    // Nome do locador
    string public nomeLocador;

    // Nome do locatario
    string public nomeLocatario;

    // Array dos valores do aluguel
    uint[] public valorAluguel;

    // Construtor padrão
    constructor(string memory locador, string memory locatario, uint aluguel)  {

        // Atribuição do nome do locador
        nomeLocador = locador;

        // Atribuição do nome do locatario
        nomeLocatario = locatario;

        // Laço para valorização
        for (uint i = 0; i < 36; i++) {
            valorAluguel[i] = aluguel;
        }

    }

    // Função para buscar o valor do aluguel em um mês específico
    function buscaValorAluguel(uint mes) public view returns (uint) {
        return valorAluguel[mes-1];
    }

    // Função para buscar o locador e locatário
    function buscaLocadorLocatario() public view returns (string memory, string memory) {
        return (getLocatario(), getLocador());
    }

    // Função get que retorna o locador com texto concatenado
    function getLocador() public view returns (string memory) {
        return string.concat("Locador: ", nomeLocador);
    }

    // Método get que retorna o locatário com texto concatenado
    function getLocatario() public view returns (string memory) {
        return string.concat("Locatario: ", nomeLocatario);
    }

    // Função para alterar o nome com base no tipo de pessoa recebido (1-LOCADOR / 2-LOCATÁRIO)
    function alterarNome(uint tipoPessoa, string memory novoNome) public {
        if (tipoPessoa == 1) {
            nomeLocador = novoNome;
        } else if (tipoPessoa == 2) {
            nomeLocatario = novoNome;
        } else {
            revert("Tipo de pessoa invalido");
        }
    }

    // Função para efetuar reajuste do valor do aluguel recebendo o mês incial e valor
    function aplicaAjusteAluguel(uint mesInicial, uint valor) public {
        if (mesInicial > 36) {
            revert("Mes invalido");
        }
        uint ind = mesInicial - 1;
        for (uint i = ind; i < 36; i++) {
            valorAluguel[i] += valor;
        }
    }

}