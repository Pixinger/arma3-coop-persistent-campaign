#include "macro.sqf"
/*
	@version: 2.0
	@file_name: fn_onRespawn.sqf
	@file_author: TAW_Tonic
	@file_edit: 9/24/2013
*/
VAS_slot = lbCurSel VAS_load_list;
if(VAS_slot == -1) exitWith {hint localize "STR_VAS_Prompt_onRespawnFail"};

if(isNil "VAS_Respawn_Handler") then
{
	VAS_Respawn_Handler = player addEventHandler ["Respawn", {[VAS_slot] spawn VAS_fnc_loadGear;}];
};