call compile preprocessFileLineNumbers "mainmenu\config.sqf";
call compile preprocessFileLineNumbers "mainmenu\functions\_compile.sqf";

[] spawn {
	if (!isServer || !isDedicated) then
	{
		waitUntil { !isNull player };
		["Persistent Campaign", {true}, {call fnc_MainMenu_ShowDialog}, false] call AGM_Interaction_fnc_addInteractionSelf;
	};
};