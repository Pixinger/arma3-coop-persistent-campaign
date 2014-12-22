if ((cursorTarget isKindOf "SoldierGB") && (cursorTarget distance player < 5))	then
{
	private["_unit"];
	_unit = cursorTarget;
	removeAllWeapons _unit;
	player action ["Surrender", _unit];

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
			[[_townName, pixTown_ConfigMoodPerRedArrest], "PC_fnc_TownParam_MoodAdd", false] call BIS_fnc_MP;
		};
	} foreach _townObjects;

	Sleep(30);
	
	deleteVehicle _unit;
};

