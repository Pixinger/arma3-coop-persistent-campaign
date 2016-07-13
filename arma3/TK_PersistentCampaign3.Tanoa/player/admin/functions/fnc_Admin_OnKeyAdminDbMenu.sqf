if (call fnc_Admin_IsPlayerAdmin) then {
	// [Text, Enabled, Visible, SQF-Datei, call(true/spawn(false)]
	private["_buttons"];	
	_buttons = [		
		["AIZ Database Save", true, true, fnc_aiz_DatabaseSaveClient],
		["AIZ Database Clear", true, true, fnc_aiz_DatabaseClearClient],
		["TOWN Database Save", true, true, fnc_town_DatabaseSaveClient],
		["TOWN Database Clear", true, true, fnc_aiz_DatabaseClearClient],
		["LOG Database Save", true, true, fnc_logisticDb_SaveClient],
		["LOG Database Clear", true, true, fnc_logisticDb_ClearClient]
	];

	[_buttons, "Administrator DB Menü"] execVM "maindialog_showtemplate.sqf";
};