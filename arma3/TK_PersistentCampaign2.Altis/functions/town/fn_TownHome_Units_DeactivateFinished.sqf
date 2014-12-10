/*
Überprüft eine Liste mit aktiven Einheiten, ob darin Einheiten enthalten sind, die DEAKTIVIERT werden müssen.
Die Einheiten werden deaktiviert, wenn sie NULL sind.

Parameter:
	_unitsActive: Das zu prüfende Array.

Return: 
	Die Anzahl der deaktivierten Einheiten
	
*/

private["_unitsActive"];
_unitsActive = _this select 0;

private["_result"];
_result = 0;

private["_index"];
_index = 0;
while { (_index < count _unitsActive) } do
{
	if (isNull ((_unitsActive select _index) select 0)) then 
	{
		deleteGroup ((_unitsActive select _index) select 1); // gruppe löschen
		((_unitsActive select _index) select 2) resize 2; // room inaktivieren
		_unitsActive deleteAt _index; // Aus der Liste nehmen		
		_result = _result + 1;
	}
	else
	{
		_index = _index + 1;
	};
};

_result;