#include "defines.hpp"

class PIXLOGISTIC_DIALOG_HQ 
{
	idd = PIXLOGISTIC_IDD_DIALOG_HQ;
	name = "PIXLOGISTIC_DIALOG_HQ";
	movingEnable = false;
	
	objects[] = {};
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_HQ_TitleSoldier,
		PIXLOGISTIC_DIALOG_HQ_TitleAdmin,
		PIXLOGISTIC_DIALOG_HQ_Title, 
	};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_HQ_ButtonSoldier1,
		PIXLOGISTIC_DIALOG_HQ_ButtonSoldier2,
		PIXLOGISTIC_DIALOG_HQ_ButtonSoldier3,
		PIXLOGISTIC_DIALOG_HQ_ButtonSoldier4,
		PIXLOGISTIC_DIALOG_HQ_ButtonSoldier5,
		PIXLOGISTIC_DIALOG_HQ_ButtonSoldier6,
		PIXLOGISTIC_DIALOG_HQ_ButtonAdmin1,
		PIXLOGISTIC_DIALOG_HQ_ButtonAdmin2,
		PIXLOGISTIC_DIALOG_HQ_ButtonAdmin3,
		PIXLOGISTIC_DIALOG_HQ_ButtonAdmin4,
		PIXLOGISTIC_DIALOG_HQ_ButtonAdmin5,
		PIXLOGISTIC_DIALOG_HQ_ButtonAdmin6
	};
		
	class PIXLOGISTIC_DIALOG_HQ_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Logistik HQ";
	};
	class PIXLOGISTIC_DIALOG_HQ_TitleSoldier : RscTitle
	{
		idc = -1;
		text = "Soldaten";
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 0.3 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.0 * GRID_H;
	};
	class PIXLOGISTIC_DIALOG_HQ_TitleAdmin : RscTitle
	{
		idc = -1;
		text = "Administratoren";
		x = 50.1 * GRID_W + GRID_ABS_X; 
		y = 0.3 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.0 * GRID_H;
	};
	
	/* Soldaten Buttons */
	class PIXLOGISTIC_DIALOG_HQ_ButtonSoldier1 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonSoldier1;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 10.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "VirtualAmmoBox";
		action = "execVM 'pixLogistic\dialogHQ\onButtonAmmoBoxClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonSoldier2 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonSoldier2;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 20.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "HQ abbauen";
		action = "execVM 'pixLogistic\dialogHQ\onButtonFoldClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonSoldier3 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonSoldier3;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 30.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "Beamen";
		action = "execVM 'pixLogistic\dialogHQ\onButtonBeamClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonSoldier4 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonSoldier4;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 40.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "Beamen zu HQ";
		action = "execVM 'pixLogistic\dialogHQ\onButtonBeamHQClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonSoldier5 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonSoldier5;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 50.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "Datenbank speichern";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonSaveAllClicked.sqf';";
	};	
	class PIXLOGISTIC_DIALOG_HQ_ButtonSoldier6 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonSoldier6;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 60.3 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "ACRE Funkgerät";
		action = "execVM 'pixLogistic\dialogHQ\onButtonACREClicked.sqf';";
	};	
	
	/* Admin Buttons */
	class PIXLOGISTIC_DIALOG_HQ_ButtonAdmin1 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonAdmin1;
		x = 50.1 * GRID_W + GRID_ABS_X; 
		y = 10.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "Angriff auf Zone starten";
		action = "execVM 'pixLogistic\dialogHQ\onButtonStartZoneClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonAdmin2 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonAdmin2;
		x = 50.1 * GRID_W + GRID_ABS_X; 
		y = 20.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "Fahrzeug anfordern";
		action = "execVM 'pixLogistic\dialogHQ\onButtonRequestVehicleClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonAdmin3 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonAdmin3;
		x = 50.1 * GRID_W + GRID_ABS_X; 
		y = 30.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "Kontainer anfordern";
		action = "execVM 'pixLogistic\dialogHQ\onButtonRequestContainerClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonAdmin4 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonAdmin4;
		x = 50.1 * GRID_W + GRID_ABS_X; 
		y = 40.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "Waffen anfordern";
		action = "execVM 'pixLogistic\dialogHQ\onButtonRequestWeaponClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonAdmin5 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonAdmin5;
		x = 50.1 * GRID_W + GRID_ABS_X; 
		y = 50.1 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.8 * GRID_H;
		text = "---";
		action = "";
	};
	class PIXLOGISTIC_DIALOG_HQ_ButtonAdmin6 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_ButtonAdmin6;
		x = 50.1 * GRID_W + GRID_ABS_X; 
		y = 60.3 * GRID_H + GRID_ABS_Y; 
		w = 49.9 * GRID_W;
		h = 9.9 * GRID_H;
		text = "---";
		action = "";
	};
	

};