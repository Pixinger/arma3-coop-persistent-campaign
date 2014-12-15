call compile preprocessFileLineNumbers "town\config.sqf";

pixTowns = entities "Land_VRGoggles_01_F";

_x = pixTowns select 0;
{
	_x enableSimulationGlobal false;
	hideObjectGlobal _x;

	private["_townCenter"];
	_townCenter = getPos _x;
	private["_townRadius"];
	_townRadius = _x getVariable "townRadius";
	private["_townName"];
	_townName = _x getVariable "townName";
	
	[_townCenter, _townRadius, _townName] execVM "town\run.sqf";
} foreach pixTowns;
