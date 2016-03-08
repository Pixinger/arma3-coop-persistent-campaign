#include "defines.hpp"

class LOGISTIC_DIALOG_STORE 
{
	idd = LOGISTIC_IDD_DIALOG_HQ_STORE;
	name = "LOGISTIC_DIALOG_STORE";
	movingEnable = false;
	
	controlsBackground[] = 
	{
		LOGISTIC_DIALOG_STORE_Title,
		LOGISTIC_DIALOG_STORE_Background
	};
	objects[] = {};
	controls[] =
	{
		LOGISTIC_DIALOG_STORE_SubTitle,
		LOGISTIC_DIALOG_STORE_List,
		
		LOGISTIC_DIALOG_STORE_ButtonCreate,
		LOGISTIC_DIALOG_STORE_ButtonCancel
	};
	
	class LOGISTIC_DIALOG_STORE_Background: IGUIBack
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y;
		w = GRID_ABS_W;
		h = GRID_ABS_H;
	};	
	class LOGISTIC_DIALOG_STORE_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "";
	};	
	class LOGISTIC_DIALOG_STORE_SubTitle : RscText
	{
		idc = LOGISTIC_IDC_DIALOG_STORE_SubTitle;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 1 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "";
		colorbackground[] = 
		{
			0,
			0,
			0,
			1
		};		
	};
	
	class LOGISTIC_DIALOG_STORE_List : RscListBox
	{
		idc = LOGISTIC_IDC_DIALOG_STORE_List;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 2 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 6 * GRID_H;
	};
	

	class LOGISTIC_DIALOG_STORE_ButtonCreate : RscButtonMenuOK
	{
		idc = LOGISTIC_IDC_DIALOG_STORE_ButtonCreate;
		x = 5 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 4 * GRID_W;
		h = 1 * GRID_H;
		text = "Anfordern";
		action = "logisticDialogStore_Selection = lbCurSel 803; logisticDialogStore_ButtonOK = 1; closeDialog 0;";
	};
	
	class LOGISTIC_DIALOG_STORE_ButtonCancel : RscButtonMenuCancel
	{
		idc = LOGISTIC_IDC_DIALOG_STORE_ButtonCancel;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 4 * GRID_W;
		h = 1 * GRID_H;
		text = "Abbrechen";
		action = "logisticDialogStore_ButtonOK = 0; closeDialog 0;";
	};
};