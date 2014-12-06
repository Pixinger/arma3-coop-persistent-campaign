openMap [true, true] ;
instructorBeamUnit = player;
onMapSingleClick "instructorBeamUnit setPos _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; true;";
