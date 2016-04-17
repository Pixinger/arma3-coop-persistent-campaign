diag_log "compile: logistic";

// Hauptfunktionen
fnc_Logistic_OnKey = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_OnKey.sqf";
fnc_Logistic_Object_Load = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Load.sqf";
fnc_Logistic_Object_Unload = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Unload.sqf";
fnc_Logistic_Object_Move = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Move.sqf";
fnc_Logistic_Object_Transform = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Transform.sqf";

// Build
fnc_Logistic_CanBuild = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_CanBuild.sqf";
fnc_Logistic_Build = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Build.sqf";
fnc_Logistic_BuildUpDown = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildUpDown.sqf";
fnc_Logistic_BuildDelete = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildDelete.sqf";
fnc_Logistic_BuildMenu = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildMenu.sqf";
fnc_Logistic_BuildSubMenu = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_BuildSubMenu.sqf";
