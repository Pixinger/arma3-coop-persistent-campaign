#include "defines.hpp"

class PIXLOGISTIC_DIALOG_SERVICE 
{
	idd = PIXLOGISTIC_IDD_DIALOG_SERVICE;
	name = "PIXLOGISTIC_DIALOG_SERVICE";
	movingEnable = false;
	
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_SERVICE_Title,
		PIXLOGISTIC_DIALOG_SERVICE_Background
	};
	objects[] = {};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_SERVICE_SubTitle,
		PIXLOGISTIC_DIALOG_SERVICE_List,
		
		PIXLOGISTIC_DIALOG_SERVICE_ButtonOK,
		PIXLOGISTIC_DIALOG_SERVICE_ButtonCancel,
		PIXLOGISTIC_DIALOG_SERVICE_ButtonFold
	};
	
	class PIXLOGISTIC_DIALOG_SERVICE_Background: IGUIBack
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y;
		w = GRID_ABS_W;
		h = GRID_ABS_H;
	};	
	class PIXLOGISTIC_DIALOG_SERVICE_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Werkstatt";
	};	
	class PIXLOGISTIC_DIALOG_SERVICE_SubTitle : RscText
	{
		idc = PIXLOGISTIC_IDC_DIALOG_SERVICE_SubTitle;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 1 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "Recycling";
		colorbackground[] = 
		{
			0,
			0,
			0,
			1
		};		
	};
	
	class PIXLOGISTIC_DIALOG_SERVICE_List : RscListBox
	{
		idc = PIXLOGISTIC_IDC_DIALOG_SERVICE_List;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 2 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 6 * GRID_H;
	};
	

	class PIXLOGISTIC_DIALOG_SERVICE_ButtonOK : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_SERVICE_ButtonOK;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 3.9 * GRID_W;
		h = 0.9 * GRID_H;
		text = "Recyclen";
		action = "execVM 'pixLogistic\dialogService\onButtonOKClicked.sqf';";
	};
	
	class PIXLOGISTIC_DIALOG_SERVICE_ButtonCancel : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_SERVICE_ButtonCancel;
		x = 5 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 4 * GRID_W;
		h = 0.9 * GRID_H;
		text = "Abbrechen";
		action = "execVM 'pixLogistic\dialogService\onButtonCancelClicked.sqf';";
	};

	class PIXLOGISTIC_DIALOG_SERVICE_ButtonFold : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_SERVICE_ButtonFold;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 9 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 0.9 * GRID_H;
		text = "Abbauen";
		action = "execVM 'pixLogistic\dialogService\onButtonFoldClicked.sqf';";
	};
};