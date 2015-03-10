/* 
	Erzeugt eine Gruppe von Infantristen
	
Parameter:
	unitGroup: Gruppe
	unitPosition: [0,0,0]
	unitClassnames: Array mit den verfügbaren Classnames
	unitCount: Anzahl der Einheiten

Return: 
	_units - Array

/*-------------------------------------------------------------------*/

private["_unitGroup"];
_unitGroup = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;

private["_unitClassnames"];
_unitClassnames = [_this, 1, [], [[]]] call BIS_fnc_param;

private["_unitPosition"];
_unitPosition = [_this, 2, [0,0,0], [[3]]] call BIS_fnc_param;

private["_unitCount"];
_unitCount = [_this, 3, 1, [1]] call BIS_fnc_param;

private["_units"];
_units = [];

for "_i" from 1 to _unitCount do
{
	private["_unit"];
	_unit = _unitGroup createUnit [_unitClassnames select (floor(random(count _unitClassnames))), _unitPosition, [], 0, "FORM"];
	waitUntil {Sleep 0.2; !isNil "_unit"};
	_units pushBack _unit;
};

_units;