if (pvPlayerTeleport) then
{
	openMap [true, true];
	playerTeleportUnit = vehicle player;
	onMapSingleClick "playerTeleportUnit setPos _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; playerTeleportUnit = nil; true;";
}
else
{
	hintC "Teleport ist nicht freigegeben";
};