/*
Überprüft eine Liste mit aktiven Einheiten, ob darin Einheiten enthalten sind, die DEAKTIVIERT oder ENTFERNT werden müssen.

Parameter:
	_unitsActive: Das zu prüfende Array.
	_townName: Der Name der Stadt. Dieser werden evtl. Strafpunkte zugefügt.

Return: 
	Die Anzahl der Einheiten die "ausgezigen" sind, weil gestorben oder gefangen
	
*/

private["_unitsActive"];
_unitsActive = _this select 0;
private["_townName"];
_townName = _this select 1;

//diag_log format["_unitsActive: %1", _unitsActive];

private["_countRemoved"];
_countRemoved = 0;

private["_room"];
private["_unit"];
private["_status"];
private["_index"];
_index = 0;
while { (_index < count _unitsActive) } do
{
	_room = (_unitsActive select _index);
	_unit = _room select 0;
	if (alive _unit) then
	{
		_status = _unit getVariable ["AA", 0]; // 0=Aktiv, 1=FSM-Finished, 2=Arrested
		if (_status == 0) then // 0==Aktiv
		{
			_index = _index + 1;
		}
		else
		{			
			//_status == 1: FSM-Finished
			if (_status == 1) then
			{
				deleteGroup (_room select 1); 	// Die Gruppe löschen
				(_room select 2) resize 2; 	// Dem ROOM "deaktivieren".
				_unitsActive deleteAt _index; 	// Aus der "_unitsActive" Liste nehmen.
				deleteVehicle _unit;			// Einheit löschen
				//_countRemoved = _countRemoved + 1; nicht erhöhen, da je nur deaktiviert!
			}
			else
			{			
				//_status == 2: Arrested
				if (_status == 2) then
				{
					(_room select 2) resize 1; 	// Aus dem ROOM "ausziehen".
					_unitsActive deleteAt _index; 	// Aus der "_unitsActive" Liste nehmen.
					_countRemoved = _countRemoved + 1;	// Da die Einheit nun ausgezogen ist, muss sie auch gezhält werden. Dieser Wert wird dann später an _townRedCount, _townCicCount übergeben.
					[_townName, pixTown_ConfigMoodPerRedArrest] call PC_fnc_TownParam_MoodAdd;
					
					// Nach einiger Zeit die Einheit entfernen
					[_unit] spawn {
						Sleep 15;
						deleteVehicle (_this select 0);
					};
				}
				else
				{
					_index = _index + 1;
				};
			};
		};
	}
	else
	{
		// Tote Einheiten werden aus der "_unitsActive" Liste entfernt, damit neue Einheiten nachspawnen können.
		// Außerdem muss der ROOM "geräumt" werden, da dort ja jetzt keiner mehr drin wohnt.
		// Die Einheit selbst wird aber nicht mit "deleteVehicle" gelöscht! Das passiert durch den Spieler mit der
		// "durchsuchen" Taste, oder aber durch "fn_TownHome_Units_DeactivateAll.sqf". Das gibt dann aber Strafpunkte 
		// für jede gefundene tote Einheit die nicht "durchsucht/begraben" wurde.
		deleteGroup (_room select 1); 	// Die Gruppe löschen
		(_room select 2) resize 1; 	// Aus dem ROOM "ausziehen".
		_unitsActive deleteAt _index; 	// Aus der "_unitsActive" Liste nehmen.
		_countRemoved = _countRemoved + 1;	// Da die Einheit nun ausgezogen ist, muss sie auch gezhält werden. Dieser Wert wird dann später an _townRedCount, _townCicCount übergeben.
		
		// Mood Änderungen durchführen
		if (_unit isKindOf "Civilian_F") then
		{
diag_log "fn_TownHome_Units_DeactivateFinished.sqf: CIV getötet";
			[_townName, pixTown_ConfigMoodPerCivKill] call PC_fnc_TownParam_MoodAdd;
		}
		else
		{
			if (_unit isKindOf "SoldierGB") then
			{
diag_log "fn_TownHome_Units_DeactivateFinished.sqf: RED getötet";
				[_townName, pixTown_ConfigMoodPerRedKill] call PC_fnc_TownParam_MoodAdd;
			};
		};
	};
};

_countRemoved;