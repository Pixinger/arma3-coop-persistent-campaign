/* Prüft ob die in der Variablen "pvehPixZones_MissionInfos" angegebenen Missionen alle beendet sind */

private["_result"];
_result = true;

{
	if (_x != 1) exitWith { _result = false;}; /*1=erfolgreich*/
} foreach pvehPixZones_MissionStatus;
_result