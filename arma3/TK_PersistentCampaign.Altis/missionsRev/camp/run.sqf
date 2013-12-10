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
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];

	private["_flag"];
	_flag = "Flag_NATO_F" createVehicle _missionPosition;
	_buildings = _buildings + [_flag];
	
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
	_groups = _groups + [_group];
	
	/* Einheit im Bunker2 */
	_group = createGroup west;
	private["_unitBunker2"];
	_unitBunker2 = _group createUnit ["B_Soldier_F", _missionPosition, [], 0, "NONE"];
	sleep .5;
	_unitBunker2 action ["getInGunner",_mg2];
	doStop _unitBunker2;
	_groups = _groups + [_group];

	/*-----------------------------------*/
	/* Die Angriffs-Einheiten erstellen  */
	/*-----------------------------------*/
	private["_enemyGroups"];
	_enemyGroups = [];
	
	{
		for "_i" from 0 to 1 do
		{
			private["_groupInfos"];
			_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AA","OIA_InfTeam_AT","OIA_MechInf_AT","OIA_MotInf_AT","OIA_MotInf_GMGTeam","OIA_MotInf_MGTeam","OIA_TankPlatoon"], _x, _missionPosition, 200] call PC_fnc_SpawnGroupAttackObject;
			if (str(_groupInfos) != "[[0,0,0],0]") then
			{			
				_groups = _groups + [_groupInfos select 0];
				_vehicles = _vehicles + (_groupInfos select 1);
				_enemyGroups = _enemyGroups + [_groupInfos select 0];
			}
			else
			{
				diag_log format["ERROR: PC_fnc_SpawnGroupAttackObject for attacking zone %1 in rev\camp\run.sqf failed", _x];
			};
		};
	} foreach _attackingZones;

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_enemyUnits"];
	_enemyUnits = [];
	{
		_enemyUnits = _enemyUnits + (units _x);		
	} foreach _enemyGroups;
	
	private["_limit"];
	_limit = ceil((count _enemyUnits) / 25);
	private["_aliveEnemyUnits"];
	_aliveEnemyUnits = 60000;
	while { ((_aliveEnemyUnits > _limit) && (pixZones_ActiveIndex != -1) && (!missionsRev_AttackFinished)) } do
	{
		Sleep 2;
		_aliveEnemyUnits = 0;
		{ if (alive _x) then { _aliveEnemyUnits = _aliveEnemyUnits + 1;};} foreach _enemyUnits;
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

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};
 