/* 
	Berechnet die Anzahl der BuildingPositions eines Gebäudes.
	
Parameter:
	_house: Das House-Object

Return: 
	Die Anzahl der Positionen.

/*-------------------------------------------------------------------*/

private["_house"];
_house = [_this, 0, objNull, [objNull], []] call BIS_fnc_param;

private["_maxIndex"];
_maxIndex = 0;

//while { (_building buildingPos _index) distance [0,0,0] > 0 && _index < _max } do {

if (!isNull _house) then
{
	while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};
};

_maxIndex;