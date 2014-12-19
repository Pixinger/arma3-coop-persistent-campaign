private["_civ"];
_civ = cursorTarget;
if ((_civ isKindOf "Civilian_F") && (alive _civ) && (_civ distance player < 5)) then 
{
	// Welche Stadt?
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
			[[_townName, player], "PC_fnc_TownHome_StatusRequest", false] call BIS_fnc_MP;		
		};
	};
};