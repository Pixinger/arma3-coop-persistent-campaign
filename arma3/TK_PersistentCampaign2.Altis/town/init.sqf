call compile preprocessFileLineNumbers "town\config.sqf";
call compile preprocessFileLineNumbers "town\functions\_compile.sqf";
call compile preprocessFileLineNumbers "town\functionsHomes\_compile.sqf";

// if (isServer) then
//if ((!hasInterface) || ((!HeadlessClientAvailable) && (isServer))) then 
if (ExecuteHeadlessCode) then
{
	townInitialized = false;
	publicVariable "townInitialized";
	townInfos = 0;
	publicVariable "townInfos";

	private["_towns"];
	_towns = entities pixTown_ConfigObjectClassname;
	//_x = _towns select 0;	
	{
		[_x] execVM "town\run.sqf";
	} foreach _towns;

	townInitialized = true;
	publicVariable "townInitialized";
	
	[] spawn {
		Sleep 10;
		diag_log format["Total town statistic: rooms=%1 population=%2", pixTown_TotalRooms, pixTown_TotalPopulation];
		player sidechat format["Total town statistic: rooms=%1 population=%2", pixTown_TotalRooms, pixTown_TotalPopulation];
	};	
};

//if (!isServer || !isDedicated) then
if (hasInterface) then
{
	player sidechat "Warte auf Städte";
	waitUntil { !(isNil "townInitialized") };
	waitUntil { townInitialized };
	player sidechat "Städte fertig";
	
	"townInfos" addPublicVariableEventHandler { hint format [ "Informationen wurden gesichert und an das HQ gesendet (%1).", _this select 1 ] };	
};
