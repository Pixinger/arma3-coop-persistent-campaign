#include "defines.hpp"

class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER 
{
	idd = PIXLOGISTIC_IDD_DIALOG_HQ_GROUPMANAGER;
	name = "PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER";
	movingEnable = false;
	
	controlsBackground[] = 
	{
		PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_Title,
		PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_Background
	};
	objects[] = {};
	controls[] =
	{
		PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_SubTitle,
		PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_List,
		
		PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_ButtonCreate,
		PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_ButtonJoin,
		PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_ButtonLeave
	};
	
	class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_Background: IGUIBack
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y;
		w = GRID_ABS_W;
		h = GRID_ABS_H + (2 * GRID_H);
	};	
	class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_Title : RscTitle
	{
		idc = -1;
		x = GRID_ABS_X;
		y = GRID_ABS_Y - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Gruppen Verwaltung";
	};	
	class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_SubTitle : RscText
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_GROUPMANAGER_SubTitle;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 1 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 1 * GRID_H;
		text = "Gruppen";
		colorbackground[] = 
		{
			0,
			0,
			0,
			1
		};		
	};
	
	class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_List : RscListBox
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_GROUPMANAGER_List;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 2 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 6 * GRID_H;
	};
	

	class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_ButtonCreate : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_GROUPMANAGER_ButtonCreate;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 8 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 0.9 * GRID_H;
		text = "Erstellen";
		action = "execVM 'pixLogistic\dialogHQ\dialogGroupManager\onButtonCreateClicked.sqf';";
	};
	
	class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_ButtonJoin : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_GROUPMANAGER_ButtonJoin;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 9 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 0.9 * GRID_H;
		text = "Beitreten";
		action = "execVM 'pixLogistic\dialogHQ\dialogGroupManager\onButtonJoinClicked.sqf';";
	};
	class PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER_ButtonLeave : RscButtonMenu
	{
		idc = PIXLOGISTIC_IDC_DIALOG_HQ_GROUPMANAGER_ButtonLeave;
		x = 1 * GRID_W + GRID_ABS_X; 
		y = 10 * GRID_H + GRID_ABS_Y; 
		w = 8 * GRID_W;
		h = 0.9 * GRID_H;
		text = "Verlassen";
		action = "execVM 'pixLogistic\dialogHQ\dialogGroupManager\onButtonLeaveClicked.sqf';";
	};
};