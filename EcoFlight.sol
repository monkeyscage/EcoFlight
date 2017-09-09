pragma solidity ^1.4.1;
 
contract flightsIndex{
address public owner;
address public generator;
address[] public flights;
mapping(address => address[]) myflights;
 
function flightsIndex(){owner=msg.sender;}

function setOwner(address NewOwner){
if(msg.sender!=owner)revert();
owner=NewOwner;
}

function setGenerator(address NewGenerator){
if(msg.sender!=owner)revert();
generator=NewGenerator;
}

function addFlight(address FlightAddress,address creator){
if(msg.sender!=owner)revert();
myflights[creator].push(FlightAddress);
flights.push(FlightAddress);
}

function removeFlight(uint index){
if(msg.sender!=owner)revert();
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
mapping(address => bool) prizeCheck;
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
address temp=new ECOFLIGHT(msg.sender,code, owner);
if(!flightsindex.addFlight(temp,msg.sender))revert();
lastFlightGenerated[msg.sender]=b;
return true;
} 

function payPrize(address target) returns(bool){
if(!prizeCheck[msg.sender])revert();
prizeCheck[msg.sender]=false;
if(!target.send(prize))revert();
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

//creation
function ECOFLIGHT(address o,string codex,address flyteam) {
owner=o;
code=codex;
FlyTeam=flyteam;
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
if(result==1){if(!payPrize(owner))revert();kill();}
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


 
