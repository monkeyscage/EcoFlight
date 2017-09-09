pragma solidity ^0.4.6;
 
contract flightsIndex{
address public owner;
address public generator;
address[] public flights;
mapping(address => address[]) myflights;
 
function flightsIndex(){owner=msg.sender;}

function setOwner(address NewOwner){
if(msg.sender!=owner)throw;
owner=NewOwner;
}

function setGenerator(address NewGenerator){
if(msg.sender!=owner)throw;
generator=NewGenerator;
}

function addFlight(address FlightAddress,address creator){
if(msg.sender!=owner)throw;
myflights[creator].push(FlightAddress);
flights.push(FlightAddress);
}

function removeFlight(uint index){
if(msg.sender!=owner)throw;
flights[index]=0x0;
}

function getFlight(uint index)constant returns(uint,address){
uint t=flights.length;
return(t,flights[index]);
}

function getMyFlight(address creator,uint index)constant returns(uint,address){
uint t=myflights[creator].length;
return(t,myflights[creator][index]);
}
}
 
 
contract FlightGenerator{

address public owner;
flightsIndex flightsindex;
mapping(address => address)public lastFlightGenerated;
uint public cost;

function FlightGenerator(address mainindex) {
flightsindex=flightsIndex(mainindex);
owner=msg.sender;
}

function setOwner(address NewOwner){
if(msg.sender!=owner)throw;
owner=NewOwner;
}

function setCost(address NewCost){
if(msg.sender!=owner)throw;
cost=NewCost;
}

//generate new Flight
function generateFlight(string code) returns(bool) payable{
if(msg.value<cost)throw;
address temp=new ECOFLIGHT(msg.sender,code, owner);
if(!flightsindex.addFlight(temp,msg.sender))throw;
lastFlightGenerated[msg.sender]=b;
return true;
} 
 
//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}
 
}
 
contract ECOFLIGHT{
address public owner; //standard needed for Alpha Layer and generic augmentation
string standard="ECOFLIGHT.1.0";
string public code;
address public FlyTeam;

//creation
function ECOFLIGHT(address o,string codex,address flyteam) {
owner=o;
code=codex;
FlyTeam=flyteam;
}

//change owner
function transfer(address o)returns(bool){
if(msg.sender!=owner)throw;
owner=o;
return true;
}
 
//add a new post at the end of the log
function withdraw() returns(bool){
if((msg.sender!=owner)&&(msg.sender!=FlyTeam))throw;
uint result=checkFlight(code);
if(result==0)throw;
if(result==1){if(!owner.send(this.balance))throw;kill();}
if(result==2){if(!FlyTeam.send(this.balance))throw;kill();}
return true;
}

//destroy blog
function kill()internal{
selfdestruct(owner);
}
 
}


 
