#include "defines.hpp";

private["_idcs"];
_idcs = [IDC_MAINDIALOG_BUTTONCENTER1,
	IDC_MAINDIALOG_BUTTONCENTER2,
	IDC_MAINDIALOG_BUTTONCENTER3,
	IDC_MAINDIALOG_BUTTONCENTER4,
	IDC_MAINDIALOG_BUTTONCENTER5,
	IDC_MAINDIALOG_BUTTONCENTER6,
	IDC_MAINDIALOG_BUTTONRIGHT1,
	IDC_MAINDIALOG_BUTTONRIGHT2,
	IDC_MAINDIALOG_BUTTONRIGHT3,
	IDC_MAINDIALOG_BUTTONRIGHT4,
	IDC_MAINDIALOG_BUTTONRIGHT5,
	IDC_MAINDIALOG_BUTTONLEFT1,
	IDC_MAINDIALOG_BUTTONLEFT2,
	IDC_MAINDIALOG_BUTTONLEFT3,
	IDC_MAINDIALOG_BUTTONLEFT4,
	IDC_MAINDIALOG_BUTTONLEFT5,
	IDC_MAINDIALOG_BUTTONFOOTER1,
	IDC_MAINDIALOG_BUTTONFOOTER2,
	IDC_MAINDIALOG_BUTTONFOOTER3,
	IDC_MAINDIALOG_BUTTONFOOTER4,
	IDC_MAINDIALOG_BUTTONFOOTER5,
	IDC_MAINDIALOG_BUTTONHEADER1,
	IDC_MAINDIALOG_BUTTONHEADER2,
	IDC_MAINDIALOG_BUTTONHEADER3,
	IDC_MAINDIALOG_BUTTONHEADER4,
	IDC_MAINDIALOG_BUTTONHEADER5];

if (count _this == count _idcs) then
{
	maindialog_action = -1;
	createDialog "MAINDIALOG"; 	
	//disableSerialization;
	//private["_dialogID"];
	//_dialogID = uiNamespace getVariable "MAINDIALOG_ID";
	//private["_displayCtrl"];
	//_displayCtrl = (_dialogID displayCtrl 6194);

	private["_button"];
	private["_i"];
	_i = 0;
	{
		_button = (_this select _i);
		_i = _i + 1;
		ctrlSetText [_x, (_button select 0)];
		ctrlEnable [_x, (_button select 1)];
		ctrlShow [_x, (_button select 2)];	
	} foreach _idcs;

	waitUntil { !dialog };
	
	if (maindialog_action > -1) then
	{
		player sidechat format["%1", maindialog_action];
		_button = (_this select maindialog_action);
		[] execVM (_button select 3);
	};	
	pixDialogActionKeyPressed = false;
}
else
{
	player globalchat "ERROR: dialog\showbase.sqf: count array";
};