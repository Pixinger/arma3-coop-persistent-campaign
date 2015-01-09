/*
Diese Funktion entfernt ein Fahrzeug von der Fahrzeugüberwachungsliste.
 
Parameter:
	_vehicle: Das zu entfernende Fahrzeug

Return: 
	true/false
*/

private["_result"];
_result = false;

if (isServer) then
{
	private["_vehicle"];
	_vehicle = _this select 0;

	if ((_vehicle isKindOf "LandVehicle") || (_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship")) then
	{
		private["_index"];
		_index = vehiclesDbItems find _vehicle;
		if (_index != -1) then
		{
			vehiclesDbItems deleteAt _index;

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
			[format["Fahrzeug %1 entfernt", typeof _vehicle], "hint", true] call BIS_fnc_MP;
		};
	};
};

_result;