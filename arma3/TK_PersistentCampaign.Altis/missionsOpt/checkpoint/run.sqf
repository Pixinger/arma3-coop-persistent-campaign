/* ***************************************************************************************************** 
Inspired by "I34dKarma" - "KarmaRoadBlock" reworked by "Pixinger". Thanks for all the previous work!
******************************************************************************************************* */
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
	_taskTitle = "Checkpoint eliminieren";
	private["_taskDescription"];
	_taskDescription = "Der Feind hat einen Checkpoint errichtet. Schalten Sie alle Einheiten aus.";
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	/* Parameter prüfen */
	/*_missionDirection = _missionDirection + 90;*/
	private["_patrolCount"];
	_patrolCount = 2;
	
	/* Alle Gebäude sammeln */
	private["_buildings"];
	_buildings = [];
	private["_units"];
	_units = [];
	
	/* Schranke erstellen */
	private["_bargate"];
	_missionPosition set [2,0];
	_bargate = createVehicle ["Land_BarGate_F", _missionPosition, [], 0, "NONE"];
	Sleep .5;
	_bargate setDir _missionDirection;	 
	_bargate setPos _missionPosition;
	_tmp = _bargate addEventHandler ["HandleDamage", {false}];
	_buildings = _buildings + [_bargate];

	Sleep 1;
	_missionPosition = _bargate modelToWorld [7,0,0]; /* Position korrigieren, da die Schranke nicht mittig steht */
	_missionPosition set [2,0];
	_bargate setPos _missionPosition;

	
	/* Bunker1 erstellen */
	private["_bunker1"];
	_bunker1 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [6.5,-2,-2], [], 0, "NONE"];
	Sleep .5;
	_bunker1 setDir _missionDirection;
	_buildings = _buildings + [_bunker1];
	
	/* Bunker2 erstellen */
	private["_bunker2"];
	_bunker2 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [-8,-2,-2], [], 0, "NONE"];
	Sleep .5;
	_bunker2 setDir _missionDirection;
	_buildings = _buildings + [_bunker2];
	
	/* MG1 erstellen */
	private["_mg1"];
	_mg1 = createVehicle ["I_HMG_01_high_F", _bunker1 modelToWorld [0,0,0], [], 0, "CAN_COLLIDE"];
	Sleep .5;
	_mg1 setDir (_missionDirection-180);
	_buildings = _buildings + [_mg1];
	/* MG2 erstellen */
	private["_mg2"];
	_mg2 = createVehicle ["I_HMG_01_high_F", _bunker2 modelToWorld [0,0,0], [], 0, "CAN_COLLIDE"];
	Sleep .5;
	_mg2 setDir (_missionDirection-180);
	_buildings = _buildings + [_mg2];
	
	
	/*----------------------------------*/
	/* Vorbereitungen für die Einheiten */
	/*----------------------------------*/
	private["_side"];
	_side = EAST;
	private["_center"];
	_center = createCenter _side;
	private["_unittypes"];
	_unittypes = ["O_Soldier_SL_F", "O_Soldier_AT_F", "O_medic_F", "O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F"];
	
	/* Einheiten an der Schranke */
	private["_groupBargate"];
	_groupBargate = createGroup _side;
	private["_unitBargate"];
	_unitBargate = _groupBargate createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
	sleep .5;
	doStop _unitBargate;
	_units = _units + [_unitBargate];

	/* Einheit im Bunker1 */
	private["_groupBunker1"];
	_groupBunker1 = createGroup _side;
	private["_unitBunker1"];
	_unitBunker1 = _groupBunker1 createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
	sleep .5;
	_unitBunker1 action ["getInGunner",_mg1];
	doStop _unitBunker1;
	_units = _units + [_unitBunker1];
	
	/* Einheit im Bunker2 */
	private["_groupBunker2"];
	_groupBunker2 = createGroup _side;
	private["_unitBunker2"];
	_unitBunker2 = _groupBunker2 createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
	sleep .5;
	_unitBunker2 action ["getInGunner",_mg2];
	doStop _unitBunker2;
	_units = _units + [_unitBunker2];

	/* Patrollierende Einheiten erstellen */
	private["_groupPatrol"];
	_groupPatrol = createGroup _side;
	
	private["_unitPatrol"];
	_unitPatrol = _groupPatrol createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
	sleep .5;
	_units = _units + [_unitPatrol];
	_unitPatrol = _groupPatrol createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
	sleep .5;
	_units = _units + [_unitPatrol];
	
	private["_waypoint"];
	_waypoint = _groupPatrol addWaypoint [(_bargate modelToWorld [0,-30,-1]), 0];
	_waypoint setwaypointtype "MOVE";
	_waypoint setwaypointstatements ["True", ""];
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointTimeout [10, 30, 60]; 
	_waypoint = _groupPatrol addWaypoint [(_bargate modelToWorld [0,random 30,random 30]), 0];
	_waypoint setwaypointtype "MOVE";
	_waypoint setwaypointstatements ["True", ""];
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointTimeout [10, 30, 60]; 
	_waypoint = _groupPatrol addWaypoint [(_bargate modelToWorld [0,-30,-1]), 0];
	_waypoint setwaypointtype "CYCLE";
	_waypoint setwaypointstatements ["True", ""];
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointTimeout [10, 30, 60];

	if (pixDebug) then { player globalChat "Checkpoint spawned";};

	if (_missionPosition distance [0,0,0] > 1000) then 
	{ 
		/*--------------------------------------*/
		/* Warten bis die Mission erfüllt wurde */
		/*--------------------------------------*/
		private["_aliveUnits"];
		_aliveUnits = 5;
		while { (_aliveUnits > 1) && (pixZones_ActiveIndex != -1) } do
		{
			Sleep 2;
			_aliveUnits = 0;
			{ if (alive _x) then { _aliveUnits = _aliveUnits + 1;};} foreach _units;
		};
	};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
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

	/*-----------------------*/
	/* Kurze Zeitverzögerung */
	/*-----------------------*/
	sleep 60;

	/*------------------------*/
	/* Alle Einheiten löschen */
	/*------------------------*/
	{deletevehicle _x} foreach _units;	
	{deletevehicle _x} foreach _buildings;	
	/* Cleanup */
	deleteGroup _groupBargate; _groupBargate = nil;
	deleteGroup _groupBunker1; _groupBunker1 = nil;
	deleteGroup _groupBunker2; _groupBunker2 = nil;
	deleteGroup _groupPatrol; _groupPatrol = nil;
	deleteCenter _center; _center = nil;
	
	if (pixDebug) then { player globalChat "Checkpoint deleted";};	
};
 