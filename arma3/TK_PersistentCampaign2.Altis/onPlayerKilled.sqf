// Executed when player is killed in singleplayer or in multiplayer mission. 
// [<oldUnit>, <killer>, <respawn>, <respawnDelay>]
if (isServer) then
{
	private["_townObjects"];
	_townObjects = player nearEntities [pixTown_ConfigObjectClassname, 2000];
	{
		private["_townName"];
		_townName = _x getVariable ["townName", ""];
		if (_townName != "") then
		{
			diag_log format["Player-Unit died near by %2 (oldUnit, killer, respawn, respawnDelay): %1", _this, _townName];
			[_townName] call PC_fnc_Townparam_BluKillAdd;
			[_townName, -0.02] call PC_fnc_Townparam_MoodAdd;
		};
	} foreach _townObjects;
	
	
};