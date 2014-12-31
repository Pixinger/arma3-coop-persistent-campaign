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
		["", false, false, ""], //right4
		["", false, false, ""], //right5
		call compile preprocessFileLineNumbers "dialog\scripts\groupJoinLeaveButton.sqf", //left1
		call compile preprocessFileLineNumbers "dialog\scripts\groupLeadButton.sqf", //left2
		["", false, true, ""], //left3
		call compile preprocessFileLineNumbers "dialog\scripts\hideBodyButton.sqf", //left4
		call compile preprocessFileLineNumbers "dialog\scripts\weaponConfiscateButton.sqf", //left5
		["", false, false, ""], //footer1
		call compile preprocessFileLineNumbers "dialog\scripts\adminGpsButton.sqf", //footer2
		call compile preprocessFileLineNumbers "dialog\scripts\hqTeleportButton.sqf", //footer3
		call compile preprocessFileLineNumbers "dialog\scripts\adminTeleportButton.sqf", //footer4
		["", false, false, ""], //footer5
		call compile preprocessFileLineNumbers "dialog\scripts\adminTownsSaveButton.sqf", //header1
		["", false, false, ""], //header2
		call compile preprocessFileLineNumbers "dialog\scripts\adminVehiclesSaveButton.sqf", //header3
		call compile preprocessFileLineNumbers "dialog\scripts\adminVehiclesAddButton.sqf", //header4
		call compile preprocessFileLineNumbers "dialog\scripts\adminVehiclesRemoveButton.sqf"]; //header5

	_buttons execVM "dialog\showbase.sqf";
//};