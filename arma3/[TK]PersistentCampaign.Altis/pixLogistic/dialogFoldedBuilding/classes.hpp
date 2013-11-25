#include "defines.hpp"

class PIXLOGISTIC_DIALOG_FOLDEDBUILDING 
{
	idd = PIXLOGISTIC_IDD_DIALOG_FOLDEDBUILDING;
	name = "PIXLOGISTIC_DIALOG_FOLDEDBUILDING";
	movingEnable = false;
	
	objects[] = {};
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_FOLDEDBUILDING_Title, 
		PIXLOGISTIC_DIALOG_FOLDEDBUILDING_Background
	};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_FOLDEDBUILDING_Title,		
		PIXLOGISTIC_DIALOG_FOLDEDBUILDING_Text,		
		PIXLOGISTIC_DIALOG_FOLDEDBUILDING_ButtonUnfold
	};
		
	class PIXLOGISTIC_DIALOG_FOLDEDBUILDING_Background: IGUIBack
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y;
		w = GRID_ABS_W;
		h = GRID_ABS_H;
	};
	
	class PIXLOGISTIC_DIALOG_FOLDEDBUILDING_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Logistik Gebaeude";
	};
	
	class PIXLOGISTIC_DIALOG_FOLDEDBUILDING_Text : RscText
	{
		idc = PIXLOGISTIC_IDC_DIALOG_FOLDEDBUILDING_Text;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 1 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "";
	};

	class PIXLOGISTIC_DIALOG_FOLDEDBUILDING_ButtonUnfold : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_FOLDEDBUILDING_ButtonUnfold;
		x = 1* GRID_W + GRID_ABS_X; 
		y = 2 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "Aufbauen";
		action = "execVM 'pixLogistic\dialogFoldedBuilding\onButtonUnfoldClicked.sqf';";
	};
};