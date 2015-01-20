/*
Deaktiviert alle Einheiten einer Liste, egal wie der aktuelle Zustand der Einheiten ist.

Parameter:
	_unitsActive: Das zu prüfende Array.
	_townObject: Das Stadtobjekt.

Return: 
	Die Anzahl der Einheiten die "ausgezigen" sind, weil gestorben oder gefangen 
	[_countRemoved, _weaponsReturned]	
*/

private["_unitsActive"];
_unitsActive = _this select 0;
private["_townObject"];
_townObject = _this select 1;

private["_townCenter"];
_townCenter = getPos _townObject;
private["_townRadius"];
_townRadius = _townObject getVariable "townRadius";
private["_townName"];
_townName = _townObject getVariable "townName";

private["_countRemoved"];
_countRemoved = 0;
private["_weaponsReturned"];
_weaponsReturned = 0;

private["_room"];
private["_unit"];
private["_status"];
{
	_room = _x;
	_unit = _room select 0;
	_status = _unit getVariable ["TS", 0]; // 0=Aktiv, 1=FSM-Finished, 2=Arrested
	if ("AGM_Handcuffed" in ([_unit] call AGM_Core_fnc_getCaptivityStatus)) then { _status = 2; player sidechat "arrested";};

	if (alive _unit) then
	{
		if (_status == 2) then // 2==Arrested
		{
			(_room select 2) resize 1; 	// Aus dem ROOM "ausziehen".
			[_townName, pixTown_ConfigMoodPerRedArrest] call PC_fnc_TownParam_MoodAdd;
			_countRemoved = _countRemoved + 1;	// Da die Einheit nun ausgezogen ist, muss sie auch gezhält werden. Dieser Wert wird dann später an _townRedCount, _townCicCount übergeben.
		}
		else // 0,1==Aktiv,FSM-Finished
		{
			if (primaryWeapon _unit != "") then { _weaponsReturned = _weaponsReturned + 1; };
			(_room select 2) resize 2; 	// Dem ROOM "deaktivieren".
		};
		deleteVehicle _unit;			// Einheit löschen
		deleteGroup (_room select 1); 	// Die Gruppe löschen
	}
	else
	{
		(_room select 2) resize 1; 	// Aus dem ROOM "ausziehen".
		_countRemoved = _countRemoved + 1;	// Da die Einheit nun ausgezogen ist, muss sie auch gezhält werden. Dieser Wert wird dann später an _townRedCount, _townCicCount übergeben.

		// Mood Änderungen durchführen
		if (_unit isKindOf "Civilian_F") then
		{
diag_log "fn_TownHome_Units_DeactivateAll.sqf: CIV getötet";
			[_townName, pixTown_ConfigMoodPerCivKill] call PC_fnc_TownParam_MoodAdd;
		}
		else
		{
			if (_unit isKindOf "SoldierGB") then
			{
diag_log "fn_TownHome_Units_DeactivateAll.sqf: RED getötet";
				[_townName, pixTown_ConfigMoodPerRedKill] call PC_fnc_TownParam_MoodAdd;
			};
		};
		deleteGroup (_room select 1); 	// Die Gruppe löschen
	};
	
} foreach _unitsActive;

//
// Abschließende Suche nach undurchsuchten/unbegrabenen Einheiten
private["_list"];
_list = _townCenter nearObjects ["SoldierGB", _townRadius];
private["_penalty"];
_penalty = 0;
{ 
	if (!alive _x) then
	{
		_weaponsReturned = _weaponsReturned + 1;
		deleteVehicle _x;
		_penalty = _penalty + 1;
	};
} foreach _list;
if (_penalty > 0) then
{
	[_townName, pixTown_ConfigMoodPerRedUnsearched * _penalty] call PC_fnc_TownParam_MoodAdd;
	diag_log format["%2,: Found %1 unsearched RED", _penalty, _townName];
};
_list = _townCenter nearObjects ["Civilian_F", _townRadius];
_penalty = 0;
{ 
	if (!alive _x) then
	{
		deleteVehicle _x;
		_penalty = _penalty + 1;
	};
} foreach _list;
if (_penalty > 0) then
{
	[_townName, pixTown_ConfigMoodPerCivUnsearched * _penalty] call PC_fnc_TownParam_MoodAdd;
	diag_log format["%2,: Found %1 unsearched CIV", _penalty, _townName];
};

//
// Und nocheinmal nach rumliegenden Waffen suchen
_list = nearestObjects [_townCenter, ["GroundWeaponHolder","WeaponHolder"], _townRadius];
{
	_weaponsReturned = _weaponsReturned + 1;
	deleteVehicle _x;
} foreach _list;

// Fertig
_unitsActive = [];
[_countRemoved, _weaponsReturned];