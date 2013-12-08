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
	private["_relevantGroups"];
	_relevantGroups = [];
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];
	
	/* Als erstes die Schranke erstellen, da sich alles um diese Schranke dreht. */
	private["_bargate"];
	_missionPosition set [2,0];
	_bargate = createVehicle ["Land_BarGate_F", _missionPosition, [], 0, "NONE"];
	Sleep .2;
	_bargate setDir _missionDirection;	 
	_bargate setPos _missionPosition;
	_tmp = _bargate addEventHandler ["HandleDamage", {false}];
	_buildings = _buildings + [_bargate];
	Sleep .2;
	
	/* Position korrigieren, da die Schranke nicht mittig steht */
	_missionPosition = _bargate modelToWorld [7,0,0]; 
	_missionPosition set [2,0];
	_bargate setPos _missionPosition;

	
	/* Bunker1 erstellen */
	private["_bunker1"];
	_bunker1 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [6.5,-2,-2], [], 0, "NONE"];
	Sleep .2;
	_bunker1 setDir _missionDirection;
	_buildings = _buildings + [_bunker1];
	
	/* Bunker2 erstellen */
	private["_bunker2"];
	_bunker2 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [-8,-2,-2], [], 0, "NONE"];
	Sleep .2;
	_bunker2 setDir _missionDirection;
	_buildings = _buildings + [_bunker2];
	
	/* MG1 erstellen */
	private["_mg1"];
	_mg1 = createVehicle ["I_HMG_01_high_F", _bunker1 modelToWorld [0,0,0], [], 0, "CAN_COLLIDE"];
	Sleep .2;
	_mg1 setDir (_missionDirection-180);
	_buildings = _buildings + [_mg1];
	/* MG2 erstellen */
	private["_mg2"];
	_mg2 = createVehicle ["I_HMG_01_high_F", _bunker2 modelToWorld [0,0,0], [], 0, "CAN_COLLIDE"];
	Sleep .2;
	_mg2 setDir (_missionDirection-180);
	_buildings = _buildings + [_mg2];
	
	
	/*----------------------------------*/
	/* Vorbereitungen für die Einheiten */
	/*----------------------------------*/
	private["_unittypes"];
	_unittypes = ["O_Soldier_SL_F", "O_Soldier_AT_F", "O_medic_F", "O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F"];
	
	/* Einheiten an der Schranke */
	private["_groupBargate"];
	_groupBargate = createGroup east;
	private["_unitBargate"];
	_unitBargate = _groupBargate createUnit ["O_Soldier_SL_F", _missionPosition, [], 0, "NONE"];
	sleep .2;
	doStop _unitBargate;
	_groups = _groups + [_groupBargate];
	_relevantGroups = _relevantGroups + [_groupBargate];

	/* Einheit im Bunker1 */
	private["_groupBunker1"];
	_groupBunker1 = createGroup east;
	private["_unitBunker1"];
	_unitBunker1 = _groupBunker1 createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
	sleep .5;
	_unitBunker1 action ["getInGunner",_mg1];
	doStop _unitBunker1;
	_groups = _groups + [_groupBunker1];
	_relevantGroups = _relevantGroups + [_groupBunker1];
	
	/* Einheit im Bunker2 */
	private["_groupBunker2"];
	_groupBunker2 = createGroup east;
	private["_unitBunker2"];
	_unitBunker2 = _groupBunker2 createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
	sleep .5;
	_unitBunker2 action ["getInGunner",_mg2];
	doStop _unitBunker2;
	_groups = _groups + [_unitBunker2];
	_relevantGroups = _relevantGroups + [_unitBunker2];
	
	/*----------------------------------*/
	/* Patroullierende Truppe erstellen */
	/*----------------------------------*/
	private["_groupInfos"];
	_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInf_Team","OIA_MotInf_AT"], _zoneIndex, _missionPosition, 150, 25] call PC_fnc_SpawnGroupPatrolObject;		
	if (count _groupInfos > 0) then
	{
		_groups = _groups + [(_groupInfos select 0)];
		_vehicles = _vehicles + (_groupInfos select 1);
		_relevantGroups = _relevantGroups + [(_groupInfos select 0)];
	};
	
	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_relevantUnits"];
	_relevantUnits = [];
	{
		_relevantUnits = _relevantUnits + (units _x);		
	} foreach _relevantGroups;
	private["_aliveUnits"];
	_aliveUnits = 65000;
	while { (_aliveUnits > 1) && (pixZones_ActiveIndex != -1) } do
	{
		Sleep 2;
		_aliveUnits = 0;
		{ if (alive _x) then { _aliveUnits = _aliveUnits + 1;};} foreach _relevantUnits;
	};
	
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
	deleteCenter _center; _center = nil;
};
 