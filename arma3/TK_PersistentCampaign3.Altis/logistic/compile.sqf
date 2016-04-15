diag_log "compile: logistic";

// dialogStore
fnc_Logistic_StoreIsNear = compile preprocessFileLineNumbers "logistic\dialogStore\functions\fnc_Logistic_StoreIsNear.sqf";
fnc_Logistic_StoreShowDialog = compile preprocessFileLineNumbers "logistic\dialogStore\functions\fnc_Logistic_StoreShowDialog.sqf";

// Hauptfunktionen
fnc_Logistic_OnKey = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_OnKey.sqf";
fnc_Logistic_Object_Load = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Load.sqf";
fnc_Logistic_Object_Unload = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Unload.sqf";
fnc_Logistic_Object_UnloadDialog = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_UnloadDialog.sqf";
fnc_Logistic_Object_Move = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Move.sqf";
fnc_Logistic_Object_Transform = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Object_Transform.sqf";

fnc_Logistic_Transporter_GetConfig = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Transporter_GetConfig.sqf";
fnc_Logistic_Transporter_GetEmptySlot = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_Transporter_GetEmptySlot.sqf";


