if ((getPlayerUID player in pvPixLogisticAdminUIDs) || (getPlayerUID player in pvPixLogisticTeamLeaderUIDs) || (isServer && !isDedicated))then
{
	private["_attackMode"]; /* 0=random 1=attack 2=reverseattack */
	_attackMode = _this select 0;
	closeDialog 0;
	private["_tmp"];
	_tmp = [_attackMode] execVM "pixZones\hqSelectEngagementZone.sqf";
};