private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK"; 	

private["_compositions"];
_compositions = [ 	
	["Soldat", ["G_Shades_Black","H_HelmetB_plain_blk","U_B_CombatUniform_mcam_vest","V_PlateCarrierGL_rgr","keep"]],
	["Sniper", ["G_Shades_Black","H_HelmetSpecB","U_B_GhillieSuit","V_TacVest_camo","keep"]],
	["Helipilot", ["G_Shades_Black","H_PilotHelmetHeli_B","U_B_HeliPilotCoveralls","",""]],
	["Pilot", ["G_Shades_Black","H_PilotHelmetFighter_B","U_B_PilotCoveralls","",""]],
	["Spielleiter", ["G_Shades_Black","H_MilCap_blue","U_C_Novak","V_TacVest_blk","keep"]],
	["Taucher", ["G_Diving","","U_B_Wetsuit","V_RebreatherB","keep"]]
];

/*-----------------------------------------------------------------		*/
/* Listbox füllen*/
{
	lbAdd [PIXLOGISTIC_IDC_DIALOG_BARRACK_List, (_x select 0)];
} foreach _compositions;
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
	private["_composition"];
	_composition = (_compositions select pixLogisticDialogBarrack_Selection) select 1;
	
	private["_goggles"];
	_goggles =  _composition select 0;
	private["_headgear"];
	_headgear = _composition select 1;
	private["_uniform"];
	_uniform = _composition select 2;
	private["_vest"];
	_vest = _composition select 3;
	private["_backpack"];
	_backpack = _composition select 4;
	
	if (_goggles != "keep") then
	{
		removeGoggles player;
		if (_goggles != "") then
		{
			player addGoggles _goggles;
		};
	};
	if (_headgear != "keep") then
	{
		removeHeadgear player;
		if (_headgear != "") then
		{
			player addHeadgear _headgear;
		};
	};
	if (_uniform != "keep") then
	{
		removeUniform player;
		if (_uniform != "") then
		{
			player addUniform _uniform;
		};
	};
	if (_vest != "keep") then
	{
		removeVest player;
		if (_vest != "") then
		{
			player addVest _vest;
		};
	};
	if (_backpack != "keep") then
	{
		removeBackpack player;
		if (_backpack != "") then
		{
			player addBackpack _backpack;
		};
	};
	
	titleCut ["","BLACK IN",1];
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
	camDestroy _camera;
};
pixLogisticDialogBarrack_Selection = nil;