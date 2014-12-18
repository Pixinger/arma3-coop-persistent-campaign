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

private["_buttons"];
_buttons = [		
["1", true, true, "1"], //center1
["2", true, true, "2"], //center2
["3", true, true, ""], //center3
["4", true, true, ""], //center4
["5", true, true, ""], //center5
["6", true, true, ""], //center6
["7", true, true, ""], //right1
["8", true, true, ""], //right2
["9", true, true, ""], //right3
["0", true, true, ""], //right4
["1", true, true, ""], //right5
["2", true, true, ""], //left1
["3", true, true, ""], //left2
["4", true, true, ""], //left3
["5", true, true, ""], //left4
["6", true, true, ""], //left5
["7", true, true, ""], //footer1
["8", true, true, ""], //footer2
["9", true, true, ""], //footer3
["0", true, true, ""], //footer4
["1", true, true, ""], //footer5
["2", true, true, ""], //header1
["3", true, true, ""], //header2
["4", true, true, ""], //header3
["5", true, true, ""], //header4
["6", true, true, ""]]; //header5

_buttons execVM "dialog\showbase.sqf";