private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionEnv"]; /* [missionIndex, missionPosition, missionStatus] */
_missionEnv = ((pvehPixZones_MissionInfos select 1) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionEnv select 1;

/*--------------------------*/
/* Server oder ServerClient */
/*--------------------------*/
if (isServer) then
{
	private["_zoneIndex"];
	_zoneIndex = _this select 0;
	private["_groupSize"];
	_groupSize = _this select 1;
	private["_tmp"];
	
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];
	
	/*---------------------*/
	/* Patroullie erzeugen */
	/*---------------------*/
	private["_groupInfos"];
	_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_InfTeam_AA","OIA_MechInf_AT","OIA_MechInfSquad","OIA_MotInf_AT","OIA_MotInf_GMGTeam","OIA_MotInf_MGTeam","OIA_MotInf_MortTeam","OIA_MotInf_Team"], _zoneIndex, 25] call PC_fnc_SpawnGroupPatrolZone;		
	if (count _groupInfos > 0) then
	{
		_groups = _groups + [(_groupInfos select 0)];
		_vehicles = _vehicles + (_groupInfos select 1);
	};

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};
