call compile preprocessFileLineNumbers "town\config.sqf";
call compile preprocessFileLineNumbers "town\functions\_compile.sqf";
call compile preprocessFileLineNumbers "town\sideMissions\functions\_compile.sqf";

if (ExecuteHeadlessCode) then
{
	townInitialized = false;
	publicVariable "townInitialized";
	townInfos = 0;
	publicVariable "townInfos";

	private["_towns"];
	_towns = entities pixTown_ConfigObjectClassname;
	private["_imax"];
	_imax = 555;
	//_x = _towns select 0;	
	{
		if (_imax > 0) then
		{
			[_x] execVM "town\run.sqf";
		};
		_imax = _imax - 1;
	} foreach _towns;

	townInitialized = true;
	publicVariable "townInitialized";
	
	"townInfos" addPublicVariableEventHandler { 
		diag_log format [ "Informationen wurden gesichert und an das HQ gesendet (%1).", _this select 1 ];
		if ((_this select 1) % 10 == 0) then
		{
			[] call fnc_TownSM_AssignSideMission;
		};
	};	
	
};

if (hasInterface) then
{
	player sidechat "Warte auf Städte";
	waitUntil { !(isNil "townInitialized") };
	waitUntil { townInitialized };
	player sidechat "Städte fertig";
	
	"townInfos" addPublicVariableEventHandler { hint format [ "Informationen wurden gesichert und an das HQ gesendet (%1).", _this select 1 ]; };
};
