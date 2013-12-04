diag_log "missionsRev\camp\run.sqf";
private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionRev"]; /* [missionIndex, missionPosition, missionStatus] */
_missionRev = ((pvehPixZones_MissionInfos select 3) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionRev select 1;
private["_missionDirection"];
_missionDirection = _missionRev select 2;

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionPosition, _missionDirection] execVM "missionsRev\camp\runClient.sqf";	
};

if (isServer) then
{
	/*---------------------------------------------------------------------*/
	/* Angreifende Zonen bestimmen, also da wo die Gegner herkommen sollen */
	/*---------------------------------------------------------------------*/
	private["_attackingZones"];
	_attackingZones = [_zoneIndex] call compile preprocessFileLineNumbers "missionsRev\fn_GetAttackingZones.sqf";

	/*-------------------*/
	/* Mission erstellen */
	/*-------------------*/	
	private["_buildings"];
	_buildings = [];
	private["_units"];
	_units = [];
	private["_groups"];
	_groups = [];

	private["_flag"];
	_flag = "Flag_NATO_F" createVehicle _missionPosition;
	_buildings = _buildings + [_flag];
	player setpos _missionPosition;
	
	/* Bunker1 erstellen */
	private["_bunker1"];
	_bunker1 = createVehicle ["Land_BagBunker_Small_F", _flag modelToWorld [6.5,-2,-2], [], 0, "NONE"];
	Sleep .5;
	_bunker1 setDir (random 359);
	_buildings = _buildings + [_bunker1];
	/* Bunker2 erstellen */
	private["_bunker2"];
	_bunker2 = createVehicle ["Land_BagBunker_Small_F", _flag modelToWorld [-8,-2,-2], [], 0, "NONE"];
	Sleep .5;
	_bunker2 setDir (random 359);
	_buildings = _buildings + [_bunker2];
	/* MG1 erstellen */
	private["_mg1"];
	_mg1 = createVehicle ["I_HMG_01_high_F", _bunker1 modelToWorld [0,0,0], [], 0, "CAN_COLLIDE"];
	Sleep .5;
	_mg1 setDir (random 359);
	_buildings = _buildings + [_mg1];
	/* MG2 erstellen */
	private["_mg2"];
	_mg2 = createVehicle ["I_HMG_01_high_F", _bunker2 modelToWorld [0,0,0], [], 0, "CAN_COLLIDE"];
	Sleep .5;
	_mg2 setDir (random 359);
	_buildings = _buildings + [_mg2];

	/* Einheit im Bunker1 */
	private["_group"];
	_group = createGroup west;
	private["_unitBunker1"];
	_unitBunker1 = _group createUnit ["B_Soldier_F", _missionPosition, [], 0, "NONE"];
	sleep .5;
	_unitBunker1 action ["getInGunner",_mg1];
	doStop _unitBunker1;
	_units = _units + [_unitBunker1];	
	_groups = _groups + [_group];
	
	/* Einheit im Bunker2 */
	_group = createGroup west;
	private["_unitBunker2"];
	_unitBunker2 = _group createUnit ["B_Soldier_F", _missionPosition, [], 0, "NONE"];
	sleep .5;
	_unitBunker2 action ["getInGunner",_mg2];
	doStop _unitBunker2;
	_units = _units + [_unitBunker2];
	_groups = _groups + [_group];

	/*-----------------------------------------------------------*/
	/* Wegpunkt als Ziel für die feindlichen Einheiten erstellen */
	/*-----------------------------------------------------------*/
	
	/*-----------------------------------*/
	/* Die Angriffs-Einheiten erstellen  */
	/*-----------------------------------*/
	private["_enemyUnits"];
	_enemyUnits = [];
	private["_enemyGroups"];
	_enemyGroups = [];
	private["_enemyVehicles"];
	_enemyVehicles = [];
	private["_enemyWaypoints"];
	_enemyWaypoints = [];
	
	private["_config"];
	_config = [fn_missionsRev_CreateInf, fn_missionsRev_CreateInfMech];/*, fn_missionsRev_CreateInfMech];*/
	
	{
		for "_i" from 0 to (count _config -1) do 
		{
			private["_enemyInfo"]; /* [units, groups, vehicles, waypoints] */	
			_enemyInfo = [_x, _missionPosition] call (_config select _i);/*fn_missionsRev_CreateInf; */
			if (count _enemyInfo > 0) then
			{
				_enemyUnits = _enemyUnits + (_enemyInfo select 0);
				_enemyGroups = _enemyGroups + (_enemyInfo select 1);
				_enemyVehicles = _enemyVehicles + (_enemyInfo select 2);
				_enemyWaypoints = _enemyWaypoints + (_enemyInfo select 3);			
			};
			
			/* Nur im Debug */
			if (isServer && !isDedicated) then
			{
				for "_o" from 0 to (count (_enemyInfo select 1) - 1) do
				{
					[(_enemyInfo select 1) select _o] spawn fn_missionsRev_TrackGroup;
				}
			};
		};
	
	} foreach _attackingZones;

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_limit"];
	_limit = ceil((count _enemyUnits) / 10);
	/*private["_lost"];
	_lost = false;	*/
	private["_aliveEnemyUnits"];
	_aliveEnemyUnits = 60000;
	while { ((_aliveEnemyUnits > _limit) && (pixZones_ActiveIndex != -1) && (!missionsRev_AttackFinished)) } do
	{
		Sleep 2;
		_aliveEnemyUnits = 0;
		{ if (alive _x) then { _aliveEnemyUnits = _aliveEnemyUnits + 1;};} foreach _enemyUnits;
		/*if ((position nearObjects["SoldierEB", 20]) > 0) then { _lost = true; };*/
	};

	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	if ((pixZones_ActiveIndex != -1) && (!missionsRev_AttackFinished)) then
	{
		(pvehPixZones_MissionStatus select 2) set [_missionInfoIndex, 1]; /* erfolgreich */	
	}
	else
	{	
		(pvehPixZones_MissionStatus select 2) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
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
	{deleteGroup _x} foreach _groups;
	
	{deletevehicle _x} foreach _enemyUnits;
	{deletevehicle _x} foreach _enemyVehicles;
	{deleteGroup _x} foreach _enemyGroups;
	{deleteWaypoint _x} foreach _enemyWaypoints;
};
 