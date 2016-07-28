if (call fnc_Admin_IsPlayerAdmin) then {
	// [Text, Enabled, Visible, SQF-Datei, call(true/spawn(false)]
	private["_buttons"];	
	_buttons = [		
		["GPS (toggle)", true, true, fnc_Admin_GpsToggle],
		["Mark Camps", true, true, fnc_aiz_MarkCamps],
		["Teleport (admin)", true, true, fnc_Admin_TeleportAdmin],
		["Teleport (cursor target)", true, true, fnc_Admin_TeleportCursorTarget],
		["Teleport (toggle player)", true, true, fnc_Admin_TeleportToggle],
		["Zeus Object Remove", true, true, fnc_Admin_ZeusObjectRemove],
		["Zeus Object Refresh", true, true, fnc_Admin_ZeusObjectRefresh],
		["CursorTarget DELETE", true, true, fnc_Admin_DeleteCursorTarget],
		["CursorTarget CLEAR-CARGO", true, true, fnc_Admin_ClearCargoCursorTarget]
	];

	[_buttons, "Administrator Menü"] execVM "maindialog_showtemplate.sqf";
};