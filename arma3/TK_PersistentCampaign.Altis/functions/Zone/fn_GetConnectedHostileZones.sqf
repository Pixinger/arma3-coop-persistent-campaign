/* 
	Diese Funktion liefert alle verbundenen Zonen zurück, die feindlich sind.
	Parameter 0: Der Zonenindex der überprüft werden soll. Davon abhängig werden die "Verbindungsregeln" für OpFor oder BlueFor verwendet.
	Die Funktion prüft dann, welche Zonen von dieser Zone aus angegriffen werden könnten. Der ZonenStatus 0 wird als OPFOR gewertet.
	Der ZonenStatus 1 und 2 wird als BLUEFOR gewertet.
	Mit anderen Worten es gibt die benachbarten, feindlichen Zonen zurück.

Parameter:
	_sourceZoneIndex: Der Index der Zone die den gültigen Bereich definiert.

Return: 
	Ein Array mit den benachbarten, feindlichen Zonen-Indices.
	Das Array ist leer, wenn keine Zonen verbunden sind oder keine verbundenen Zonen feindlich sind.

/*-------------------------------------------------------------------*/

private["_sourceZoneIndex"];
_sourceZoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [];

/* Festlegen welche Verbindungstabelle maßgeblich ist */
private["_condition"];
private["_connectedZones"];

/* Achtung
Die Original Zeile lautet: 		if ((pvehPixZones_ZoneStatus select _sourceZoneIndex) == 2) then 
Dabei gab es aber Probleme, wenn ein ReverseAttack lief. Bei dem Aufruf der missionRev Mission, liegt der Status der eigenen Zone bereits auf "1".
Deshalb wird die Zone dann nicht mehr als eigene Zone erkannt. 
Geändert wird Zeile auf: 		if ((pvehPixZones_ZoneStatus select _sourceZoneIndex) > 0) then 
Dadurch wird die Zone als BLUEFOR Zone erkannt. Es kann sein, dass sich das in anderen Skripten als Fehler erweist. Deshalb der ausführliche Text. */
if ((pvehPixZones_ZoneStatus select _sourceZoneIndex) > 0) then 
{ 
	/* Quellzone ist BLUEFOR, also sind alle Zonen die 0 sind = feindlich */
	_condition = "if ((pvehPixZones_ZoneStatus select _x) == 0) then { _result = _result + [_x];};"; /* ehemals: != 2 */
	_connectedZones = pixZones_ZoneConnectionsBlueFor select _sourceZoneIndex;
} 
else 
{ 
	/* Quellzone ist OPFOR, also sind alle Zonen die > 0 sind = feindlich */
	_condition = "if ((pvehPixZones_ZoneStatus select _x) > 0) then { _result = _result + [_x];};"; /* ehemals == 2 */
	_connectedZones = pixZones_ZoneConnectionsOpFor select _sourceZoneIndex;
};

/* Alle Verbundenen Zonen durchgehen und diejenigen die feindlich sind in das _result übernahmen */
{
	call compile _condition;
} foreach _connectedZones;

_result;