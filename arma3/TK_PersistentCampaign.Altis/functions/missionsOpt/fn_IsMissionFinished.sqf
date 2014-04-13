/* 
	Prüft ob eine bestimmte Mission-Opt beendet wurde, oder nicht.
	
Parameter:
	_missionInfoIndex: Der MissionINdex der mission die 
	
Return: 
	true/false

/*-------------------------------------------------------------------*/

private["_missionInfoIndex"];
_missionInfoIndex = [_this, 0, -1, [0]] call BIS_fnc_param;
if (_missionInfoIndex < 0) exitwith {["Invalid _missionInfoIndex parameter"] call BIS_fnc_error; false };

/*-------------------------------------------------------------------*/

private["_result"];
_result = false;

if (((pvehPixZones_MissionStatus select 1) select _missionInfoIndex) == 1) then
{
	_result = true;
};

_result;