if (isServer) then
{
	fnc_aiz_GetRandomPositionCircle = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionCircle.sqf";
	fnc_aiz_GetRandomPositionCircleCity = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionCircleCity.sqf";
	fnc_aiz_GetRandomPositionCircleField = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionCircleField.sqf";
	fnc_aiz_GetRandomPositionCircleHouse = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionCircleHouse.sqf";
	fnc_aiz_GetRandomPositionCircleHousePos = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionCircleHousePos.sqf";
	fnc_aiz_GetRandomPositionCircleRoad = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionCircleRoad.sqf";
	fnc_aiz_GetRandomPositionCircleWater = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionCircleWater.sqf";
	fnc_aiz_GetRandomPositionMarker = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionMarker.sqf";
	fnc_aiz_GetRandomPositionRectangle = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetRandomPositionRectangle.sqf";
	fnc_aiz_CreateMineField = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_CreateMineField.sqf";
	fnc_aiz_CreateMineFieldRandom = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_CreateMineFieldRandom.sqf";
	fnc_aiz_IsFlat = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_IsFlat.sqf";

	fnc_aiz_GetMaxBuildingPositions = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetMaxBuildingPositions.sqf";
	fnc_aiz_GetMaxBuildingsPositions = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_GetMaxBuildingsPositions.sqf";
	fnc_aiz_CreateGroup = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_CreateGroup.sqf";
	fnc_aiz_IsAnyPlayerNear = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_IsAnyPlayerNear.sqf";
	fnc_aiz_NearestResidentialLocation = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_NearestResidentialLocation.sqf";
	fnc_aiz_RandomElement = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_RandomElement.sqf";

	fnc_aiz_OnTriggerActivated = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_OnTriggerActivated.sqf";
	fnc_aiz_OnTriggerDeactivated = compile preprocessFileLineNumbers "aiz\functions\fnc_aiz_OnTriggerDeactivated.sqf";
};

diag_log "aiz compiled";