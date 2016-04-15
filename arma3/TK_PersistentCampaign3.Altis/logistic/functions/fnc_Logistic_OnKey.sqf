#define BUTTON_LIMIT 	5

private["_buttons"];	
_buttons = [];

private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

if (call fnc_Logistic_StoreIsNear) then {
	_buttons pushBack ["Store", true, true, fnc_Logistic_StoreShowDialog];
};

if (call fnc_Admin_IsPlayerAdmin) then {
	_buttons pushBack ["Admin", true, true, fnc_Admin_OnKeyAdminMenu];
};

if (_cursorTargetType in logisticObjectsTransportable) then {
	if (_cursorTarget distance player < 10) then {
		_buttons pushBack ["Aufladen", true, true, fnc_Logistic_Object_Load];
	};
};
if (_cursorTargetType in logisticTransporters) then {
	if (_cursorTarget distance player < 10) then {
		_buttons pushBack ["Entladen", true, true, fnc_Logistic_Object_UnloadDialog];
	};
};

if (_cursorTargetType in logisticObjectsMoveable) then {
	if (_cursorTarget distance player < 10) then {
		_buttons pushBack ["Bewegen", true, true, fnc_Logistic_Object_Move];
	};
};

if (_cursorTargetType in logisticObjectsTransformable) then {
	if (_cursorTarget distance player < 10) then {
		_buttons pushBack ["Transformieren", true, true, fnc_Logistic_Object_Transform];
	};
};




// Zusammengestellte Buttons anzeigen oder ausführen wenn es nur einer ist.
if (count _buttons == 1) then {
	call ((_buttons select 0) select 3);
} else {
	[_buttons, "Logistik Menü"] execVM "maindialog_showtemplate.sqf";
};