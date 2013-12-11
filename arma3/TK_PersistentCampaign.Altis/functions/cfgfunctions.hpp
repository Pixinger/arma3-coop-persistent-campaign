class PC
{
	tag = "PC";
	
	class AI
	{
		file = "functions\ai";
		class AttackObject {description = "";};
		class CleanupMission {description = "";};
		class GuardObject {description = "";};
		class PatrolObject {description = "";};
		class PatrolZone {description = "";};
		class SetSkill {description = "";};
		class SpawnGroup {description = "";};
		class SpawnGroupAttackObject {description = "";};
		class SpawnGroupGuardObject {description = "";};
		class SpawnGroupPatrolObject {description = "";};
		class SpawnGroupPatrolZone {description = "";};
		class TrackGroup {description = "";};
	};
	
	class Logistic
	{
		file = "functions\logistic";
	};
	
	class Zone
	{
		file = "functions\zone";
		class AllMissionsFinished {description = "";};
		class AllMissionsSuccessfull {description = "";};
		class CanBlueforEngageZone {description = "";};
		class GetConnectedHostileZones {description = "";};
		class GetZoneIndex {description = "";};
		class IsPositionInZone {description = "";};
		class IsZoneForbidden {description = "";};
	};
	
	class missionsOpt
	{
		class FinishMissionStatus {description = "";};
	};
	class Tools
	{
		file = "functions\tools";
		class GetMinDistance {description = "";};
		class GetObfuscatedMarker {description = "";};
		class GetPlayerCount {description = "";};
		class GetRandomLocationZoneField {description = "";};
		class GetRandomLocationZoneHouse {description = "";};
		class GetRandomLocationZoneRoad {description = "";};
		class GetRandomPositionMarker {description = "";};
		class GetRandomPositionZone {description = "";};
		class GetRandomPositionZoneObject {description = "";};
		class GetUniqueMarkerName {description = "";};
	};
};




