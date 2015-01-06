call compile preprocessFileLineNumbers "admin\config.sqf";
call compile preprocessFileLineNumbers "admin\functions\_compile.sqf";

if (isServer) then
{
	if (call fnc_Admin_IsPlayerAdmin) then 
	{
		["Administrator", {true}, {call fnc_Admin_ShowDialog}, false] call AGM_Interaction_fnc_addInteractionSelf;
	};
};
