// [Text, Enabled, Visible, SQF-Datei]
private["_buttons"];	
_buttons = [		
	call compile preprocessFileLineNumbers "mainmenu\scripts\searchBuildingButton.sqf", //center1
	call compile preprocessFileLineNumbers "mainmenu\scripts\supplyUnloadWaterButton.sqf", //center2
	call compile preprocessFileLineNumbers "mainmenu\scripts\supplyUnloadFoodButton.sqf", //center3
	call compile preprocessFileLineNumbers "mainmenu\scripts\supplyLoadAllButton.sqf", //center4
	call compile preprocessFileLineNumbers "mainmenu\scripts\arrestButton.sqf", //center5
	call compile preprocessFileLineNumbers "mainmenu\scripts\injuredButton.sqf", //center6
	call compile preprocessFileLineNumbers "mainmenu\scripts\talkCivilianButton.sqf", //right1
	call compile preprocessFileLineNumbers "mainmenu\scripts\supplyMedicButton.sqf", //right2
	call compile preprocessFileLineNumbers "mainmenu\scripts\sendAwayButton.sqf", //right3
	["", false, false, ""], //right4
	["", false, false, ""], //right5
	call compile preprocessFileLineNumbers "mainmenu\scripts\groupJoinLeaveButton.sqf", //left1
	call compile preprocessFileLineNumbers "mainmenu\scripts\groupLeadButton.sqf", //left2
	["", false, true, ""], //left3
	call compile preprocessFileLineNumbers "mainmenu\scripts\hideBodyButton.sqf", //left4
	call compile preprocessFileLineNumbers "mainmenu\scripts\weaponConfiscateButton.sqf", //left5
	["", false, false, ""], //footer1
	call compile preprocessFileLineNumbers "mainmenu\scripts\adminGpsButton.sqf", //footer2
	call compile preprocessFileLineNumbers "mainmenu\scripts\hqTeleportButton.sqf", //footer3
	call compile preprocessFileLineNumbers "mainmenu\scripts\adminTeleportButton.sqf", //footer4
	["", false, false, ""], //footer5
	call compile preprocessFileLineNumbers "mainmenu\scripts\adminTownsSaveButton.sqf", //header1
	["", false, false, ""], //header2
	call compile preprocessFileLineNumbers "mainmenu\scripts\adminVehiclesSaveButton.sqf", //header3
	call compile preprocessFileLineNumbers "mainmenu\scripts\adminVehiclesAddButton.sqf", //header4
	call compile preprocessFileLineNumbers "mainmenu\scripts\adminVehiclesRemoveButton.sqf"]; //header5

_buttons execVM "maindialog_showtemplate.sqf";