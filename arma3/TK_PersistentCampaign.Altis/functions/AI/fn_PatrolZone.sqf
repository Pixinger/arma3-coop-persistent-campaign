/* 
	Diese Funktion stellt sicher, dass eine Gruppe eine bestimmte Zone patrolliert.
	
Parameter:
	group: Die Gruppe welche die Zone verteidigen soll.
	zoneIndex: Der ZonenIndex der Zone die patrolliert werden soll.
	(optional)zoneSafetyBorder: Sicherheitsabstand zum Rand.
	
Return: 
	Wenn erfolgreich true, sonst false.

/*-------------------------------------------------------------------*/

if (!isServer) exitWith { false };

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
if (isNull _group) exitwith {["Empty group parameter"] call BIS_fnc_error; false};

private["_zoneIndex"];
_zoneIndex = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_zoneSafetyBorder"];
_zoneSafetyBorder = [_this, 2, 25, [0]] call BIS_fnc_param;
if (_zoneSafetyBorder < 0) then { _zoneSafetyBorder = 0; };

/*-------------------------------------------------------------------*/

private["_result"];
_result = false;

_group setBehaviour "AWARE";
_group setSpeedMode "LIMITED";

private["_i"];
for "_i" from 0 to 10 do 
{
	private["_location"];
	_location = [_zoneIndex, _zoneSafetyBorder] call PC_fnc_GetRandomLocationZoneField;
	if (str(_location) != "[[0,0,0],0]") then
	{
		private["_waypoint"];
		_waypoint = _group addWaypoint [(_location select 0), 0];
		_waypoint setWaypointType "MOVE";
		_group setFormation (["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"] call BIS_fnc_selectRandom);
		_result = true;
	};
};

private["_location"];
_location = [_zoneIndex, _zoneSafetyBorder] call PC_fnc_GetRandomLocationZoneField;
if (str(_location) != "[[0,0,0],0]") then
{
	_waypoint = _group addWaypoint [(_location select 0), 0];
	_waypoint setWaypointType "CYCLE";
	_result = true;
};

if (!_result) exitwith {["PC_fnc_PatrolZone failed."] call BIS_fnc_error; false};

_result