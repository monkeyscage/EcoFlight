pragma solidity ^1.4.1;
 
contract flightsIndex{
address public owner; //il wallet che controlla e distrugge nel caso questo registro
address public generator; //il generatore che ha il prmesso di aggiungere voli al registro
address[] public flights; //l' indice in successione dei voli registrati
mapping(address => address[]) myflights; //L' indice dei voli registrati da un wallet specifico
mapping(string => address) flightbycode; //Tutti i voli indicizzati per codice volo
 
function flightsIndex(){owner=msg.sender;} //creazione

function setOwner(address NewOwner){ //per cambiare il wallet che controlla questo registro
if(msg.sender!=owner)revert();
owner=NewOwner;
}

function setGenerator(address NewGenerator){ //per cambiare il generatore di contratti di volo che puo scrivere su questo registro
if(msg.sender!=owner)revert();
generator=NewGenerator;
}

function addFlight(address FlightAddress,address creator,string code){ //solo il generatore puo aggiungere voli
if(msg.sender!=generator)revert();
myflights[creator].push(FlightAddress);
flights.push(FlightAddress);
flightbycode[code]=FlightAddress;
}

function removeFlight(uint index){ //rimozione manuale voli
if(msg.sender!=owner)revert();
flights[index]=address(0);
}

function getFlight(uint index)constant returns(uint,address){ //indirizzo di un volo, indicizzati da 0 a infinito
uint t=flights.length;
return(t,flights[index]);
}

function getMyFlight(address creator,uint index)constant returns(uint,address){ //indirizzi dei miei voli, indicizzati da 0 a infinito
uint t=myflights[creator].length;
return(t,myflights[creator][index]);
}

function getFlightByCode(string code)constant returns(address){ //indirizzi dei voli, indicizzati per codice volo
return(flightbycode[code]);
}
}
 
 
contract FlightGenerator{

//questo contratto controlla il registro
//contiene tutti i soldi
//al momento paga un premio standard + i soldi spesi, in caso di volo fallito

address public owner;
flightsIndex flightsindex;
mapping(address => address)public lastFlightGenerated;
mapping(address => bool)public prizeCheck;
uint public cost;
uint public prize;

function FlightGenerator(address mainindex) { //creazione
flightsindex=flightsIndex(mainindex);
owner=msg.sender;
}

function setOwner(address NewOwner){ //cambiare wallet che controlla generatore
if(msg.sender!=owner)revert();
owner=NewOwner;
}

function setCost(address NewCost){ //settaggio costo
if(msg.sender!=owner)revert();
cost=NewCost;
}

function setPrize(address NewPrize){ //settaggio premio
if(msg.sender!=owner)revert();
prize=NewPrize;
}

//generate new Flight
//paghi la somma e si genera un contratto di volo
function generateFlight(string code) returns(bool) payable{ 
if(msg.value<cost)revert(); //se i soldi sono abbastanza
address temp=new ECOFLIGHT(msg.sender,code, owner,msg.value); //crea contratto di volo
if(!flightsindex.addFlight(temp,msg.sender,code))revert(); //aggiunge al registro
lastFlightGenerated[msg.sender]=b; //registro interno al generatore (forse non necessario)
return true;
} 

function payPrize(address target,uint amount) returns(bool){ //solo contratti di volo registrati possono richiedre il pagamento
if(!prizeCheck[msg.sender])revert(); //se volo è registrato
if(!target.send(amount+prize))revert(); //spedisce premio
prizeCheck[msg.sender]=false; //rimuove diritto cosi non paga due volte
return true;
}
 
//destroy blog
function kill(){
if (msg.sender != owner)revert();
selfdestruct(owner);
}

//per svuotare contenitore soldi
function withdraw(uint amount){
if (msg.sender != owner)revert();
if(!owner.send(amount))revert();
}
 
}
 
contract ECOFLIGHT{
address public owner; //standard needed for Alpha Layer and generic augmentation
string standard="ECOFLIGHT.1.0";
string public code;
address public FlyTeam;
uint public amount;

//creation
function ECOFLIGHT(address o,string codex,address flyteam,uint amountx) {
owner=o;
code=codex;
FlyTeam=flyteam;
amount=amountx;
}

//change owner
function transfer(address o)returns(bool){
if(msg.sender!=owner)revert();
owner=o;
return true;
}
 
//add a new post at the end of the log
function withdraw() returns(bool){
if((msg.sender!=owner)&&(msg.sender!=FlyTeam))throw;
uint result=checkFlight(code);
if(result==0)revert();
if(result==1){if(!payPrize(owner,amount))revert();kill();}
return true;
}

function checkFlight(code) returns(uint) internal{
//chiama l' oracolo
return (1);
}

//destroy blog
function kill()internal{
selfdestruct(owner);
}
 
}


 
