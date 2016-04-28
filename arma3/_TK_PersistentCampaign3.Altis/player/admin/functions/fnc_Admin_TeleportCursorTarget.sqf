openMap [true, true];
adminTeleportUnit = cursorTarget;
onMapSingleClick "adminTeleportUnit setPos _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; adminTeleportUnit = nil; true;";