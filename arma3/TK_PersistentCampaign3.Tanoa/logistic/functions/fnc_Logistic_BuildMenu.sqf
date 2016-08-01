private["_buttons"];	
_buttons = [];

private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

if (player getVariable ["isPioneer", false]) then 
{
	
	_buttons pushBack [localize "str_pc3_CreateObject", true, true, fnc_Logistic_BuildSubMenu];
	_buttons pushBack [localize "str_pc3_BuildHigher", true, true, fnc_Logistic_BuildUpDown, [_cursorTarget, 1], false];
	_buttons pushBack [localize "str_pc3_BuildLower", true, true, fnc_Logistic_BuildUpDown, [_cursorTarget, -1], false];
	if (_cursorTargetType in logisticBuildables) then {
		_buttons pushBack [localize "str_pc3_DeleteObject", true, true, fnc_Logistic_BuildDelete];
	};
	
	if (!(surfaceIsWater position player) && (!isOnRoad player)) then {
		_buttons pushBack [localize "str_pc3_CreateSandpit", true, true, fnc_Logistic_BuildSandPit, [], false];
	};
};

[_buttons, localize "str_pc3_BuildingMenu"] execVM "maindialog_showtemplate.sqf";
