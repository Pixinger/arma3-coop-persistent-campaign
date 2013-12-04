private["_building"];
_building = _this select 0;

/*-----------------------------------------------------------------	**/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_BARRACK"; 	

private["_loadouts"];
_loadouts = [
	/*AAF*/
/*	["AAF Gruppenführer","AAF_Teamleader.sqf"],
	["AAF Automatikschütze","AAF_Autorifleman.sqf"],
	["AAF Automatikschütze(Gurt)","AAF_Belt_Autorifleman.sqf"],
	["AAF Ingenieur","AAF_Engineer.sqf"],
	["AAF Sanitäter","AAF_Medic.sqf"],
	["AAF PCML","AAF_PCML.sqf"],
	["AAF Scharfschütze","AAF_Sniper.sqf"],
	["AAF Unterstüzung","AAF_Support.sqf"],
	["AAF Titan AT","AAF_Titan.sqf"],
	["AAF Titan AA","AAF_TitanAA.sqf"],*/
	/*UK*/
	["UK Gruppenführer","UK_Teamleader.sqf"],
	["UK Automatikschütze","UK_Autorifleman.sqf"],
	["UK Automatikschütze(Gurt)","UK_Belt_Autorifleman.sqf"],
	["UK Ingenieur","UK_Engineer.sqf"],
	["UK Sanitäter","UK_Medic.sqf"],
	["UK PCML","UK_PCML.sqf"],
	["UK Scharfschütze","UK_Sniper.sqf"],
	["UK Unterstüzung","UK_Support.sqf"],
	["UK Titan AT","UK_Titan.sqf"],
	["UK Titan AA","UK_TitanAA.sqf"],
	/*US*/
	["US Gruppenführer","US_Teamleader.sqf"],
	["US Automatikschütze","US_Autorifleman.sqf"],
	["US Automatikschütze(Gurt)","US_Belt_Autorifleman.sqf"],
	["US Ingenieur","US_Engineer.sqf"],
	["US Sanitäter","US_Medic.sqf"],
	["US PCML","US_PCML.sqf"],
	["US Scharfschütze","US_Sniper.sqf"],
	["US Unterstüzung","US_Support.sqf"],
	["US Titan AT","US_Titan.sqf"],
	["US Titan AA","US_TitanAA.sqf"],
	["Taucher", "Diver.sqf"],
	["Helipilot", "HeliPilot.sqf"],
	["Pilot", "Pilot.sqf"],
	["Kommandeur", "Commander.sqf"]	
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
	_result = [player, _scriptFilename] call compile preprocessFileLineNumbers "pixLogistic\dialogBarracks\applyLoadOut.sqf";

	/* Kamerafahrt */
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
	_camera camcommit 1;
	waitUntil { camCommitted _camera };
	_camera camsetrelpos [0,-5,1];
	_camera camcommit 1;
	waitUntil { camCommitted _camera };
	_camera camsetrelpos [-5,0,1];
	_camera camcommit 1;
	waitUntil { camCommitted _camera };
	_camera camsetrelpos [0,5,1];
	_camera camcommit 1;
	waitUntil { camCommitted _camera };
	Sleep 1;
	player cameraEffect ["terminate","back"];
	camDestroy _camera;
};
pixLogisticDialogBarrack_Selection = nil;