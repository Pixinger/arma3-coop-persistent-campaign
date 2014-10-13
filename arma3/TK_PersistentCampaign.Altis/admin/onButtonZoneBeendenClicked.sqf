closeDialog 0;

private["_status"];
_status = _this select 0;

private ["_count"];
_count = count (pvehPixZones_MissionStatus select 1);

private["_missionOptStatus"];
_missionOptStatus = [];
for "_i" from 0 to (_count - 1) do
{
	_missionOptStatus = _missionOptStatus + [_status];
};

pvehPixZones_MissionStatus set [1, _missionOptStatus];
/*---------------------------------------*/
/* An alle Clienten/Server weiterreichen */
/*---------------------------------------*/
publicVariable "pvehPixZones_MissionStatus";		
if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */
