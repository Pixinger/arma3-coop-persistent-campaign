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
		PIXLOGISTIC_DIALOG_ADMIN_Button8,
		PIXLOGISTIC_DIALOG_ADMIN_Button9,
		PIXLOGISTIC_DIALOG_ADMIN_Button10,
		PIXLOGISTIC_DIALOG_ADMIN_Button11,
		PIXLOGISTIC_DIALOG_ADMIN_Button12,
		PIXLOGISTIC_DIALOG_ADMIN_Button13,
		PIXLOGISTIC_DIALOG_ADMIN_Button14,
		PIXLOGISTIC_DIALOG_ADMIN_Button15,
		PIXLOGISTIC_DIALOG_ADMIN_Button16,
		PIXLOGISTIC_DIALOG_ADMIN_Button17,
		PIXLOGISTIC_DIALOG_ADMIN_Button18,
		PIXLOGISTIC_DIALOG_ADMIN_Button19,
		PIXLOGISTIC_DIALOG_ADMIN_Button20
	};
		
	class RscButtonAdminMenu : RscButtonMenu
	{
		x = 0 * GRID_W + GRID_ABS_X; 
		w = 100 * GRID_W;
		h = 7.5 * GRID_H;
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
	
	class PIXLOGISTIC_DIALOG_ADMIN_Button1 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button1;
		y = 0.5 * GRID_H + GRID_ABS_Y; 
		text = "Zone starten";
		action = "[] execVM 'pixZones\onZoneStart.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button2 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button2;
		y = 8.5 * GRID_H + GRID_ABS_Y; 
		text = "Zone verlieren";
		action = "[] execVM 'pixZones\onZoneLoose.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button3 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button3;
		y = 16.5 * GRID_H + GRID_ABS_Y; 
		text = "Zone gewinnen";
		action = "[] execVM 'pixZones\onZoneWin.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button4 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button4;
		y = 24.5 * GRID_H + GRID_ABS_Y; 
		text = "Datenbank speichern";
		action = "execVM 'admin\onButtonSaveDatabaseClicked.sqf';";
	};

	class PIXLOGISTIC_DIALOG_ADMIN_Button5 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button5;
		y = 32.5 * GRID_H + GRID_ABS_Y; 
		text = "---";
		action = "";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button6 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button6;
		y = 40.5 * GRID_H + GRID_ABS_Y; 
		text = "---";
		action = "";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button7 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button7;
		y = 48.5 * GRID_H + GRID_ABS_Y; 
		text = "player setCaptive true";
		action = "execVM 'admin\onButtonSetCaptiveClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button8 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button8;
		y = 56.5 * GRID_H + GRID_ABS_Y; 
		text = "Beam";
		action = "execVM 'admin\onButtonBeamClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button9 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button9;
		y = 64.5 * GRID_H + GRID_ABS_Y; 
		text = "Show Equipment";
		action = "execVM 'admin\onButtonShowEquipmentClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button10 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button10;
		y = 72.5 * GRID_H + GRID_ABS_Y; 
		text = "Destroy item";
		action = "execVM 'admin\onButtonDestroyItemClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button11 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button11;
		y = 80.5 * GRID_H + GRID_ABS_Y; 
		text = "---";
		action = "";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button12 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button12;
		y = 88.5 * GRID_H + GRID_ABS_Y; 
		text = "---";
		action = "";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button13 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button13;
		y = 96.5 * GRID_H + GRID_ABS_Y; 
		text = "Zone beenden (gewonnen)";
		action = "[1] execVM 'admin\onButtonZoneBeendenClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button14 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button14;
		y = 104.5 * GRID_H + GRID_ABS_Y; 
		text = "Zone beenden (verloren)";
		action = "[2] execVM 'admin\onButtonZoneBeendenClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button15 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button15;
		y = 112.5 * GRID_H + GRID_ABS_Y; 
		text = "Rucksack Funkgerät hinzufügen";
		action = "[] execVM 'admin\onButtonAddBackpackRadioClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button16 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button16;
		y = 120.5 * GRID_H + GRID_ABS_Y; 
		text = "Funkgerät hinzufügen";
		action = "[] execVM 'admin\onButtonAddRadioClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button17 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button17;
		y = 128.5 * GRID_H + GRID_ABS_Y; 
		text = "ZeusFix";
		action = "execVM 'admin\onButtonZeusFix.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button18 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button18;
		y = 136.5 * GRID_H + GRID_ABS_Y; 
		text = "ZeusFix switch attach unit";
		action = "execVM 'admin\onButtonZeusFixAttach.sqf';";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button19 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button19;
		y = 144.5 * GRID_H + GRID_ABS_Y; 
		text = "---";
		action = "";
	};
	class PIXLOGISTIC_DIALOG_ADMIN_Button20 : RscButtonAdminMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_ADMIN_Button20;
		y = 152.5 * GRID_H + GRID_ABS_Y; 
		text = "Zone starten";
		action = "[] execVM 'admin\onButtonZoneStartenClicked.sqf';";
	};
};