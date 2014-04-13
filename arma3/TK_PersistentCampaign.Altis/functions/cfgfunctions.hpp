class PC
{
	tag = "PC";
	
	class AI
	{
		file = "functions\ai";
		class AttackObject {description = "";};
		class CleanupMission {description = "";};
		class GuardObject {description = "Parameter(group/guardPosition)";};
		class PatrolHouse {description = "Lässt eine Gruppe von einem Gebäude zum anderen patrollieren. Parameter(group/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
		class PatrolObject {description = "Parameter(group/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
		class PatrolObjectWater {description = "Parameter(group/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
		class PatrolRoad {description = "Lässt eine Gruppe auf Strassensegmenten patrollieren. Der Weg zwischen den Wegpunkten muss nicht zwingend über die Strasse gehen. Parameter(group/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
		class PatrolZone {description = "Parameter(group/zoneIndex/(opt)zoneSafetyBorder)";};
		class SetSkill {description = "";};
		class SpawnGroup {description = "";};
		class SpawnGroupAttackObject {description = "";};
		class SpawnGroupGuardObject {description = "";};
		class SpawnGroupPatrolRoad {description = "Parameter(cfgGroupNames/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
		class SpawnGroupPatrolHouse {description = "Parameter(cfgGroupNames/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
		class SpawnGroupPatrolObject {description = "Parameter(cfgGroupNames/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
		class SpawnGroupPatrolObjectWater {description = "Parameter(cfgGroupNames/zoneIndex/centerPosition/radius/(opt)zoneSafetyBorder)";};
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
		class IsZoneBlueFor {description = "";};
		class IsZoneForbidden {description = "";};
		class IsMissionLocationValid {description = "Prüft, ob eine MissionLocation gültig ist. Dazu wird verglichen, ob andere Missionen weit genug entfernt liegen.";};
	};
	
	class missionsOpt
	{
		class IsMissionFinished {description = "";};
		class FinishMissionStatus {description = "";};
		class FindVehicleTypeInRange {description = "";};
	};
	
	class TFR
	{
		class ActivateTFRRadio {description = "Activates a TFR radio that is somewhere stored in the uniform.";};
	};
	class Tools
	{
		file = "functions\tools";
		class CreateMineField {description = "Erzeugt ein Minenfeld";};
		class CreateMineFieldAtTarget {description = "Erzeugt ein Minenfeld in der Nähe eines Zieles";};		
		class Debug {description = "";};
		class Error {description = "";};
		class GetMinDistance {description = "";};
		class GetObfuscatedMarker {description = "";};
		class GetPlayerCount {description = "";};
		class GetRandomLocationZoneCity {description = "";};
		class GetRandomLocationZoneField {description = "";};
		class GetRandomLocationZoneHouse {description = "";};
		class GetRandomLocationZoneRoad {description = "";};
		class GetRandomLocationZoneWater {description = "";};
		class GetRandomPositionMarker {description = "";};
		class GetRandomPositionZone {description = "";};
		class GetRandomPositionZoneObject {description = "";};
		class GetUniqueMarkerName {description = "";};
		class IsFlat {description = "";};
	};
};




