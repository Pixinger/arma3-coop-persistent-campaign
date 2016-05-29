if (isServer) then
{
	diag_log "compile: town";

	fnc_town_SpawnCivilian = compile preprocessFileLineNumbers "town\functions\fnc_town_SpawnCivilian.sqf";
	
	fnc_town_TownInit = compile preprocessFileLineNumbers "town\functions\fnc_town_TownInit.sqf";
	fnc_town_TownLoop = compile preprocessFileLineNumbers "town\functions\fnc_town_TownLoop.sqf";
	fnc_town_TownResume = compile preprocessFileLineNumbers "town\functions\fnc_town_TownResume.sqf";
	fnc_town_TownPause = compile preprocessFileLineNumbers "town\functions\fnc_town_TownPause.sqf";
	fnc_town_GetRandomPositionHouse = compile preprocessFileLineNumbers "town\functions\fnc_town_GetRandomPositionHouse.sqf";

	fnc_town_DatabaseLoad = compile preprocessFileLineNumbers "town\functions\fnc_town_DatabaseLoad.sqf";
	fnc_town_DatabaseSaveServer = compile preprocessFileLineNumbers "town\functions\fnc_town_DatabaseSaveServer.sqf";
	fnc_town_DatabaseClearServer = compile preprocessFileLineNumbers "town\functions\fnc_town_DatabaseClearServer.sqf";

	fnc_town_OnTriggerActivated = compile preprocessFileLineNumbers "town\functions\fnc_town_OnTriggerActivated.sqf";
	fnc_town_OnTriggerDeactivated = compile preprocessFileLineNumbers "town\functions\fnc_town_OnTriggerDeactivated.sqf";
	
};

fnc_town_DatabaseSaveClient = compile preprocessFileLineNumbers "town\functions\fnc_town_DatabaseSaveClient.sqf";
fnc_town_DatabaseClearClient = compile preprocessFileLineNumbers "town\functions\fnc_town_DatabaseClearClient.sqf";
