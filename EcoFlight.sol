pragma solidity ^1.4.1;
 
contract flightsIndex{
address public owner;
address public generator;
address[] public flights;
mapping(address => address[]) myflights;
mapping(string => address) flightbycode;
 
function flightsIndex(){owner=msg.sender;}

function setOwner(address NewOwner){
if(msg.sender!=owner)revert();
owner=NewOwner;
}

function setGenerator(address NewGenerator){
if(msg.sender!=owner)revert();
generator=NewGenerator;
}

function addFlight(address FlightAddress,address creator,string code){
if(msg.sender!=owner)revert();
myflights[creator].push(FlightAddress);
flights.push(FlightAddress);
flightbycode[code]=FlightAddress;
}

function removeFlight(uint index){
if(msg.sender!=owner)revert();
flights[index]=address(0);
}

function getFlight(uint index)constant returns(uint,address){
uint t=flights.length;
return(t,flights[index]);
}

function getMyFlight(address creator,uint index)constant returns(uint,address){
uint t=myflights[creator].length;
return(t,myflights[creator][index]);
}

function getFlightByCode(string code)constant returns(address){
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

function FlightGenerator(address mainindex) {
flightsindex=flightsIndex(mainindex);
owner=msg.sender;
}

function setOwner(address NewOwner){
if(msg.sender!=owner)revert();
owner=NewOwner;
}

function setCost(address NewCost){
if(msg.sender!=owner)revert();
cost=NewCost;
}

function setPrize(address NewPrize){
if(msg.sender!=owner)revert();
prize=NewPrize;
}

//generate new Flight
function generateFlight(string code) returns(bool) payable{
if(msg.value<cost)revert();
address temp=new ECOFLIGHT(msg.sender,code, owner,msg.value);
if(!flightsindex.addFlight(temp,msg.sender))revert();
lastFlightGenerated[msg.sender]=b;
return true;
} 

function payPrize(address target,uint amount) returns(bool){
if(!prizeCheck[msg.sender])revert();
if(!target.send(amount+prize))revert();
prizeCheck[msg.sender]=false;
return true;
}
 
//destroy blog
function kill(){
if (msg.sender != owner)revert();
selfdestruct(owner);
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


 
