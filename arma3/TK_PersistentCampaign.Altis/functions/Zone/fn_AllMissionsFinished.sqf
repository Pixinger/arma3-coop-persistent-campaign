/* 
	Prüft ob die in der Variablen "pvehPixZones_MissionStatus" angegebenen Missionen alle beendet sind.

Parameter:
	keine

Return: 
	true / false

/*-------------------------------------------------------------------*/

private["_result"];
_result = true;

private["_missionEnvStatus"];
_missionEnvStatus = pvehPixZones_MissionStatus select 0;
private["_missionOptStatus"];
_missionOptStatus = pvehPixZones_MissionStatus select 1;
private["_missionRevStatus"];
_missionRevStatus = pvehPixZones_MissionStatus select 2;

{
	if (_x == 0) exitWith { _result = false;}; /*1=erfolgreich*/
} foreach _missionEnvStatus;

if (_result) then
{
	{
		if (_x == 0) exitWith { _result = false;}; /*1=erfolgreich*/
	} foreach _missionOptStatus;
}; 
 
if (_result) then
{
	{
		if (_x == 0) exitWith { _result = false;}; /*1=erfolgreich*/
	} foreach _missionRevStatus;
};

_result