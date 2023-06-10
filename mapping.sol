// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Mapping {

    mapping(address => Conta) public clientes;

    uint public totalDeContas;

    struct Conta {
        string nomeCliente;
        address enderecoCliente;
        uint saldo;
        bool status;
    }

    // Modifier para validação de conta
    modifier somenteContaAberta (address _enderecoCliente) {
        require(clientes[_enderecoCliente].status == true, "conta nao existente ou fechada");
        _;
    }

    // Verifica se a conta não exite para dar sequencia na abertura
    modifier somenteContaEncerrada (address _enderecoCliente) {
        require(clientes[_enderecoCliente].status == false, "Conta existente e aberta");
        _;
    }

    // Verifica se a conta não exite para dar sequencia na abertura
    modifier verificaValor (uint _novoValor) {
        require(_novoValor > 0, "Valor invalido");
        _;
    }

    // Função para abrir uma nova conta
    function abreConta(string memory _nomeCliente, address _enderecoCliente, uint _depositoInicial) external somenteContaEncerrada(_enderecoCliente) verificaValor(_depositoInicial) returns (bool) {
        require(_enderecoCliente != address(0), "Endereco invalido");
        Conta memory novaConta = Conta(_nomeCliente, _enderecoCliente, _depositoInicial, true);
        clientes[_enderecoCliente] = novaConta;
        totalDeContas++;
        return true;
    }

    // Função para atribuir valor do saldo e numero da conta
    function setSaldo(address _enderecoCliente, uint256 _novoValor) external somenteContaAberta(_enderecoCliente) verificaValor(_novoValor) returns (bool) {
        clientes[_enderecoCliente].saldo = _novoValor;
        return true;
    }

    // Função para buscar o saldo da conta
    function retirarClienteAzarado(address _enderecoCliente) external somenteContaAberta(_enderecoCliente) returns (bool) {

        if (clientes[_enderecoCliente].saldo != 13) {
            revert("uffa.. esse passou!");

        }
        // fecha a conta
        clientes[_enderecoCliente].saldo = 0;
        totalDeContas--;

        return true;
    }

    function getDadosConta(address _enderecoCliente) external view somenteContaAberta(_enderecoCliente) returns (Conta memory conta) {
        return clientes[_enderecoCliente];
    }

}