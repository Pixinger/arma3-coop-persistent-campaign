/* Prüft ob die in der Variablen "pvehPixZones_MissionInfos" angegebenen Missionen alle erfolgreich beendet sind */

private["_result"];
_result = true;

private["_missionEnvStatus"];
_missionEnvStatus = pvehPixZones_MissionStatus select 0;
private["_missionOptStatus"];
_missionOptStatus = pvehPixZones_MissionStatus select 1;
private["_missionRevStatus"];
_missionRevStatus = pvehPixZones_MissionStatus select 2;

{
	if (_x != 1) exitWith { _result = false;}; /*1=erfolgreich*/
} foreach _missionEnvStatus;

if (_result) then
{
	{
		if (_x != 1) exitWith { _result = false;}; /*1=erfolgreich*/
	} foreach _missionOptStatus;
};
if (_result) then
{
	{
		if (_x != 1) exitWith { _result = false;}; /*1=erfolgreich*/
	} foreach _missionRevStatus;
};

_result