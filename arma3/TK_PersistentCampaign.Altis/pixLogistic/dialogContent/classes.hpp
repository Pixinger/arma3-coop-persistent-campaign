#include "defines.hpp"

class PIXLOGISTIC_DIALOG_OBJECTCONTENT 
{
	idd = PIXLOGISTIC_IDD_DIALOG_OBJECTCONTENT;
	name = "PIXLOGISTIC_DIALOG_OBJECTCONTENT";
	movingEnable = false;
	
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_OBJECTCONTENT_Title
	};
	objects[] = {};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_OBJECTCONTENT_Capacity,
		PIXLOGISTIC_DIALOG_OBJECTCONTENT_List,
		
		PIXLOGISTIC_DIALOG_OBJECTCONTENT_ButtonUnload,
		PIXLOGISTIC_DIALOG_OBJECTCONTENT_ButtonMove,
		PIXLOGISTIC_DIALOG_OBJECTCONTENT_ButtonCancel
	};
	
	class PIXLOGISTIC_DIALOG_OBJECTCONTENT_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Laderaum";
	};		
	
	class PIXLOGISTIC_DIALOG_OBJECTCONTENT_Capacity : RscText
	{
		idc = PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_Capacity;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 0.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 9.5 * GRID_H;
		sizeEx = 0.03;
		text = "";
	};
	
	class PIXLOGISTIC_DIALOG_OBJECTCONTENT_List : RscListBox
	{
		idc = PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_List;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 10.5 * GRID_H + GRID_ABS_Y; 
		w = 100 * GRID_W;
		h = 79.5 * GRID_H;
	};
	

	class PIXLOGISTIC_DIALOG_OBJECTCONTENT_ButtonUnload : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_ButtonUnload;
		x = 0 * GRID_W + GRID_ABS_X; 
		y = 90.5 * GRID_H + GRID_ABS_Y; 
		w = 39.5 * GRID_W;
		h = 9.5 * GRID_H;
		sizeEx = 0.02;
		text = "Entladen";
		action = "execVM 'pixLogistic\dialogContent\onButtonOKClicked.sqf';";
	};
	
	class PIXLOGISTIC_DIALOG_OBJECTCONTENT_ButtonMove : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_ButtonMove;
		x = 40.5 * GRID_W + GRID_ABS_X; 
		y = 90.5 * GRID_H + GRID_ABS_Y; 
		w = 29.0 * GRID_W;
		h = 9.5 * GRID_H;
		sizeEx = 0.02;
		text = "Bewegen";
		action = "execVM 'pixLogistic\dialogContent\onButtonMoveClicked.sqf';";
	};
	
	class PIXLOGISTIC_DIALOG_OBJECTCONTENT_ButtonCancel : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_ButtonCancel;
		x = 70.5 * GRID_W + GRID_ABS_X; 
		y = 90.5 * GRID_H + GRID_ABS_Y; 
		w = 29.5 * GRID_W;
		h = 9.5 * GRID_H;
		text = "Abbrechen";
		action = "execVM 'pixLogistic\dialogContent\onButtonCancelClicked.sqf';";
	};
};