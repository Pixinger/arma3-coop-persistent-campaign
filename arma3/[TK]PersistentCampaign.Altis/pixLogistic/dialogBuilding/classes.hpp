#include "defines.hpp"

class PIXLOGISTIC_DIALOG_BUILDING 
{
	idd = PIXLOGISTIC_IDD_DIALOG_BUILDING;
	name = "PIXLOGISTIC_DIALOG_BUILDING";
	movingEnable = false;
	
	objects[] = {};
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_BUILDING_Title, 
		PIXLOGISTIC_DIALOG_BUILDING_Background
	};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_BUILDING_Title,		
		PIXLOGISTIC_DIALOG_BUILDING_ButtonFold
	};
		
	class PIXLOGISTIC_DIALOG_BUILDING_Background: IGUIBack
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y;
		w = GRID_ABS_W;
		h = GRID_ABS_H;
	};
	
	class PIXLOGISTIC_DIALOG_BUILDING_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Logistik Gebaeude";
	};
	
	class PIXLOGISTIC_DIALOG_BUILDING_ButtonFold : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_BUILDING_ButtonFold;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 1 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "Abbauen";
		action = "execVM 'pixLogistic\dialogBuilding\onButtonFoldClicked.sqf';";
	};
};