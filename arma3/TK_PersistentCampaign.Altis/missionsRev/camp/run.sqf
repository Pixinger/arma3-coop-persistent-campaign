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

	private["_flag"];
	_flag = "Flag_NATO_F" createVehicle _missionPosition;
	_buildings = _buildings + [_flag];
	
	/* Bunker1 erstellen */
	private["_bunker1"];
	_bunker1 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [6.5,-2,-2], [], 0, "NONE"];
	Sleep .5;
	_bunker1 setDir (random 359);
	_buildings = _buildings + [_bunker1];
	/* Bunker2 erstellen */
	private["_bunker2"];
	_bunker2 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [-8,-2,-2], [], 0, "NONE"];
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
	
	/*-----------------------------------*/
	/* Die Angriffs-Einheiten erstellen  */
	/*-----------------------------------*/
	private["_enemyUnits"];
	_enemyUnits = [];
	{
		/* Erste Gruppe */
		private["_markerName"];
		_markerName = format["Zone%1", _x];
		private["_spawnPos"];
		_spawnPos = [_markerName, [], 100, 0] call fn_missionsOpt_RandomPositionField;
		
		private["_spawnGroup"];
		_spawnGroup = [_spawnPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_spawnGroup] call fn_missionsOpt_SetSkill;

		(units _spawnGroup) doMove _missionPosition;
		_enemyUnits = _enemyUnits + (units _spawnGroup);
		
		/* Hier sollte noch mehr kommen, abhängig von der Spielerzahl */
		/* TODO... */
	} foreach _attackingZones;

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_aliveUnits"];
	private["_limit"];
	_limit = ceil((count _enemyUnits) / 10);
	private["_lost"];
	_lost = false;	
	while { (_aliveUnits > _limit) && (pixZones_ActiveIndex != -1) && (!_lost) } do
	{
		Sleep 2;
		_aliveUnits = 0;
		{ if (alive _x) then { _aliveUnits = _aliveUnits + 1;};} foreach _enemyUnits;
		if (position nearEntities ["SoldierEB", 20] > 0) then { _lost = true;};
	};

	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	if ((pixZones_ActiveIndex != -1) && (!_lost)) then
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
	{deletevehicle _x} foreach _enemyUnits;	
	{deletevehicle _x} foreach _buildings;	
	/* Cleanup */
	deleteGroup _groupBunker1; _groupBunker1 = nil;
	deleteGroup _groupBunker2; _groupBunker2 = nil;
};
 