if ((getPlayerUID player in pvPixLogisticAdminUIDs) || (getPlayerUID player in pvPixLogisticTeamLeaderUIDs) || (isServer && !isDedicated))then
{
	closeDialog 0;
	private["_tmp"];
	_tmp = [] execVM "pixZones\hqSelectEngagementZone.sqf";
};