private["_missionInfoIndex"];
_missionInfoIndex = _this select 0;
private["_missionPosition"];
_missionPosition = _this select 1;
private["_missionDirection"];
_missionDirection = _this select 2;


/*----------------*/
/* Task erstellen */
/*----------------*/
private["_currentTask"];
_currentTask = player createSimpleTask ["Checkpoint eliminieren"];
_currentTask setSimpleTaskDescription ["Der Feind hat einen Checkpoint errichtet. Schalten Sie alle Einheiten aus.", "Checkpoint eliminieren", ""];
_currentTask setSimpleTaskDestination _missionPosition;
_currentTask setTaskState "Assigned";

/*-----------------------------------*/
/* Eindeutigen Markernamen erstellen */
/*-----------------------------------*/
private["_i"];
_i = 0;
private["_markerName"];
_markerName = format["marker_checkpoint_%1", _i];
while { str(getMarkerPos _markerName) != "[0,0,0]" } do 
{
	_i = _i + 1;
	_markerName = format["marker_checkpoint_%1", _i];
};

/*------------------*/
/* Marker erstellen */
/*------------------*/
createMarkerLocal [_markerName, _missionPosition];
_markerName setMarkerShapeLocal "ICON";
_markerName setMarkerTypeLocal "mil_destroy";

/*------------------------------------*/
/* Warten bis die Mission zu Ende ist */
/*------------------------------------*/
player sidechat "checkpoint: waiting for mission status";
waitUntil { str(pvehPixZones_MissionStatus) != "[]" };
player sidechat "checkpoint: mission status received";
while { (pixZones_ActiveIndex != -1) && ((pvehPixZones_MissionStatus select _missionInfoIndex) == 0) } do
{
	 Sleep 2;
};

/*-------------------*/
/* Mission auswerten */
/*-------------------*/
if ((pvehPixZones_MissionStatus select _missionInfoIndex) == 1) then
{
	/* erfolgreich */
	_currentTask setTaskState "Succeeded";
}
else
{
	/* Fehlgeschlagen */
	_currentTask setTaskState "Failed";
};

/*-----------------*/
/* Maker entfernen */
/*-----------------*/
deleteMarkerLocal _markerName; 
_markerName = nil;