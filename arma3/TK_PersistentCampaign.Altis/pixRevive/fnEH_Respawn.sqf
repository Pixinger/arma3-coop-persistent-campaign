/* 	
	In diesem Event Handler wird das Respawn behandelt
*/

player globalChat "player respawned";
waitUntil {alive player};
player globalChat "player now alive again";
private["_tmp"]; 
_tmp = [player, pixLogisticLastLoadOut] call compile preprocessFileLineNumbers "pixLogistic\dialogBarracks\applyLoadOut.sqf";			
