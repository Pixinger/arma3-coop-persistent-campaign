#include "defines.hpp"

class PIXLOGISTIC_DIALOG_ADMIN 
{
	idd = PIXLOGISTIC_IDD_DIALOG_ADMIN;
	name = "PIXLOGISTIC_DIALOG_ADMIN";
	movingEnable = false;
	
	objects[] = {};
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_ADMIN_Title
	};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_ADMIN_Title,		
		PIXLOGISTIC_DIALOG_ADMIN_Button1,
		PIXLOGISTIC_DIALOG_ADMIN_Button2,
		PIXLOGISTIC_DIALOG_ADMIN_Button3,
		PIXLOGISTIC_DIALOG_ADMIN_Button4,
		PIXLOGISTIC_DIALOG_ADMIN_Button5,
		PIXLOGISTIC_DIALOG_ADMIN_Button6,
		PIXLOGISTIC_DIALOG_ADMIN_Button7,
		PIXLOGISTIC_DIALOG_ADMIN_Button8
	};
		
	class PIXLOGISTIC_DIALOG_ADMIN_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Logistik Admin";
	};
	
	class PIXLOGISTIC_DIALOG_ADMIN_Button1 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button1;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 0.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "Fahrzeug anfordern";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonRequestVehicleClicked.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button2 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button2;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 10.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "Container anfordern";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonRequestContainerClicked.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button3 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button3;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 20.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "Waffen anfordern";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonRequestWeaponClicked.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button4 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button4;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 30.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "Objekt entfernen";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonDeleteClicked.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button5 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button5;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 40.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "Datenbank speichern";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonSaveAllClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button6 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button6;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 50.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "ShowClasses";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonShowClassClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button7 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button7;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 60.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "player setCaptive true";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonSetCaptiveClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button8 : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button8;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 70.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		text = "Beam";
		action = "execVM 'pixLogistic\dialogAdmin\onButtonBeamClicked.sqf';";
	};
};