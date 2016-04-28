private["_buttons"];	
_buttons = [];

private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;
hint format["%1", _cursorTargetType];

{
	private["_config"];
	_config = [_x] call fnc_Logistic_CanBuild;
	
	if (count _config > 0) then {
		_buttons pushBack [gettext(configFile >> "CfgVehicles" >> _x >> "displayName"), true, true, fnc_Logistic_Build, [_x], false];
	};
	
} foreach logisticBuildables;

[_buttons, "Baumenü"] execVM "maindialog_showtemplate.sqf";
