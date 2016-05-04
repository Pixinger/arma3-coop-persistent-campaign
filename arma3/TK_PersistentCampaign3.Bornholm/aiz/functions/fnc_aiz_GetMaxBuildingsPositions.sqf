/* 
	Berechnet die Anzahl der BuildingPositions eines Gebäudes.
	
Parameter:
	_house: Das House-Object

Return: 
	Die Anzahl der Positionen.

/*-------------------------------------------------------------------*/

private["_totalMaxIndex"];
_totalMaxIndex = 0;

private["_maxIndex"];

private["_houses"];
_houses = _this select 0;
{
	_maxIndex = 0;
	while { str(_x buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};	
	_totalMaxIndex = _totalMaxIndex + _maxIndex;
} foreach _houses;

_totalMaxIndex;