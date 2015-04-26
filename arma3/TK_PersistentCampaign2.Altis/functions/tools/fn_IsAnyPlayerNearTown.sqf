/* 
Prüft ob sich irgendein Spieler in der Nähe der angegebenen Koordinate befindet.
Diese Funktion ist speziell auf die Aktvierung der Städte zugeschnitten.

Parameter:
	_position: Die zu überprüfende Position
	_distance: Die maximale Entfernung (m) in der sich der Spieler befinden darf.

Return: 
	TRUE wenn sich mindestens ein Spieler in der Nähe befindet, sonst FALSE.
*/

private["_position"];
_position = _this select 0;
private["_distance"];
_distance = _this select 1;

private["_result"];
_result = false;

private["_players"];
_players = playableUnits;
if (count _players == 0) then { _players = [player]; };


private["_maxDistance"];
_maxDistance = (_distance)^2; //optimierter Ausdruck für: _maxDistance = [_position, [_position select 0, (_position select 1) + _distance]] call BIS_fnc_distance2Dsqr;

{
	if ( (([_position, _x] call BIS_fnc_distance2Dsqr) < _maxDistance) && { (speed _x < 55) } ) exitWith { _result = true; };
} foreach _players;

_result;
/*

//private["_units"];
_distance = _position nearEntities ["I_Soldier_base_F", _distance];
//[0,0,0] nearEntities ["I_Soldier_base_F", 1000];

/*{
	if (speed _x < 55) exitWith { true };
} foreach _units;
_result;

//false
*/