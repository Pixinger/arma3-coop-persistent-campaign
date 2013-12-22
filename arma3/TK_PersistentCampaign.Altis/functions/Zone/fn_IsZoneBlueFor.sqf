/* 
	Prüft, ob eine bestimmte Zone eine BlueFor Zone ist. Aktive Angriffszonen gehören nicht dazu!

Parameter:
	zoneIndex: Der Index der Zone die den gültigen Bereich definiert.

Return: 
	true, wenn die Position verboten ist, sonst false.

/*-------------------------------------------------------------------*/

private["_zoneIndex"];
_zoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

/* Ungültige Indizes werden als "erlaubt" zurückgegeben */
if (_zoneIndex < 0) exitWith {false;};
if (_zoneIndex >= count pvehPixZones_ZoneStatus) exitWith {false;};

/* Gültige Indizes werden geprüft */
if ((pvehPixZones_ZoneStatus select _zoneIndex) < 2) exitWith { false; };

true;