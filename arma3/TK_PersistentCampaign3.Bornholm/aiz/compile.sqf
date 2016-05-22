if (isServer) then
{
	diag_log "compile: aiz";

	fnc_aiz_IsInGeoInfo = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_IsInGeoInfo.sqf";
	fnc_aiz_IsBlueNear = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_IsBlueNear.sqf";
	fnc_aiz_IsRedNear = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_IsRedNear.sqf";
	fnc_aiz_GetUnitDamageArray = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetUnitDamageArray.sqf";
	fnc_aiz_SetUnitDamageArray = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_SetUnitDamageArray.sqf";
	fnc_aiz_GroupReduce = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GroupReduce.sqf";
	fnc_aiz_GroupExpand = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GroupExpand.sqf";
	fnc_aiz_GroupTaskDefend = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GroupTaskDefend.sqf";
	fnc_aiz_GroupAliveCount = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GroupAliveCount.sqf";
	fnc_aiz_FindCampTent = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_FindCampTent.sqf";
	fnc_aiz_FindCampTentCount = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_FindCampTentCount.sqf";
	fnc_aiz_FindCampLaptop = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_FindCampLaptop.sqf";
	

	fnc_aiz_GetRandomInfClassnames = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomInfClassnames.sqf";
	fnc_aiz_GetRandomPosition = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPosition.sqf";
	fnc_aiz_GetRandomPositionRoad = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionRoad.sqf";
	fnc_aiz_GetRandomPositionField = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionField.sqf";
	fnc_aiz_GetRandomPositionHouse = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionHouse.sqf";

	fnc_aiz_BuildCampField = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_BuildCampField.sqf";
	fnc_aiz_BuildCampTown = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_BuildCampTown.sqf";
	fnc_aiz_BuildCheckpoint = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_BuildCheckpoint.sqf";

	fnc_aiz_IsFlat = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_IsFlat.sqf";
	fnc_aiz_CreateMineField = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_CreateMineField.sqf";
	fnc_aiz_CreateMineFieldRandom = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_CreateMineFieldRandom.sqf";
	fnc_aiz_GetMaxBuildingPositions = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetMaxBuildingPositions.sqf";
	fnc_aiz_GetMaxBuildingsPositions = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetMaxBuildingsPositions.sqf";
	fnc_aiz_CreateGroup = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_CreateGroup.sqf";
	fnc_aiz_IsAnyPlayerNear = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_IsAnyPlayerNear.sqf";
	fnc_aiz_NearestResidentialLocation = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_NearestResidentialLocation.sqf";
	fnc_aiz_RandomElement = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_RandomElement.sqf";

	fnc_aiz_RunGroup = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_RunGroup.sqf";
	fnc_aiz_RunGroupCheckpoint = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_RunGroupCheckpoint.sqf";
	fnc_aiz_RunGroupCampTown = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_RunGroupCampTown.sqf";
	fnc_aiz_RunGroupCampField = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_RunGroupCampField.sqf";
	fnc_aiz_ZoneInit = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_ZoneInit.sqf";
	fnc_aiz_ZoneResume = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_ZoneResume.sqf";
	fnc_aiz_ZonePause = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_ZonePause.sqf";

	fnc_aiz_DatabaseLoad = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_DatabaseLoad.sqf";
	fnc_aiz_DatabaseSaveServer = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_DatabaseSaveServer.sqf";
	fnc_aiz_DatabaseClearServer = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_DatabaseClearServer.sqf";

	fnc_aiz_OnTriggerActivated = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_OnTriggerActivated.sqf";
	fnc_aiz_OnTriggerDeactivated = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_OnTriggerDeactivated.sqf";
};

fnc_aiz_DatabaseSaveClient = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_DatabaseSaveClient.sqf";
fnc_aiz_DatabaseClearClient = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_DatabaseClearClient.sqf";
