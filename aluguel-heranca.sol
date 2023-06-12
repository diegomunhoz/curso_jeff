// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*
*Contrato -
*/

contract ContratoAluguel {

    struct Contrato {
        address idLocador;
        uint codigoAluguel;
        string nomeLocador;
        string nomeLocatario;
        uint[36] valorAluguel;
        bool status;
    }
}

contract AluguelHeranca is ContratoAluguel {

    mapping(address => Contrato) public alugueis;

    // Modifier para validação de código do aluguel
    modifier validaCodigoAluguel (uint _codigoAluguel) {
        require(_codigoAluguel > 0, "Codigo do aluguel invalido ou inexistente!");
        _;
    }

    // Modifier para validação do valor do aluguel
    modifier validaValorAluguel (uint _valorAluguel) {
        require(_valorAluguel >= 0, "Valor invalido!");
        _;
    }

    // Modifier para validação do mes pesquisado
    modifier validaMesAluguel (uint _mes) {
        require(_mes < 36, "Mes invalido!");
        _;
    }

    // Função para efetuar uma locação
    function alugar(uint _codigoAluguel, string memory _nomeLocador, string memory _nomeLocatario, uint _valorAluguel) external validaCodigoAluguel(_codigoAluguel) validaValorAluguel(_valorAluguel) returns (bool) {
        alugueis[msg.sender] = Contrato(msg.sender, _codigoAluguel, _nomeLocador, _nomeLocatario, valorizaAluguel(_valorAluguel), true);
        return true;
    }

    // Função para atribuir o valor do aluguel
    function valorizaAluguel(uint _valorAluguel) private pure returns (uint[36] memory valorAluguel) {
        for (uint i = 0; i < 36; i++) {
            valorAluguel[i] = _valorAluguel;
        }
        return valorAluguel;
    }

    // Função para buscar o valor do aluguel em um mês específico
    function buscaValorAluguel(uint _codigoAluguel, uint _mes) public validaMesAluguel(_mes) view returns (uint) {
        return alugueis[msg.sender].valorAluguel[_mes-1];
    }

    // Função para buscar o locador e locatário
    function buscaLocadorLocatario(uint _codigoAluguel) public validaCodigoAluguel(_codigoAluguel) view returns (string memory, string memory) {
        return (getLocatario(_codigoAluguel), getLocador(_codigoAluguel));
    }

    // Função get que retorna o locador com texto concatenado
    function getLocador(uint _codigoAluguel) private validaCodigoAluguel(_codigoAluguel) view returns (string memory) {
        return string.concat("Locador: ", alugueis[msg.sender].nomeLocador);
    }

    // Método get que retorna o locatário com texto concatenado
    function getLocatario(uint _codigoAluguel) private validaCodigoAluguel(_codigoAluguel) view returns (string memory) {
        return string.concat("Locatario: ", alugueis[msg.sender].nomeLocatario);
    }

    // Função para alterar o nome com base no tipo de pessoa recebido (1-LOCADOR / 2-LOCATÁRIO)
    function alterarNome(uint _tipoPessoa, uint _codigoAluguel, string memory _novoNome) public validaCodigoAluguel(_codigoAluguel) {
        if (_tipoPessoa == 1) {
            alugueis[msg.sender].nomeLocador = _novoNome;
        } else if (_tipoPessoa == 2) {
            alugueis[msg.sender].nomeLocatario = _novoNome;
        } else {
            revert("Tipo de pessoa invalido");
        }
    }

    // Função para efetuar reajuste do valor do aluguel recebendo o mês incial e valor
    function aplicaAjusteAluguel(uint _codigoAluguel, uint _mes, uint _valor) public validaCodigoAluguel(_codigoAluguel) validaMesAluguel(_mes) validaValorAluguel(_valor) returns (bool) {
        uint ind = _mes - 1;
        for (uint i = ind; i < 36; i++) {
            alugueis[msg.sender].valorAluguel[i] += _valor;
        }
        return true;
    }

}