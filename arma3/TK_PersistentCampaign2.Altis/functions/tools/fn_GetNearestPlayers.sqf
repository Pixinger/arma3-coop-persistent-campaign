/* 
Gibt alle Spieler zurück, die sich innerhalb des angegebenen Bereichs befinden.

Parameter:
	_position: Die zu überprüfende Position
	_distance: Die maximale Entfernung (m) in der sich der Spieler befinden darf.

Return: 
	[]: Wenn keine Spieler in der Nähe sind, sonst ein Array mit den Spielern.
*/
private["_result"];
_result = [];

private["_players"];
_players = playableUnits;
if (count _players == 0) then { _players = [player]; };

private["_maxDistance"];
_maxDistance = [position, [position select 0, (position select 1) + _distance] call BIS_fnc_distance2Dsqr;
{
	if (_maxDistance >= [position, _x] call BIS_fnc_distance2Dsqr) then
	{
		_result set [count _result, _x];
	};
} foreach _players;

_result;