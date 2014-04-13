/* 	
	In diesem Event Handler wird das Respawn behandelt
*/

[] spawn {
	waitUntil {alive player};

	Sleep 2;	
	
	if (side player == west) then
	{
		private["_tmp"]; 
		_tmp = [player, pixLogisticLastLoadOut] call compile preprocessFileLineNumbers "pixLogistic\dialogBarracks\applyLoadOut.sqf";
	};
};
