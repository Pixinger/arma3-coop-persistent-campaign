class PC
{
	tag = "PC";
	
	class Tools
	{
		file = "functions\Tools";
		class IsAnyPlayerNear {description = "";};
		class GetNearestPlayers {description = "";};
		class GetMaxBuildingPositions {description = "";};
		class GetMaxBuildingsPositions {description = "";};
		class RandomElement {description = "";};
		class NearestResidentialLocation {description = "";};
		class testinit {description = "";preInit = 1;postInit = 1;};
		class SetAsLeader {description = "";};
	};
	class Town
	{
		file = "functions\Town";
		class TownHome_Create {description = "";};
		class TownHome_DebugHomes {description = "";};
		class TownHome_DebugHomesActive {description = "";};
		class TownHome_DebugHomesInactive {description = "";};
		class TownHome_SettleAllResidents {description = "";};
		class TownHome_SettleRooms {description = "";};
		class TownHome_GetUnoccupiedRoom {description = "";};
		class TownHome_GetHouse {description = "";};
		class TownHome_MaxPopulation {description = "";};
		class TownHome_GetInactiveRoom {description = "";};
		class TownHome_GetInactiveRooms {description = "";};
		class TownHome_StatusRequest {description = "";};
		class TownHome_StatusResponse {description = "";};
		class TownHome_StatusUpdate {description = "";};

		class TownHome_Units_Activate {description = "";};
		class TownHome_Units_DeactivateAll {description = "";};
		class TownHome_Units_DeactivateFinished {description = "";};
		class TownHome_Units_ValidateFSM {description = "";};

		class TownParam_InjuredAdd {description = "";};
		class TownParam_InjuredPull {description = "";};
		class TownParam_WaterAdd {description = "";};
		class TownParam_WaterPull {description = "";};
		class TownParam_FoodAdd {description = "";};
		class TownParam_FoodPull {description = "";};
		class TownParam_MoodAdd {description = "";};
		class TownParam_MoodPull {description = "";};
		class TownParam_BluKillAdd {description = "";};
		class TownParam_BluKillPull {description = "";};
		class TownParam_SearchBuildingAdd {description = "";};
		class TownParam_SearchBuildingPull {description = "";};
		class TownParam_SearchBuildingInit {description = "";};
		
		class TownParam_SetTotalCivilians {description = "";};
		class TownParam_GetTotalCivilians {description = "";};
		class TownParam_SetTotalEnemies {description = "";};
		class TownParam_GetTotalEnemies {description = "";};
		class TownParam_SetElectricity {description = "";};
		class TownParam_GetElectricity {description = "";};
		class TownParam_SetPreacher {description = "";};
		class TownParam_GetPreacher {description = "";};
		class TownParam_SetWeapons {description = "";};
		class TownParam_GetWeapons {description = "";};
	};
};




