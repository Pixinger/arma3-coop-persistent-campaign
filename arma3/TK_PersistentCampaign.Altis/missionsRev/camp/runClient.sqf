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
_currentTask = player createSimpleTask ["Stützpunkt beschützen"];
_currentTask setSimpleTaskDescription ["Der Feind rückt auf einen alliierten Stützpunkt zu. Verteidigen sie diesen Stützpunkt mit allen Mitteln. Sollte der Stützpunkt erobert werden, werden wir den Sektor verlieren.", "Stützpunkt beschützen", ""];
_currentTask setSimpleTaskDestination _missionPosition;
_currentTask setTaskState "Assigned";

/*------------------------------------*/
/* Warten bis die Mission zu Ende ist */
/*------------------------------------*/
waitUntil { str(pvehPixZones_MissionStatus) != "[]" };
while { (pixZones_ActiveIndex != -1) && (((pvehPixZones_MissionStatus select 2) select _missionInfoIndex) == 0) } do
{
	 Sleep 2;
};

/*-------------------*/
/* Mission auswerten */
/*-------------------*/
if (((pvehPixZones_MissionStatus select 2) select _missionInfoIndex) == 1) then
{
	/* erfolgreich */
	_currentTask setTaskState "Succeeded";
}
else
{
	/* Fehlgeschlagen */
	_currentTask setTaskState "Failed";
};