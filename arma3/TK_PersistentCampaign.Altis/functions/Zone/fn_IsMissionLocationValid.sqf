/* 
	Prüft, ob eine bestimmte MissionLocation weit genug von allen anderen Missionen entfernt liegt.

Parameter:
	missionLocation: [[0,0,0],0,[0,0,0],0]  // [mission, marker] / mission: [[x,y,z],dir] / marker: [[x,y,z],dir]
	missionOptLocations: Array mir schon belegten MissionLocations
	(optional)distance: Mindest Entfernung
	
Return: 
	true, wenn die Position gültig ist.
	false, wenn die Position ungültig ist.

/*-------------------------------------------------------------------*/

private["_missionLocation"];
_missionLocation = [_this, 0, [0], [[]], [4]] call BIS_fnc_param;
private["_missionOptLocations"];
_missionOptLocations = [_this, 1, [0], [[]]] call BIS_fnc_param;
private["_distance"];
_distance = [_this, 2, 0, [0]] call BIS_fnc_param;
if (_distance <= 10) then { _distance = 300; };

/*-------------------------------------------------------------------*/

private["_l1"];
if (str(_missionLocation) == "[0]") exitWith {false;}; 
if (str(_missionOptLocations) == "[0]") exitWith {false;}; 
_l1 = _missionLocation select 0;
private["_result"];
_result = true;
{
	private["_l2"];
	_l2 = _x select 0;
	if (_l1 distance _l2 < _distance) exitWith { _result = false;};	
} foreach _missionOptLocations;

_result;