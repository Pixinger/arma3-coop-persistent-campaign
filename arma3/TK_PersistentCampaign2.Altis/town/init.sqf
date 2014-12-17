call compile preprocessFileLineNumbers "town\config.sqf";

pixTowns = entities pixTown_ConfigObjectClassname;
//_x = pixTowns select 0;
{
	[_x] execVM "town\run.sqf";
} foreach pixTowns;
