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
_missionDirection = _missionOpt select 2;
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	private["_taskTitle"];
	_taskTitle = "Materialkisten zerstÃ¶ren";
	private["_taskDescription"];
	_taskDescription = "Unser Nachrichtendienst hat Informationen abgefangen die darauf hinweisen, dass im Zielgebiet neue Technologie getestet werden soll. Laut den Informationen der verdeckten Ermittler, handelt es sich dabei um Material welche in zwei Kisten transportiert wird. ZerstÃ¶ren Sie diese Materialkisten. Es ist mit Feindlicher Infantrie zu rechnen, welche zur Bewachung abgestellt wurde.";
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
	
	private["_ammobox1"];
	_ammobox1 = "Box_East_WpsSpecial_F" createVehicle _missionPosition;
	_ammobox1 setdir random 360;
	_ammobox1 setVectorUp surfaceNormal (position _ammobox1);
	_buildings = _buildings + [_ammobox1];

	private["_ammobox2"];
	_ammobox2 = "Box_East_WpsSpecial_F" createVehicle _missionPosition;
	_ammobox2 setdir random 360;
	_ammobox2 setVectorUp surfaceNormal (position _ammobox2);
	_buildings = _buildings + [_ammobox2];	

	/*----------------------------------------------------------------------------*/
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	/*----------------------------------------------------------------------------*/
	private["_patrolCount"];
	_patrolCount = ceil((call PC_fnc_GetPlayerCount) / 4);

	/*-------------------------*/
	/* Patroullierende Truppen */
	/*-------------------------*/
	for "_i" from 0 to _patrolCount do 
	{
		private["_groupInfos"];
		_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInf_Team","OIA_MotInf_AT"], _zoneIndex, _missionPosition, 600, 25] call PC_fnc_SpawnGroupPatrolObject;		
		if (count _groupInfos > 0) then
		{
			_groups = _groups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
	};

	/*----------------------*/
	/* Verteidigungs Truppe */
	/*----------------------*/
	private["_groupInfos"];
	_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInf_Team","OIA_MotInf_AT","OIA_InfSentry"], _missionPosition] call PC_fnc_SpawnGroupGuardObject;
	if (count _groupInfos > 0) then
	{
		_groups = _groups + [(_groupInfos select 0)];
		_vehicles = _vehicles + (_groupInfos select 1);
	};

	/*--------------*/
	/* Vorschädigen */
	/*--------------*/
	_ammobox1 setDamage 0.5;
	_ammobox2 setDamage 0.5;
	
	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {((!alive _ammobox1) && (!alive _ammobox2)) || (pixZones_ActiveIndex == -1)};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	[_missionInfoIndex] call PC_fn_FinishMissionStatus;

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PN_fnc_CleanupMission;
};