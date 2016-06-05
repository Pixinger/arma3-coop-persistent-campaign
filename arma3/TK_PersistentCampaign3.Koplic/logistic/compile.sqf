call compile preprocessFileLineNumbers ("logistic\db\compile.sqf");
call compile preprocessFileLineNumbers ("logistic\gear\compile.sqf");
diag_log "INFO: compile: logistic";

// Hauptfunktionen
fnc_Logistic_OnKey = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_OnKey.sqf";
fnc_Logistic_Object_Load = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Load.sqf";
fnc_Logistic_Object_Unload = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Unload.sqf";
fnc_Logistic_Object_Move = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Move.sqf";
fnc_Logistic_WorkAnimation = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_WorkAnimation.sqf";

fnc_Logistic_HQClose = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_HQClose.sqf";
fnc_Logistic_HQOpen = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_HQOpen.sqf";
fnc_Logistic_HQIsOpen = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_HQIsOpen.sqf";

fnc_Logistic_Hauler_Load = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Hauler_Load.sqf";
fnc_Logistic_Hauler_Unload = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Hauler_Unload.sqf";

// Build
fnc_Logistic_CanBuild = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_CanBuild.sqf";
fnc_Logistic_Build = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Build.sqf";
fnc_Logistic_BuildUpDown = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildUpDown.sqf";
fnc_Logistic_BuildDelete = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildDelete.sqf";
fnc_Logistic_BuildMenu = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildMenu.sqf";
fnc_Logistic_BuildSubMenu = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildSubMenu.sqf";
fnc_Logistic_BuildSandPit = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildSandPit.sqf";