diag_log "compile: logistic";

// dialogStore
fnc_Logistic_StoreIsNear = compile preprocessFileLineNumbers "logistic\dialogStore\functions\fnc_Logistic_StoreIsNear.sqf";
fnc_Logistic_StoreShowDialog = compile preprocessFileLineNumbers "logistic\dialogStore\functions\fnc_Logistic_StoreShowDialog.sqf";

// Hauptfunktionen
fnc_Logistic_OnKey = compile preprocessFileLineNumbers "logistic\functions\fnc_Logistic_OnKey.sqf";
