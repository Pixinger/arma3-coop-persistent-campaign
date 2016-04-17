private["_buttons"];	
_buttons = [];

private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

if (player getVariable ["isPioneer", false]) then 
{
	_buttons pushBack ["Objekt erstellen", true, true, fnc_Logistic_BuildSubMenu];
	_buttons pushBack ["Höher bauen", true, true, fnc_Logistic_BuildUpDown, [_cursorTarget, 1], false];
	_buttons pushBack ["Tiefer bauen", true, true, fnc_Logistic_BuildUpDown, [_cursorTarget, -1], false];
	if (_cursorTargetType in logisticBuildables) then {
		_buttons pushBack ["Objekt löschen", true, true, fnc_Logistic_BuildDelete];
	};
};

[_buttons, "Baumenü"] execVM "maindialog_showtemplate.sqf";
