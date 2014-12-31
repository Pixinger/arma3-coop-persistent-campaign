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
}
else
{
	player sidechat "Warte auf Städte";
	waitUntil { !(isNil "townInitialized") };
	waitUntil { townInitialized };
	player sidechat "Städte fertig";
};};