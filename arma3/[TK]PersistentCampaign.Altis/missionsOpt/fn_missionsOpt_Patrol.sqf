private["_grp"];
_grp = _this select 0;
private["_centerpos"];
_centerpos = _this select 1;
private["_distance"];
_distance = _this select 2;

_grp setBehaviour "SAFE";
_grp setSpeedMode "LIMITED";

private["_prevPos"];
_prevPos = getpos leader _grp;

	for "_i" from 0 to (2 + floor (random 10)) do {

	private["_newPos"];
	_newPos = [_prevPos,random 100, _distance, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;

	_prevPos = _newPos;

	private["_wp"];
	_wp = _grp addWaypoint [_newPos, 0];
	_wp setWaypointType "MOVE";

	_grp setFormation (["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"] call BIS_fnc_selectRandom);

};

_newPos = [_prevPos,random 100, _distance, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
_wp = _grp addWaypoint [_newPos, 0];
_wp setWaypointType "CYCLE";
