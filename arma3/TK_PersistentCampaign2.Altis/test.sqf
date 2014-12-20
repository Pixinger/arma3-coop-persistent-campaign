//[civ1, civ2] doFSM ["civilian.fsm", getPos player, getPos player]

//_jeep = "Land_WaterTank_F" createVehicle position player;
/*
call compile preprocessFileLineNumbers "town\config.sqf";
_jeep = pixTown_ConfigWaterClassname createVehicle position player;
_jeep setVariable["content", 2];
_jeep = pixTown_ConfigFoodClassname createVehicle position player;
_jeep setVariable["content", 2];

_jeep = "B_Truck_01_medical_F" createVehicle position player;
_jeep setVariable["active", true];

*/


//[] execVM "dialog\show.sqf";


z1 doFsm ["test.fsm", getPos player, player];
