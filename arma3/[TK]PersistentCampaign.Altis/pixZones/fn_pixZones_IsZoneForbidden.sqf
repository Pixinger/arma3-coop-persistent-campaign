private["_zoneIndex"];
_zoneIndex = _this select 0;

/* Ungültige Indizes werden als "erlaubt" zurückgegeben */
if (_zoneIndex < 0) exitWith {false;};
if (_zoneIndex >= count pvehPixZones_ZoneStatus) exitWith {false;};

/* Gültige Indizes werden geprüft */
if ((pvehPixZones_ZoneStatus select _zoneIndex) >= 1) exitWith { false; };

true;