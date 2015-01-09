/* 
Gibt die am nächsten liegende Location zurück

Parameter:
	_position: 

Return: 
	_location: 
*/

private["_position"];
_position = _this select 0;

private["_bestLocation"];
_bestLocation = nearestLocation [_position, "nameVillage"];

private["_bestDistanceSqr"];
_bestDistanceSqr = [_position, getPos _bestLocation] call BIS_fnc_distance2Dsqr;

private["_location"];
private["_distanceSqr"];

_location = nearestLocation [_position, "nameCity"];
_distanceSqr = [_position, getPos _location] call BIS_fnc_distance2Dsqr;
if (_bestDistanceSqr > _distanceSqr) then
{
	_bestLocation = _location;
	_bestDistanceSqr = _distanceSqr;
};

_location = nearestLocation [_position, "nameCityCapital"];
_distanceSqr = [_position, getPos _location] call BIS_fnc_distance2Dsqr;
if (_bestDistanceSqr > _distanceSqr) then
{
	_bestLocation = _location;
	_bestDistanceSqr = _distanceSqr;
};

_bestLocation;