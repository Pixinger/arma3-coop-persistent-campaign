/* 
Prüft ob sich irgendein Spieler in der Nähe der angegebenen Koordinate befindet.

Parameter:
	_position: Die zu überprüfende Position
	_distance: Die maximale Entfernung (m) in der sich der Spieler befinden darf.

Return: 
	TRUE wenn sich mindestens ein Spieler in der Nähe befindet, sonst FALSE.
*/

private["_position"];
_position = [_this, 0, objNull, [objNull, []], [2,3]] call BIS_fnc_param;
private["_distance"];
_distance = [_this, 1, 0, [2000]] call BIS_fnc_param;

private["_result"];
_result = false;

private["_players"];
_players = playableUnits;
if (count _players == 0) then { _players = [player]; };

private["_maxDistance"];
_maxDistance = [_position, [_position select 0, (_position select 1) + _distance]] call BIS_fnc_distance2Dsqr;
{
	if (_maxDistance >= [_position, _x] call BIS_fnc_distance2Dsqr) exitWith { _result = true; };
} foreach _players;

_result;