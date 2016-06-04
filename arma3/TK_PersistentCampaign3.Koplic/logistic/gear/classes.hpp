#include "defines.hpp"

class LOGISTICGEAR_DIALOG 
{
	idd = LOGISTICGEAR_IDD_DIALOG;
	name = "LOGISTICGEAR_DIALOG";
	movingEnable = false;
	
	controlsBackground[] = 
	{
		LOGISTICGEAR_DIALOG_Title,
		LOGISTICGEAR_DIALOG_Background
	};
	objects[] = {};
	controls[] =
	{
		LOGISTICGEAR_DIALOG_SubTitle,
		LOGISTICGEAR_DIALOG_List,
		
		LOGISTICGEAR_DIALOG_ButtonOK,
		LOGISTICGEAR_DIALOG_ButtonCancel
	};
	
	class LOGISTICGEAR_DIALOG_Background: IGUIBack
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y;
		w = GRID_ABS_W;
		h = GRID_ABS_H;
	};	
	class LOGISTICGEAR_DIALOG_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Ausrüstung";
	};	
	class LOGISTICGEAR_DIALOG_SubTitle : RscText
	{
		idc = LOGISTICGEAR_IDC_DIALOG_SubTitle;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 1 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "Klasse";
		colorbackground[] = 
		{
			0,
			0,
			0,
			1
		};		
	};
	
	class LOGISTICGEAR_DIALOG_List : RscListBox
	{
		idc = LOGISTICGEAR_IDC_DIALOG_List;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 2 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 6 * GRID_H;
	};
	

	class LOGISTICGEAR_DIALOG_ButtonOK : RscButtonMenuOK
	{
		idc = LOGISTICGEAR_IDC_DIALOG_ButtonOK;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 3.9 * GRID_W;
		h = 0.9 * GRID_H;
		text = "OK";
		action = "logisticGearDialog_ButtonResult = 1; logisticGearDialog_Selection = lbCurSel 853; closeDialog 0;";
	};
	
	class LOGISTICGEAR_DIALOG_ButtonCancel : RscButtonMenuCancel
	{
		idc = LOGISTICGEAR_IDC_DIALOG_ButtonCancel;
		x = 5 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 4 * GRID_W;
		h = 0.9 * GRID_H;
		text = "Abbrechen";
		action = "logisticGearDialog_ButtonResult = 0; closeDialog 0;";
	};
};