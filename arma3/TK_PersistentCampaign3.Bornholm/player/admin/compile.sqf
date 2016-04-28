diag_log "compile: player\admin";

fnc_Admin_IsPlayerAdmin = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_IsPlayerAdmin.sqf"; 
fnc_Admin_OnKeyAdminMenu = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_OnKeyAdminMenu.sqf";
fnc_Admin_GpsToggle = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_GpsToggle.sqf";
fnc_Admin_TeleportAdmin = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_TeleportAdmin.sqf";
fnc_Admin_TeleportCursorTarget = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_TeleportCursorTarget.sqf";
fnc_Admin_TeleportToggle = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_TeleportToggle.sqf";