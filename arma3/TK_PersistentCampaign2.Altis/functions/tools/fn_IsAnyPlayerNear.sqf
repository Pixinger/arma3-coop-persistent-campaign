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
_result = ((player distance _position) < _distance);
_result;