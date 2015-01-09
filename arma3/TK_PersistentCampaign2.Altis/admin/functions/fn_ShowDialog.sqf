// [Text, Enabled, Visible, SQF-Datei]
private["_buttons"];	
_buttons = [		
	["GPS umschalten", true, true, fnc_Admin_GpsScript],
	["Teleportieren", true, true, fnc_Admin_TeleportScript],
	["Rallypoint versetzen", call fnc_Admin_RallyTeleportCond, false, fnc_Admin_RallyTeleportScript],
	["Fahrzeug hinzufügen", true, true, fnc_Admin_VehicleAddScript],
	["Fahrzeug entfernen", true, true, fnc_Admin_VehicleRemoveScript],
	["Fahrzeuge speichern", true, true, fnc_Admin_VehiclesSaveScript],
	["Städte speichern", true, true, fnc_Admin_TownsSaveScript]
];

[_buttons, "Administrator"] execVM "maindialog_showtemplate.sqf";