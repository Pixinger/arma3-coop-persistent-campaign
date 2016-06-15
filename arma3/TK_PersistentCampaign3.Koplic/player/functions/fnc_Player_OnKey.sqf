// [Text, Enabled, Visible, SQF-Datei]
private["_buttons"];	
_buttons = [		
	["Administrator", call fnc_Admin_IsPlayerAdmin, call fnc_Admin_IsPlayerAdmin, fnc_Admin_OnKeyAdminMenu],
	["Administrator DB", call fnc_Admin_IsPlayerAdmin, call fnc_Admin_IsPlayerAdmin, fnc_Admin_OnKeyAdminDbMenu],
	["Teleport", adminPlayerTeleport, true, fnc_Player_Teleport]
];

[_buttons, "Spieler Menü"] execVM "maindialog_showtemplate.sqf";