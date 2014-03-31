/*OI_diverTeam
"OI_diverTeam_Boat"
"OI_diverTeam_SDV"

"OIA_GuardSquad"
"OIA_GuardTeam"*/

private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionOpt"]; /* [missionIndex, missionPosition, missionDirection, markerPosition, markerRadius] */
_missionOpt = ((pvehPixZones_MissionInfos select 2) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionOpt select 1;
private["_missionDirection"];
_missionDirection = _missionOpt select 2; /* Wird hier verwendet um den Fahrzeug Typen zu bestimmen */
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------*/
/* Building Typen definieren */
/*---------------------------*/
private["_buildingClassnames"];
_buildingClassnames = ["O_Boat_Armed_01_hmg_F"];

/* Aus der zufälligen Richtung den Klassennamen errechnen */
private["_buildingClassnameIndex"];
_buildingClassnameIndex = floor (((count _buildingClassnames) / 360) * _missionDirection);
if (_buildingClassnameIndex < 0) then { _buildingClassnameIndex = 0;};
if (_buildingClassnameIndex >= count _buildingClassnames) then { _buildingClassnameIndex = (count _buildingClassnames) - 1;};

private["_buildingClassname"];
_buildingClassname = _buildingClassnames select _buildingClassnameIndex;


/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	/*----------------------------------------*/
	/* Standart Missions verarbeitung starten */
	/*----------------------------------------*/
	private["_taskTitle"];
	_taskTitle = "Boot untersuchen";
	private["_taskDescription"];
	_taskDescription = "Unser Geheimdienst hat ein Boot ermittelt in dem ein neues technisches Gerät verbaut ist. Bringen sie das Fahrzeug aus dem feindlichen Sektor, damit wir es genauer untersuchen können.";
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];
	
	/*--------------------*/
	/* Fahrzeug erstellen */
	/*--------------------*/
	private["_vehicle"];
	_vehicle = _buildingClassname createVehicle _missionPosition;
	_vehicle setdir (random 360);
	_vehicles = _vehicles + [_vehicle];

	/*-------------------------*/
	/* Patroullierende Truppen */
	/*-------------------------*/
	for "_i" from 0 to 3 do 
	{
		private["_groupInfos"];
		_groupInfos = [["OI_diverTeam"], _zoneIndex, _missionPosition, 500, 25] call PC_fnc_SpawnGroupPatrolObjectWater;		
		if (count _groupInfos > 0) then
		{
			_groups = _groups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_continue"];
	_continue = true;
	while { _continue } do
	{
		if (pixZones_ActiveIndex == -1) then { _continue = false; };
		if (!([_zoneIndex, getPos _vehicle] call PC_fnc_IsPositionInZone)) then { _continue = false; };
		Sleep 5;
	};
		
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	/*[_missionInfoIndex] call PC_fnc_FinishMissionStatus;*/
	if (pixZones_ActiveIndex == -1) then
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
	}
	else
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1]; /* erfolgreich */	
	};
	publicVariable "pvehPixZones_MissionStatus";
	if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};