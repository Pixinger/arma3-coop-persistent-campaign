/* 
	Diese Funktion stellt sicher, dass eine Gruppe eine bestimmte Zone patrolliert.
	
Parameter:
	group: Die Gruppe welche die Zone verteidigen soll.
	zoneIndex: Der ZonenIndex der Zone die patrolliert werden soll.
	(optional)zoneSafetyBorder: Sicherheitsabstand zum Rand.
	
Return: 
	nix

/*-------------------------------------------------------------------*/

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;

private["_zoneIndex"];
_zoneIndex = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_zoneSafetyBorder"];
_zoneSafetyBorder = [_this, 2, 25, [0]] call BIS_fnc_param;
if (_zoneSafetyBorder < 0) then { _zoneSafetyBorder = 0; };

/*-------------------------------------------------------------------*/

_group setBehaviour "AWARE";
_group setSpeedMode "LIMITED";
[_group] call PC_fnc_SetSkill;

for "_i" from 0 to (2 + floor (random 5)) do 
{
	private["_location"];
	_location = [_zoneIndex, _zoneSafetyBorder] call PC_fnc_GetRandomLocationZoneField;
	if (str(_location) != "[[0,0,0],0]") then
	{
		private["_waypoint"];
		_waypoint = _group addWaypoint [(_location select 0), 0];
		_waypoint setWaypointType "MOVE";

		_group setFormation (["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"] call BIS_fnc_selectRandom);
	};
};

private["_location"];
_location = [_zoneIndex, _zoneSafetyBorder] call PC_fnc_GetRandomLocationZoneField;
if (str(_location) != "[[0,0,0],0]") then
{
	_waypoint = _group addWaypoint [(_location select 0), 0];
	_waypoint setWaypointType "CYCLE";
};
