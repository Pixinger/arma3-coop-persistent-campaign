/*
Deaktiviert alle Einheiten einer Liste, egal wie der aktuelle Zustand der Einheiten ist.

Parameter:
	_unitsActive: Das zu prüfende Array.
	_townName: Der Name der Stadt. Dieser werden evtl. Strafpunkte zugefügt.

Return: 
	Die Anzahl der deaktivierten Einheiten
	
*/

private["_unitsActive"];
_unitsActive = _this select 0;
private["_townName"];
_townName = _this select 1;

private["_result"];
_result = 0;

{
	if (!isNull (_x select 0)) then 
	{
		// Die Einheit ist entweder noch aktiv, oder tot.
		if (! (alive (_x select 0))) then
		{
			// RED Mood Änderungen werden beim Durchuschen zugewiesen.
			if ((_x select 0) isKindOf "Civilian_F") then
			{
diag_log "CIV getötet";
player sidechat "CIV getötet";
				[_townName, pixTown_ConfigMoodPerCivKill] call PC_fnc_TownParam_MoodAdd;
			};
		};
	};
	
	(_x select 2) resize 2; // room inaktivieren
	deleteVehicle (_x select 0); // unit löschen
	deleteGroup (_x select 1); // gruppe löschen
	_result = _result + 1;
} foreach _unitsActive;

_unitsActive = [];

_result;