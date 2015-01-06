if (call fnc_Town_SearchBuildingCond) then
{
	_building = nearestBuilding player; 
	
	private["_townObjects"];
	_townObjects = player nearEntities [pixTown_ConfigObjectClassname, 1000];
	if (count _townObjects > 0) then
	{
		private["_townName"];
		_townName = (_townObjects select 0) getVariable ["townName", ""];
		if (_townName != "") then
		{
			player sidechat format["Fordere Gebäudedurchsuchung an: %1, %2. Bitte Warten!", _townName, _building];
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
			[[_townName, _building], "PC_fnc_TownParam_SearchBuildingAdd", false] call BIS_fnc_MP;
		}
		else
		{
			player sidechat "WARN: Dieser Stadt wurde kein Name zugewiesen";
		};
	}
	else
	{
		player sidechat "WARN: Das Gebäude konnte keiner Stadt zugeordnet werden";
	};
};