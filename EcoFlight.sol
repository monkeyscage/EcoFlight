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
address public owner; //standard needed for Alpha Layer and generic augmentation
logsIndex logsindex;
mapping(address => address)public lastBlogGenerated;
//creation
function FlightGenerator(address mainindex) {
logsindex=logsIndex(mainindex);
owner=msg.sender;
}
 
//generate new BLOCKBLOG
function generateFlight() returns(bool){
address b=new FLIGHT(msg.sender);
if(!logsindex.addBlog(b,msg.sender))throw;
lastBlogGenerated[msg.sender]=b;
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


 
