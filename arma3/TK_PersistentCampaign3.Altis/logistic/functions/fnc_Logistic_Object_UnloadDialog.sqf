private["_vehicle"];
_vehicle = _this select 0;

private["_buttons"];	
_buttons = [];

{
	_buttons pushBack [typeof _x, true, true, fnc_Logistic_Object_Unload, true, [_x]];	
} foreach (attachedObjects _vehicle);

[_buttons, "Entladen"] execVM "maindialog_showtemplate.sqf";
