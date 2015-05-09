// [Text, Enabled, Visible, SQF-Datei]
private["_buttons"];	
_buttons = [		
	["Körper durchsuchen", call fnc_Town_SearchBodyCond, false, fnc_Town_SearchBodyScript],
	["Gebäude durchsuchen", call fnc_Town_SearchBuildingCond, false, fnc_Town_SearchBuildingScript],
	["Nahrung entladen", call fnc_Town_SupportFoodCond, false, fnc_Town_SupportFoodScript],
	["Medizinisch versorgen", call fnc_Town_SupportHealInjuredCond, false, fnc_Town_SupportHealInjuredScript],
	["Medizinische Hilfe starten", call fnc_Town_SupportHelpStartCond, false, fnc_Town_SupportHelpStartScript],
	["Medizinische Hilfe beenden", call fnc_Town_SupportHelpStopCond, false, fnc_Town_SupportHelpStopScript],
	["Hilfsgüter aufladen", call fnc_Town_SupportLoadCond, false, fnc_Town_SupportLoadScript],
	["Wasser entladen", call fnc_Town_SupportWaterCond, false, fnc_Town_SupportWaterScript],
	["Bewohner befragen", call fnc_Town_TalkCivilianCond, false, fnc_Town_TalkCivilianScript],
	["Waffen beschlagnahmen", call fnc_Town_WeaponConfiscateCond, false, fnc_Town_WeaponConfiscateScript],
	["Spieler Gewicht/Ausdauer", true, false, fnc_MainMenu_ShowPlayerLoad],
	["Spieler teleportieren", true, false, fnc_MainMenu_TeleportPlayer]
];

[_buttons, "Hauptmenu"] execVM "maindialog_showtemplate.sqf";