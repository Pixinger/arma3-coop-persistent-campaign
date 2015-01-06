#include "maindialog_defines.hpp";

private["_idcs"];
_idcs = [
	IDC_MAINMENU_BUTTON1,
	IDC_MAINMENU_BUTTON2,
	IDC_MAINMENU_BUTTON3,
	IDC_MAINMENU_BUTTON4,
	IDC_MAINMENU_BUTTON5,
	IDC_MAINMENU_BUTTON6,
	IDC_MAINMENU_BUTTON7,
	IDC_MAINMENU_BUTTON8,
	IDC_MAINMENU_BUTTON9,
	IDC_MAINMENU_BUTTON10,
	IDC_MAINMENU_BUTTON11];
	
private["_buttons"];
_buttons = _this select 0;
private["_name"];
_name = _this select 1;

if (count _buttons > 0) then
{
	maindialog_action = -1;
	createDialog "MAINDIALOG"; 	

	ctrlSetText [IDC_MAINMENU_TEXTNAME, _name];

	// Alle Tasten ausblenden
	{ ctrlShow [_x, false]; } foreach _idcs;

	// Skripte vorbereiten
	private["_scripts"];
	_scripts = [];
	
	private["_i"];
	_i = 0;
	{
		if ((_x select 2) || {(_x select 1)}) then
		{
			if (_i < 11) then
			{
				private["_idc"];
				_idc = _idcs select _i;
				_i = _i + 1;
				
				ctrlSetText [_idc, (_x select 0)];
				ctrlEnable [_idc, (_x select 1)];
				ctrlShow [_idc, true];
				
				_scripts pushBack (_x select 3);
			};
		};
	} foreach _buttons;

	waitUntil { !dialog };
	
	if (maindialog_action > -1) then
	{
		player sidechat format["%1", maindialog_action];
		call (_scripts select maindialog_action);
	};	
};