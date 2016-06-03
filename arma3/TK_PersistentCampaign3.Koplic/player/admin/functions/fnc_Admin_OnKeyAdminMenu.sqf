if (call fnc_Admin_IsPlayerAdmin) then {
	// [Text, Enabled, Visible, SQF-Datei, call(true/spawn(false)]
	private["_buttons"];	
	_buttons = [		
		["GPS (toggle)", true, true, fnc_Admin_GpsToggle],
		["Teleport (admin)", true, true, fnc_Admin_TeleportAdmin],
		["Teleport (cursor target)", true, true, fnc_Admin_TeleportCursorTarget],
		["Teleport (toggle player)", true, true, fnc_Admin_TeleportToggle],
		["Zeus Fix", true, true, fnc_Admin_ZeusFix],
		["AIZ Database Save", true, true, fnc_aiz_DatabaseSaveClient],
		["AIZ Database Clear", true, true, fnc_aiz_DatabaseClearClient],
		["LOG Database Save", true, true, fnc_logisticDb_SaveClient],
		["LOG Database Clear", true, true, fnc_logisticDb_ClearClient]
	];

	[_buttons, "Administrator Menü"] execVM "maindialog_showtemplate.sqf";
};