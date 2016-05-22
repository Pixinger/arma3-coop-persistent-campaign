if (call fnc_Admin_IsPlayerAdmin) then {
	// [Text, Enabled, Visible, SQF-Datei, call(true/spawn(false)]
	private["_buttons"];	
	_buttons = [		
		["GPS (toggle)", true, true, fnc_Admin_GpsToggle],
		["Teleport (admin)", true, true, fnc_Admin_TeleportAdmin],
		["Teleport (cursor target)", true, true, fnc_Admin_TeleportCursorTarget],
		["Teleport (toggle player)", true, true, fnc_Admin_TeleportToggle],
		["AIZ Database Save", true, true, fnc_aiz_DatabaseSaveClient],
		["AIZ Database Clear", true, true, fnc_aiz_DatabaseClearClient]
		//["DAC Zones STOP", true, true, fnc_dacZones_Stop],
		//["Database (load)", true, true, fnc_db_LoadFromDb],
		//["Database (save)", true, true, fnc_db_SaveToDb],
		//["Database (CLEAR)", true, true, fnc_db_ClearDb]
	];

	[_buttons, "Administrator Menü"] execVM "maindialog_showtemplate.sqf";
};