/*
Diese Funktion speichert die alle Fahrzeuge in der XML Datei.
 
Parameter:

Return: 
	true/false
*/

private["_result"];
_result = false;

if (isServer) then
{
	private["_dbResult"];	
	_dbResult = "Arma2NET" callExtension "PC vehicle,beginwrite";
	if ("Arma2NET" callExtension format["PC isok,%1", _dbResult] == "OK") then
	{
		{
			private["_content"];
			_content = _x getVariable "content";
			if (isNil "_content") then { _content = []; };
			if (str(_content) == "") then { _content = []; };
			
			_dbResult = "Arma2NET" callExtension format["PC vehicle,write,%1,%2,%3,%4,%5", typeof _x, getPos _x, getDir _x, getDammage _x, _content];
			if ("Arma2NET" callExtension format["PC isok,%1", _dbResult] != "OK") then
			{
				diag_log format["ERROR: Unable to write vehicle: %1: %2", _vehicle, _dbResult];
			};
		} foreach vehiclesDbItems;
		
		_dbResult = "Arma2NET" callExtension "PC vehicle,endwrite";
		if ("Arma2NET" callExtension format["PC isok,%1", _dbResult] == "OK") then
		{
			// Param
			// Code/Function
			// Target
			//    Object - function will be executed only where unit is local [default: everyone] 
			//    Array - array of objects 
			//    Boolean - true to execute on each machine (including the one where the function was called from), false to execute it on server only 
			//    Number - function will be executed only on client with the given owner ID 
			//    Side - function will be executed only on clients where the player is on the specified side 
			//    Group - function will be executed only on clients where the player is in the specified group 
			// IsPersistent
			// IsCall 
			[[], "hint 'Vehicle-Datenbank gespeichert'", true] call BIS_fnc_MP;
			diag_log "Vehicle.SaveAll successfull";
			_result = true;
		};
	}
	else
	{
		diag_log format["ERROR: Vehicle.SaveAll failed: %1", _dbResult];
	};
};

_result;