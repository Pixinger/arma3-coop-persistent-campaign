/* Prüft ob die in der Variablen "pvehPixZones_MissionStatus" angegebenen Missionen alle beendet sind */

private["_result"];
_result = true;

{
	if (_x == 0) exitWith { _result = false;};
} foreach pvehPixZones_MissionStatus;
_result