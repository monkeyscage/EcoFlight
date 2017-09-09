pragma solidity ^0.4.6;
 
contract flightsIndex{
address public owner;
address public controller;
address[] public flights;
mapping(address => address[]) myflights;
 
function flightsIndex(){owner=msg.sender;}

function setOwner(address NewOwner){if(msg.sender!=owner)throw;owner=NewOwner;}
function setController(address NewController){if(msg.sender!=owner)throw;controller=NewController;}

function addFlight(address DappAddress,address creator){if(msg.sender!=owner)throw;mydapps[creator].push(DappAddress);dapps.push(DappAddress);}
function removeFlightp(uint index){if(msg.sender!=owner)throw;dapps[index]=0x0;}

function getFlight(uint index)constant returns(uint,address){uint t=dapps.length; return(t,dapps[index]);}
function getMyFlight(address creator,uint index)constant returns(uint,address){uint t=myblogs[creator].length; return(t,myblogs[creator][index]);}
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

function setOwner(address NewOwner){if(msg.sender!=owner)throw;owner=NewOwner;}


function setCost(address NewCost){if(msg.sender!=owner)throw;cost=NewCost;}

//generate new Flight
function generateFlight() returns(bool) payable{
if(msg.value<cost)throw;

address temp=new FLIGHT(msg.sender);
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
 
//creation
function ECOFLIGHT(address o) {
owner=o;
}

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
owner=o;
return true;
}
 
//add a new post at the end of the log
function addPost(string title,string content,string media,string link,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
return true;
}


//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}
 
}


 
