/*
Überprüft eine Liste mit aktiven Einheiten, ob darin Einheiten enthalten sind, die DEAKTIVIERT werden müssen.
Die Einheiten werden deaktiviert, wenn sie NULL sind.

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

private["_index"];
_index = 0;
while { (_index < count _unitsActive) } do
{
	private["_room"];
	_room = (_unitsActive select _index);
	if (isNull (_room select 0)) then 
	{
		// Die Einheit wurde erfolgreich despawnt. 
		//diag_log format["Unit deactivated: %1", (_unitsActive select _index)];
		//player sidechat format["Unit deactivated: %1", (_unitsActive select _index)];
		deleteGroup (_room select 1); // gruppe löschen
		(_room select 2) resize 2; // room inaktivieren
		_unitsActive deleteAt _index; // Aus der Liste nehmen		
		_result = _result + 1;
	}
	else
	{
		// Die Einheit ist entweder noch aktiv, oder tot.
		if (! (alive (_room select 0))) then
		{
			// RED Mood Änderungen werden beim durchuschen zugewiesen.
			if (_room select 0 isKindOf "Civilian_F") then
			{
diag_log "CIV getötet";
player sidechat "CIV getötet";
				[_townName, pixTown_ConfigMoodPerCivKill] call PC_fnc_TownParam_MoodAdd;
			};

			//deleteVehicle (_room select 0); // Einheit löschen
			deleteGroup (_room select 1); // gruppe löschen
			(_room select 2) resize 1; // room freigeben (ausziehen)
			_unitsActive deleteAt _index; // Aus der Liste nehmen		
			_result = _result + 1;
		}
		else
		{
			_index = _index + 1;
		};	
	};
};

_result;