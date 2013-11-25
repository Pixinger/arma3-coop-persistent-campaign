#include "defines.hpp"

class PIXLOGISTIC_DIALOG_BARRACK 
{
	idd = PIXLOGISTIC_IDD_DIALOG_BARRACK;
	name = "PIXLOGISTIC_DIALOG_BARRACK";
	movingEnable = false;
	
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_BARRACK_Title,
		PIXLOGISTIC_DIALOG_BARRACK_Background
	};
	objects[] = {};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_BARRACK_SubTitle,
		PIXLOGISTIC_DIALOG_BARRACK_List,
		
		PIXLOGISTIC_DIALOG_BARRACK_ButtonOK,
		PIXLOGISTIC_DIALOG_BARRACK_ButtonCancel
	};
	
	class PIXLOGISTIC_DIALOG_BARRACK_Background: IGUIBack
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y;
		w = GRID_ABS_W;
		h = GRID_ABS_H;
	};	
	class PIXLOGISTIC_DIALOG_BARRACK_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Baracken";
	};	
	class PIXLOGISTIC_DIALOG_BARRACK_SubTitle : RscText
	{
		idc = PIXLOGISTIC_IDC_DIALOG_BARRACK_SubTitle;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 1 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "Uniform";
		colorbackground[] = 
		{
			0,
			0,
			0,
			1
		};		
	};
	
	class PIXLOGISTIC_DIALOG_BARRACK_List : RscListBox
	{
		idc = PIXLOGISTIC_IDC_DIALOG_BARRACK_List;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 2 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 6 * GRID_H;
	};
	

	class PIXLOGISTIC_DIALOG_BARRACK_ButtonOK : RscButtonMenuOK
	{
		idc = PIXLOGISTIC_IDC_DIALOG_BARRACK_ButtonOK;
		x = 5 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 4 * GRID_W;
		h = 1 * GRID_H;
		text = "Wechseln";
		action = "execVM 'pixLogistic\dialogBarracks\onButtonOKClicked.sqf';";
	};
	
	class PIXLOGISTIC_DIALOG_BARRACK_ButtonCancel : RscButtonMenuCancel
	{
		idc = PIXLOGISTIC_IDC_DIALOG_BARRACK_ButtonCancel;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 4 * GRID_W;
		h = 1 * GRID_H;
		text = "Abbrechen";
		action = "execVM 'pixLogistic\dialogBarracks\onButtonCancelClicked.sqf';";
	};
};