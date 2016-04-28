#include "maindialog_defines.hpp"

class MAINDIALOG 
{
	idd = -1;
	name = "MAINDIALOG";
	movingEnable = false;
 	onLoad = "uiNamespace setVariable [""MAINDIALOG_ID"", _this select 0];";
	onUnLoad="uiNamespace setVariable ['MAINDIALOG_ID', nil]";	
	objects[] = {};
	controlsBackground[] = {};	

	controls[]=
	{
		TextName,
		Button1,
		Button2,
		Button3,
		Button4,
		Button5,
		Button6,
		Button7,
		Button8,
		Button9,
		Button10,
		Button11
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by [TK]Pix, v1.063, #Hefeco)
	////////////////////////////////////////////////////////

	class TextName: RscText
	{
		idc = IDC_MAINMENU_TEXTNAME;
		text = "Dialogname"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
	};
	class Button1: RscButton
	{
		idc = IDC_MAINMENU_BUTTON1;
		text = "Button1"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 0; closedialog 0;";
	};
	class Button2: RscButton
	{
		idc = IDC_MAINMENU_BUTTON2;
		text = "Button2"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 1; closedialog 0;";
	};
	class Button3: RscButton
	{
		idc = IDC_MAINMENU_BUTTON3;
		text = "Button3"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 2; closedialog 0;";
	};
	class Button4: RscButton
	{
		idc = IDC_MAINMENU_BUTTON4;
		text = "Button4"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 3; closedialog 0;";
	};
	class Button5: RscButton
	{
		idc = IDC_MAINMENU_BUTTON5;
		text = "Button5"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 4; closedialog 0;";
	};
	class Button6: RscButton
	{
		idc = IDC_MAINMENU_BUTTON6;
		text = "Button6"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 5; closedialog 0;";
	};
	class Button7: RscButton
	{
		idc = IDC_MAINMENU_BUTTON7;
		text = "Button7"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 6; closedialog 0;";
	};
	class Button8: RscButton
	{
		idc = IDC_MAINMENU_BUTTON8;
		text = "Button8"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 17 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 7; closedialog 0;";
	};
	class Button9: RscButton
	{
		idc = IDC_MAINMENU_BUTTON9;
		text = "Button9"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 8; closedialog 0;";
	};
	class Button10: RscButton
	{
		idc = IDC_MAINMENU_BUTTON10;
		text = "Button10"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 21 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 9; closedialog 0;";
	};
	class Button11: RscButton
	{
		idc = IDC_MAINMENU_BUTTON11;
		text = "Button11"; //--- ToDo: Localize;
		x = 8.5 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		action = "maindialog_action = 10; closedialog 0;";
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
};




