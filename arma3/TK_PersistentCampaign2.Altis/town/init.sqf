call compile preprocessFileLineNumbers "town\config.sqf";

if (isServer) then
{
	townInitialized = false;
	publicVariable "townInitialized";

	private["_towns"];
	_towns = entities pixTown_ConfigObjectClassname;
	_x = _towns select 0;	
	//{
		[_x] execVM "town\run.sqf";
	//} foreach _towns;

	townInitialized = true;
	publicVariable "townInitialized";
	
	[] spawn {
		Sleep 10;
		diag_log format["Total town statistic: rooms=%1 population=%2", pixTown_TotalRooms, pixTown_TotalPopulation];
		player sidechat format["Total town statistic: rooms=%1 population=%2", pixTown_TotalRooms, pixTown_TotalPopulation];
	};
};

if (!isServer || !isDedicated) then
{
	player sidechat "Warte auf Städte";
	waitUntil { !(isNil "townInitialized") };
	waitUntil { townInitialized };
	player sidechat "Städte fertig";
};
