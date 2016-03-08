if (call fnc_Admin_IsPlayerAdmin) then {
	// [Text, Enabled, Visible, SQF-Datei, call(true/spawn(false)]
	private["_buttons"];	
	_buttons = [		
		["GPS (toggle)", true, true, fnc_Admin_GpsToggle],
		["Teleport (admin)", true, true, fnc_Admin_TeleportAdmin],
		["Teleport (cursor target)", true, true, fnc_Admin_TeleportCursorTarget],
		["Teleport (toggle player)", true, true, fnc_Admin_TeleportToggle]
	];

	[_buttons, "Administrator Menü"] execVM "maindialog_showtemplate.sqf";
};