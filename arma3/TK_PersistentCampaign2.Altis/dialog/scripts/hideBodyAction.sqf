if (((cursorTarget isKindOf "SoldierGB") || (cursorTarget isKindOf "Civilian_F")) && (!alive cursorTarget)) then 
{
//	cursorTarget action ["Hide", cursorTarget];
	deleteVehicle cursorTarget;
	player sidechat "Die Einheit wurde begraben. Die Bevölkerung findet das gut.";

	// Stimmung verbessern
	private["_townObjects"];
	_townObjects = player nearEntities [pixTown_ConfigObjectClassname, 1000];
	{
		private["_townName"];
		_townName = _x getVariable ["townName", ""];
		if (_townName != "") then
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
			[[_townName, 0.02], "PC_fnc_TownParam_MoodAdd", false] call BIS_fnc_MP;
		};
	} foreach _townObjects;
};