private["_missionInfoIndex"];
_missionInfoIndex = _this select 0;
private["_missionPosition"];
_missionPosition = _this select 1;

/*----------------*/
/* Task erstellen */
/*----------------*/
private["_currentTask"];
_currentTask = player createSimpleTask ["Geheime Dokumente vernichten"];
_currentTask setSimpleTaskDescription ["Einer unserer Hubschrauber wurde abgeschossen und vom Feind gesichert. Leider befanden sich geheime Dokumente im Hubschrauber. Diese müssen von uns umgehend vernichtet werden. Beginnen Sie mit der Suche an der Absturztstelle.", "Geheime Dokumente vernichten", ""];
_currentTask setSimpleTaskDestination _missionPosition;
_currentTask setTaskState "Assigned";

/*-----------------------------------*/
/* Eindeutigen Markernamen erstellen */
/*-----------------------------------*/
private["_i"];
_i = 0;
private["_markerName"];
_markerName = format["marker_retrieveIntel_%1", _i];
while { str(getMarkerPos _markerName) != "[0,0,0]" } do 
{
	_i = _i + 1;
	_markerName = format["marker_retrieveIntel_%1", _i];
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

/*-----------------*/
/* Maker entfernen */
/*-----------------*/
deleteMarkerLocal _markerName; 
_markerName = nil;