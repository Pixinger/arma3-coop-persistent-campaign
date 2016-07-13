if (adminPlayerTeleport) then
{
	openMap [true, true];
	adminTeleportUnit = vehicle player;
	onMapSingleClick "adminTeleportUnit setPos [_pos select 0, _pos select 1, 0]; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; adminTeleportUnit = nil; true;";
}
else
{
	hintC "Das Teleportieren ist nicht freigegeben";
};
