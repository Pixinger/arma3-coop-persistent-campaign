// Executed when player is killed in singleplayer or in multiplayer mission. 
// [<oldUnit>, <killer>, <respawn>, <respawnDelay>]

if (isServer) then
{
	private["_townObjects"];
	_townObjects = player nearEntities [pixTown_ConfigObjectClassname, 2000];
	{
		private["_townName"];
		_townName = _townObject getVariable ["townName", ""];
		if (_townName != "") then
		{
			player sidechat format["Unit %1 died near by %2", (_this select 0), _townName];
			diag_log format["Unit %1 died near by %2", (_this select 0), _townName];
			[_townName] call PC_fnc_Townparam_BluKillAdd;
		};
	} foreach _townObjects;
};