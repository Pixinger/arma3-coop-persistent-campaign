private["_unit"];
_unit = cursorTarget;
if ((_unit isKindOf pixTown_ConfigBaseClassRed) && (_unit distance player < 5) && (alive _unit)) then
{
	removeAllWeapons _unit;
	//player action ["Surrender", _unit];
	doStop _unit;
	_unit setBehaviour "CARELESS";
	_unit setVariable["AA", 2, true]; // 0==Aktiv 1==FSM-Finished 2==Arrested
	
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
	[[_unit], "PC_fnc_Arrest", false] call BIS_fnc_MP;
};

