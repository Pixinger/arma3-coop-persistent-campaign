#define BUTTON_LIMIT 	5

private["_buttons"];	
_buttons = [];

if (call fnc_Logistic_StoreIsNear) then {
	_buttons pushBack ["Store", true, true, fnc_Logistic_StoreShowDialog];
};

if (call fnc_Admin_IsPlayerAdmin) then {
	_buttons pushBack ["Admin", true, true, fnc_Admin_OnKeyAdminMenu];
};


// Zusammengestellte Buttons anzeigen oder ausführen wenn es nur einer ist.
if (count _buttons == 1) then {
	call ((_buttons select 0) select 3);
} else {
	[_buttons, "Logistik Menü"] execVM "maindialog_showtemplate.sqf";
};