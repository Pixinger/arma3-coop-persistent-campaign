if ((getPlayerUID player in pvPixLogisticAdminUIDs) || (getPlayerUID player in pvPixLogisticTeamLeaderUIDs) || (isServer && !isDedicated))then
{
	closeDialog 0;
	
	openMap [true, true] ;
	onMapSingleClick "'respawn_west' setMarkerPos _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; player globalChat 'INFO: Respawn verlegt'; true;";
};