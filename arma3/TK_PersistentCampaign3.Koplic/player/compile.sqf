diag_log "INFO: compile: player";

call compile preprocessFileLineNumbers "player\admin\compile.sqf";
call compile preprocessFileLineNumbers "player\barracks\compile.sqf";

fnc_Player_OnKey = compile preprocessFileLineNumbers "player\functions\fnc_Player_OnKey.sqf";
fnc_Player_Teleport = compile preprocessFileLineNumbers "player\functions\fnc_Player_Teleport.sqf";
