/* 
	Diese Funktion stellt sicher, dass eine Gruppe eine bestimmte Position verteidigt.
	
Parameter:
	group: Die Gruppe welche die Position verteidigen soll.
	guardPosition: Die Position die verteidigt werden soll.
	
Return: 
	Wenn erfolgreich true, sonst false.

/*-------------------------------------------------------------------*/

if (!isServer) exitwith {["This functino is server-side only"] call BIS_fnc_error; false };

private["_missionInfoIndex"];
_missionInfoIndex = [_this, 0, -1, [0]] call BIS_fnc_param;
if (_missionInfoIndex < 0) exitwith {["Invalid _missionInfoIndex parameter"] call BIS_fnc_error; false };

/*-------------------------------------------------------------------*/

if (pixZones_ActiveIndex != -1) then
{
	(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1]; /* erfolgreich */	
}
else
{	
	(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
};
publicVariable "pvehPixZones_MissionStatus";
if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

true;
