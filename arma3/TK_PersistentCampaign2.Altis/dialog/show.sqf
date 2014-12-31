//if (player == vehicle player) then
//{
	// [Text, Enabled, Visible, SQF-Datei]
	private["_buttons"];
	
		_buttons = [		
		call compile preprocessFileLineNumbers "dialog\scripts\searchBuildingButton.sqf", //center1
		call compile preprocessFileLineNumbers "dialog\scripts\supplyUnloadWaterButton.sqf", //center2
		call compile preprocessFileLineNumbers "dialog\scripts\supplyUnloadFoodButton.sqf", //center3
		call compile preprocessFileLineNumbers "dialog\scripts\supplyLoadAllButton.sqf", //center4
		call compile preprocessFileLineNumbers "dialog\scripts\arrestButton.sqf", //center5
		call compile preprocessFileLineNumbers "dialog\scripts\injuredButton.sqf", //center6
		call compile preprocessFileLineNumbers "dialog\scripts\talkCivilianButton.sqf", //right1
		call compile preprocessFileLineNumbers "dialog\scripts\supplyMedicButton.sqf", //right2
		call compile preprocessFileLineNumbers "dialog\scripts\sendAwayButton.sqf", //right3
		["0", true, false, ""], //right4
		["1", true, false, ""], //right5
		["Teleportieren", true, true, "admin\beam.sqf"], //left1
		call compile preprocessFileLineNumbers "dialog\scripts\groupJoinLeaveButton.sqf", //left2
		call compile preprocessFileLineNumbers "dialog\scripts\groupLeadButton.sqf", //left3
		call compile preprocessFileLineNumbers "dialog\scripts\hideBodyButton.sqf", //left4
		call compile preprocessFileLineNumbers "dialog\scripts\weaponConfiscateButton.sqf", //left5
		["7", true, false, ""], //footer1
		["8", true, false, ""], //footer2
		["9", true, false, ""], //footer3
		["0", true, false, ""], //footer4
		["1", true, false, ""], //footer5
		call compile preprocessFileLineNumbers "dialog\scripts\adminTownsSaveButton.sqf", //header1
		call compile preprocessFileLineNumbers "dialog\scripts\adminVehiclesSaveButton.sqf", //header2
		call compile preprocessFileLineNumbers "dialog\scripts\adminVehiclesAddButton.sqf", //header3
		call compile preprocessFileLineNumbers "dialog\scripts\adminVehiclesRemoveButton.sqf", //header4
		call compile preprocessFileLineNumbers "dialog\scripts\adminGpsButton.sqf"]; //header5

	_buttons execVM "dialog\showbase.sqf";
//};