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
	townArrested = 0;
	publicVariable "townArrested";

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
};

//if (!isServer || !isDedicated) then
if (hasInterface) then
{
	player sidechat "Warte auf Städte";
	waitUntil { !(isNil "townInitialized") };
	waitUntil { townInitialized };
	player sidechat "Städte fertig";
	
	"townInfos" addPublicVariableEventHandler { hint format [ "Informationen wurden gesichert und an das HQ gesendet (%1).", _this select 1 ] };	
	"townArrested" addPublicVariableEventHandler { hint format [ "Es wurden insgesamt %1 Einheiten festgenommen.", _this select 1 ] };	
};
