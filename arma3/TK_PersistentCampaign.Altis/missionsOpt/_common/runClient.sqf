private["_missionInfoIndex"];
_missionInfoIndex = _this select 0;
private["_missionMarkerPosition"];
_missionMarkerPosition = _this select 1;
private["_missionMarkerRadius"];
_missionMarkerRadius = _this select 2;
private["_taskTitle"];
_taskTitle = _this select 3;
private["_taskDescription"];
_taskDescription = _this select 4;

/*----------------*/
/* Task erstellen */
/*----------------*/
private["_currentTask"];
_currentTask = player createSimpleTask [_taskTitle];
_currentTask setSimpleTaskDescription [_taskDescription, _taskTitle, ""];
_currentTask setSimpleTaskDestination _missionMarkerPosition;
_currentTask setTaskState "Assigned";

/*-----------------------------------*/
/* Eindeutigen Markernamen erstellen */
/*-----------------------------------*/
private["_markerName"];
if (_missionMarkerRadius > 0) then
{
	_markerName = call fn_missionsOpt_GetUniqueMarkerName;

	/*------------------*/
	/* Marker erstellen */
	/*------------------*/
	createMarkerLocal [_markerName, _missionMarkerPosition];
	_markerName setMarkerShapeLocal "ELLIPSE";
	_markerName setMarkerSizeLocal [_missionMarkerRadius, _missionMarkerRadius];
	_markerName setMarkerAlphaLocal 0.5;
	_markerName setMarkerColorLocal "ColorRed";
};

/*------------------------------------*/
/* Warten bis die Mission zu Ende ist */
/*------------------------------------*/
waitUntil { str(pvehPixZones_MissionStatus) != "[]" };
while { (pixZones_ActiveIndex != -1) && (((pvehPixZones_MissionStatus select 1) select _missionInfoIndex) == 0) } do
{
	 Sleep 2;
};

/*-------------------*/
/* Mission auswerten */
/*-------------------*/
if (((pvehPixZones_MissionStatus select 1) select _missionInfoIndex) == 1) then
{
	/* erfolgreich */
	_currentTask setTaskState "Succeeded";
}
else
{
	/* Fehlgeschlagen */
	_currentTask setTaskState "Failed";
};



if (_missionMarkerRadius > 0) then
{
	/*-----------------*/
	/* Maker entfernen */
	/*-----------------*/
	deleteMarkerLocal _markerName; 
	_markerName = nil;
};