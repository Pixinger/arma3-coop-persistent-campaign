if (hasInterface) then
{
	fnc_Admin_IsPlayerAdmin = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_IsPlayerAdmin.sqf"; 
	fnc_Admin_OnKeyAdminMenu = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_OnKeyAdminMenu.sqf";
	fnc_Admin_OnKeyAdminDbMenu = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_OnKeyAdminDbMenu.sqf";
	fnc_Admin_GpsToggle = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_GpsToggle.sqf";
	fnc_Admin_TeleportAdmin = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_TeleportAdmin.sqf";
	fnc_Admin_TeleportCursorTarget = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_TeleportCursorTarget.sqf";
	fnc_Admin_ClearCargoCursorTarget = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_ClearCargoCursorTarget.sqf";
	fnc_Admin_DeleteCursorTarget = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_DeleteCursorTarget.sqf";
	fnc_Admin_TeleportToggle = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_TeleportToggle.sqf";
};

fnc_Admin_ZeusObjectRefresh = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_ZeusObjectRefresh.sqf";
fnc_Admin_ZeusObjectRemove = compile preprocessFileLineNumbers "player\admin\functions\fnc_Admin_ZeusObjectRemove.sqf";