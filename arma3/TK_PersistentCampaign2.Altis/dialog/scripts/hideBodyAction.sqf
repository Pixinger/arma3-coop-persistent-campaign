private["_unit"];
_unit = cursorTarget;
if (((_unit isKindOf "SoldierGB") || (_unit isKindOf "Civilian_F")) && (!alive _unit)) then 
{	
	hint "Die Person wurde bestattet. Die Bevölkerung findet das gut. Informationen haben Sie keine gefunden.";
	
	// Bei einer RED Einheit wird hier die Stimmung verbessert
	if (cursorTarget isKindOf "SoldierGB") then
	{
		private["_townObjects"];
		_townObjects = player nearEntities [pixTown_ConfigObjectClassname, 1000];
		if (count _townObjects > 0) then
		{
			private["_townName"];
			_townName = (_townObjects select 0) getVariable ["townName", ""];
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
				[[_townName, pixTown_ConfigMoodPerRedKill], "PC_fnc_TownParam_MoodAdd", false] call BIS_fnc_MP;
			};
		};
	};
	
	// Körper wegbeamen
	_unit setPos [0,0,0];
	Sleep 60;
	deleteVehicle _unit;
};