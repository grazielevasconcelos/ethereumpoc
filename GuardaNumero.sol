pragma solidity >= 0.4.22 <0.6.0;

contract GuardaNumero {
    uint numeroSorteado;
    address dono;
    uint contadorSorteio = 0;
    bool donoRico = false;
    uint256 saldo = msg.sender.balance;
    
    constructor(uint numeroInicial) public{
     require(msg.sender.balance > 99.9 ether);
     
     numeroSorteado = numeroInicial;
     dono = msg.sender;
     
     if(msg.sender.balance > 20 ether){
         donoRico = true;
     }else{
         donoRico = false;
     }
    }
    
    event TrocoEnviado(address pagador, uint troco);
    
    
    function set(uint enviado) public payable comCustoMinimo(1000) {
        numeroSorteado = enviado;
        contadorSorteio++;
        
        if(msg.value > 1000){
            uint troco = msg.value - 1000;
            msg.sender.transfer(troco);
            emit TrocoEnviado(msg.sender, troco);
        }
        
    }
    
    modifier comCustoMinimo(uint min){
        require(msg.value >= min, "NÃO FOI ENVIADO ETHER SUFICIENTE");
        _; // continue rodando a função, se passar do require, continua!
    }
    
    function get() public view returns(uint){
        return numeroSorteado;
    }
    
    function getContador() public view returns(uint){
        return contadorSorteio;
    }
    
    function getDono() public view returns(address){
        return dono;
    }
    
    function getRico() public view returns(bool){
        return donoRico;
    }
    
    function getCash() public view returns(uint256){
        return saldo;
    }
    
}
