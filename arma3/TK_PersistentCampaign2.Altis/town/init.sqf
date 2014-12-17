call compile preprocessFileLineNumbers "town\config.sqf";

if (isServer) then
{
	private["_towns"];
	_towns = entities pixTown_ConfigObjectClassname;
	_x = _towns select 0;
	//{
		[_x] execVM "town\run.sqf";
	//} foreach _towns;
};