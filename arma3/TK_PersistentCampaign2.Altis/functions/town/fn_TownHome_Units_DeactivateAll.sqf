/*
Deaktiviert alle Einheiten einer Liste, egal wie der aktuelle Zustand der Einheiten ist.

Parameter:
	_unitsActive: Das zu prüfende Array.

Return: 
	Die Anzahl der deaktivierten Einheiten
	
*/

private["_unitsActive"];
_unitsActive = _this select 0;

private["_result"];
_result = 0;

{
	(_x select 2) resize 2; // room inaktivieren
	deleteVehicle (_x select 0); // unit löschen
	deleteGroup (_x select 1); // gruppe löschen
	_result = _result + 1;
} foreach _unitsActive;

_unitsActive = [];

_result;