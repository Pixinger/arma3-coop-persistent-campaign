private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK"; 	

private["_compositions"];
_compositions = [ 	
	["Gruppenführer", ["G_Combat","H_HelmetB_plain_blk","U_B_CombatUniform_mcam_vest","V_PlateCarrierGL_rgr","keep"]],
	["Soldat 1", ["G_Sport_Red","H_HelmetB_plain_blk","U_B_CombatUniform_mcam_vest","V_PlateCarrierGL_rgr","keep"]],
	["Soldat 2", ["G_Sport_Greenblack","H_HelmetB_plain_blk","U_B_CombatUniform_mcam_vest","V_PlateCarrierGL_rgr","keep"]],
	["Soldat 3", ["G_Sport_BlackWhite","H_HelmetB_plain_blk","U_B_CombatUniform_mcam_vest","V_PlateCarrierGL_rgr","keep"]],
	["Sniper 1", ["G_Sport_Red","H_HelmetSpecB","U_B_GhillieSuit","V_TacVest_camo","keep"]],
	["Sniper 2", ["G_Sport_Greenblack","H_HelmetSpecB","U_B_GhillieSuit","V_TacVest_camo","keep"]],
	["Sniper 3", ["G_Sport_BlackWhite","H_HelmetSpecB","U_B_GhillieSuit","V_TacVest_camo","keep"]],
	["Helipilot", ["G_Shades_Black","H_PilotHelmetHeli_B","U_B_HeliPilotCoveralls","",""]],
	["Pilot", ["G_Shades_Black","H_PilotHelmetFighter_B","U_B_PilotCoveralls","",""]],
	["Spielleiter", ["G_Tactical_Clear","H_Cap_headphones","U_Competitor","V_Rangemaster_belt",""]],
	["Taucher", ["G_Diving","","U_B_Wetsuit","V_RebreatherB","keep"]]
];

private["_loadouts"];
_loadouts = [
	/*AAF*/
	["AAF Teamleader","AAF_Teamleader.sqf"],
	["AAF Autorifleman","AAF_Autorifleman.sqf"],
	["AAF Belt_Autorifleman","AAF_Belt_Autorifleman.sqf"],
	["AAF Engineer","AAF_Engineer.sqf"],
	["AAF Medic","AAF_Medic.sqf"],
	["AAF PCML","AAF_PCML.sqf"],
	["AAF Sniper","AAF_Sniper.sqf"],
	["AAF Support","AAF_Support.sqf"],
	["AAF Titan","AAF_Titan.sqf"],
	["AAF TitanAA","AAF_TitanAA.sqf"],
	/*UK*/
	["UK Teamleader","UK_Teamleader.sqf"],
	["UK Autorifleman","UK_Autorifleman.sqf"],
	["UK Belt_Autorifleman","UK_Belt_Autorifleman.sqf"],
	["UK Engineer","UK_Engineer.sqf"],
	["UK Medic","UK_Medic.sqf"],
	["UK PCML","UK_PCML.sqf"],
	["UK Sniper","UK_Sniper.sqf"],
	["UK Support","UK_Support.sqf"],
	["UK Titan","UK_Titan.sqf"],
	["UK TitanAA","UK_TitanAA.sqf"],
	/*US*/
	["US Teamleader","US_Teamleader.sqf"],
	["US Autorifleman","US_Autorifleman.sqf"],
	["US Belt_Autorifleman","US_Belt_Autorifleman.sqf"],
	["US Engineer","US_Engineer.sqf"],
	["US Medic","US_Medic.sqf"],
	["US PCML","US_PCML.sqf"],
	["US Sniper","US_Sniper.sqf"],
	["US Support","US_Support.sqf"],
	["US Titan","US_Titan.sqf"],
	["US TitanAA","US_TitanAA.sqf"]
];

/*-----------------------------------------------------------------		*/
/* Listbox füllen*/
{
	lbAdd [PIXLOGISTIC_IDC_DIALOG_BARRACK_List, (_x select 0)];
} foreach _loadouts;
lbSetCurSel [PIXLOGISTIC_IDC_DIALOG_BARRACK_List, 0];

/*-----------------------------------------------------------------	*/
/* Dialog anzeigen*/
pixLogisticDialogBarrack_ButtonOK = 0;
pixLogisticDialogBarrack_Selection = -1;
waitUntil { !dialog };

/*-----------------------------------------------------------------	*/
/* Wenn OK geklickt wurde, die Eingaben verarbeiten*/
if (pixLogisticDialogBarrack_ButtonOK == 1) then
{		
	private["_scriptFilename"];
	_scriptFilename = (_loadouts select pixLogisticDialogBarrack_Selection) select 1;

	/* LoadOut zuweisen */
	private["_result"];
	_result = player call compile preprocessFileLineNumbers format["pixLogistic\dialogBarracks\loadouts\%1", _scriptFilename];

	/* Kamerafahrt */
/*	titleCut ["","BLACK IN",1];
	_camera = "camera" camcreate [((getPos player) select 0) + 3,((getPos player) select 1) + 3,((getPos player) select 2) + 2];
	_camera cameraeffect ["internal", "back"];
	_camera camPrepareTarget player;
	_camera camPreparePos [((getPos player) select 0) + 3,((getPos player) select 1) + 3,((getPos player) select 2) + 2];
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 0;		
	_camera camsettarget [(getPos player) select 0, (getPos player) select 1, ((getPos player) select 2) + 1];
	_camera camsetrelpos [0,5,1];
	_camera camcommit 0;
	Sleep 1;
	_camera camsetrelpos [5,0,1];
	_camera camcommit 2;
	waitUntil { camCommitted _camera };
	_camera camsetrelpos [0,-5,1];
	_camera camcommit 2;
	waitUntil { camCommitted _camera };
	_camera camsetrelpos [-5,0,1];
	_camera camcommit 2;
	waitUntil { camCommitted _camera };
	_camera camsetrelpos [0,5,1];
	_camera camcommit 2;
	waitUntil { camCommitted _camera };
	Sleep 1;
	player cameraEffect ["terminate","back"];
	camDestroy _camera;*/
};
pixLogisticDialogBarrack_Selection = nil;