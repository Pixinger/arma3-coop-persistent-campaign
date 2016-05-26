/* 
	Berechnet die Anzahl der BuildingPositions eines Gebäudes.
	
Parameter:
	_house: Das House-Object

Return: 
	Die Anzahl der Positionen.

/*-------------------------------------------------------------------*/

private["_maxIndex"];
_maxIndex = 0;

while { str(_this buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1; };

_maxIndex;