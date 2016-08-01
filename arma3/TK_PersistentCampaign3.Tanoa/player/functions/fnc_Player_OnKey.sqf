// [Text, Enabled, Visible, SQF-Datei]
private["_buttons"];	
_buttons = [		
	[localize "str_pc3_Administrator", call fnc_Admin_IsPlayerAdmin, call fnc_Admin_IsPlayerAdmin, fnc_Admin_OnKeyAdminMenu],
	[localize "str_pc3_AdministratorDB", call fnc_Admin_IsPlayerAdmin, call fnc_Admin_IsPlayerAdmin, fnc_Admin_OnKeyAdminDbMenu],
	[localize "str_pc3_Teleport", adminPlayerTeleport, true, fnc_Player_Teleport]
];

[_buttons, localize "str_pc3_PlayerMenu"] execVM "maindialog_showtemplate.sqf";