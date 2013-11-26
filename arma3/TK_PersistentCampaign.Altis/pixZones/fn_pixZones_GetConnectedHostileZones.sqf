/*
	Diese Funktion liefert alle verbundenen Zonen zurück, die feindlich sind.
	Parameter 0: Der Zonenindex der überprüft werden soll. Davon abhängig werden die "Verbindungsregeln" für OpFor oder BlueFor verwendet.
	Die Funktion prüft dann, welche Zonen von dieser Zone aus angegriffen werden könnten.
	Mit anderen Worten es gibt die benachbarten, feindlichen Zonen zurück.
	Result: Ein Array mit den benachbarten, feindlichen Zonen-Indices.
			Das Array ist leer, wenn keine Zonen verbunden sind oder keine verbundenen Zonen feindlich sind.
*/

private["_sourceZoneIndex"];
_sourceZoneIndex = _this select 0; /* Der zu prüfende ZonenIndex */

private["_result"];
_result = [];

/* Festlegen welche Verbindungstabelle maßgeblich ist */
private["_condition"];
private["_connectedZones"];
if ((pvehPixZones_ZoneStatus select _sourceZoneIndex) == 2) then 
{ 
	_condition = "if ((pvehPixZones_ZoneStatus select _x) != 2) then { _result = _result + [_x];};";
	_connectedZones = pixZones_ZoneConnectionsBlueFor select _sourceZoneIndex;
} 
else 
{ 
	_condition = "if ((pvehPixZones_ZoneStatus select _x) == 2) then { _result = _result + [_x];};";
	_connectedZones = pixZones_ZoneConnectionsOpFor select _sourceZoneIndex;
};

/* Alle Verbundenen Zonen durchgehen und diejenigen die feindlich sind in das _result übernahmen */
{
	call compile _condition;
} foreach _connectedZones;

_result;