openMap [true, true] ;
instructorBeamUnit = vehicle player;
onMapSingleClick "instructorBeamUnit setPos _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; true;";
