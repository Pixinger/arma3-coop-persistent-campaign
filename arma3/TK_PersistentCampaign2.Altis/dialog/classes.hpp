#include "defines.hpp"

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
		ButtonCenter1,
		ButtonCenter2,
		ButtonCenter3,
		ButtonCenter4,
		ButtonCenter5,
		ButtonCenter6,
		ButtonRight1,
		ButtonRight2,
		ButtonRight3,
		ButtonRight4,
		ButtonRight5,
		ButtonLeft1,
		ButtonLeft2,
		ButtonLeft3,
		ButtonLeft4,
		ButtonLeft5,
		ButtonFooter1,
		ButtonFooter2,
		ButtonFooter3,
		ButtonFooter4,
		ButtonFooter5,
		ButtonHeader1,
		ButtonHeader2,
		ButtonHeader3,
		ButtonHeader4,
		ButtonHeader5
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by [TK]Pix, v1.063, #Qufema)
	////////////////////////////////////////////////////////

	class ButtonCenter1: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONCENTER1;
		text = "Center1"; //--- ToDo: Localize;
		x = 0.408333 * safezoneW + safezoneX;
		y = 0.346 * safezoneH + safezoneY;
		w = 0.171875 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 0; closedialog 0;";
	};
	class ButtonCenter2: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONCENTER2;
		text = "Center2"; //--- ToDo: Localize;
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.39 * safezoneH + safezoneY;
		w = 0.126042 * safezoneW;
		h = 0.044 * safezoneH;
		action = "maindialog_action = 1; closedialog 0;";
	};
	class ButtonCenter3: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONCENTER3;
		text = "Center3"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.445 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.044 * safezoneH;
		action = "maindialog_action = 2; closedialog 0;";
	};
	class ButtonCenter4: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONCENTER4;
		text = "Center4"; //--- ToDo: Localize;
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.044 * safezoneH;
		action = "maindialog_action = 3; closedialog 0;";
	};
	class ButtonCenter5: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONCENTER5;
		text = "Center5"; //--- ToDo: Localize;
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.555 * safezoneH + safezoneY;
		w = 0.126042 * safezoneW;
		h = 0.044 * safezoneH;
		action = "maindialog_action = 4; closedialog 0;";
	};
	class ButtonCenter6: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONCENTER6;
		text = "Center6"; //--- ToDo: Localize;
		x = 0.408333 * safezoneW + safezoneX;
		y = 0.61 * safezoneH + safezoneY;
		w = 0.171875 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 5; closedialog 0;";
	};
	class ButtonRight1: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONRIGHT1;
		text = "Right1"; //--- ToDo: Localize;
		x = 0.574479 * safezoneW + safezoneX;
		y = 0.39 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 6; closedialog 0;";
	};
	class ButtonRight2: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONRIGHT2;
		text = "Right2"; //--- ToDo: Localize;
		x = 0.580208 * safezoneW + safezoneX;
		y = 0.434 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 7; closedialog 0;";
	};
	class ButtonRight3: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONRIGHT3;
		text = "Right3"; //--- ToDo: Localize;
		x = 0.580208 * safezoneW + safezoneX;
		y = 0.478 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 8; closedialog 0;";
	};
	class ButtonRight4: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONRIGHT4;
		text = "Right4"; //--- ToDo: Localize;
		x = 0.580208 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 9; closedialog 0;";
	};
	class ButtonRight5: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONRIGHT5;
		text = "Right5"; //--- ToDo: Localize;
		x = 0.574479 * safezoneW + safezoneX;
		y = 0.566 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 10; closedialog 0;";
	};
	class ButtonLeft1: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONLEFT1;
		text = "Left1"; //--- ToDo: Localize;
		x = 0.288021 * safezoneW + safezoneX;
		y = 0.39 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 11; closedialog 0;";
	};
	class ButtonLeft2: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONLEFT2;
		text = "Left2"; //--- ToDo: Localize;
		x = 0.282292 * safezoneW + safezoneX;
		y = 0.434 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 12; closedialog 0;";
	};
	class ButtonLeft3: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONLEFT3;
		text = "Left3"; //--- ToDo: Localize;
		x = 0.282292 * safezoneW + safezoneX;
		y = 0.478 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 13; closedialog 0;";
	};
	class ButtonLeft4: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONLEFT4;
		text = "Left4"; //--- ToDo: Localize;
		x = 0.282292 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 14; closedialog 0;";
	};
	class ButtonLeft5: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONLEFT5;
		text = "Left5"; //--- ToDo: Localize;
		x = 0.288021 * safezoneW + safezoneX;
		y = 0.566 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 15; closedialog 0;";
	};
	class ButtonFooter1: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONFOOTER1;
		text = "Footer1"; //--- ToDo: Localize;
		x = 0.288021 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 16; closedialog 0;";
	};
	class ButtonFooter2: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONFOOTER2;
		text = "Footer2"; //--- ToDo: Localize;
		x = 0.373958 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 17; closedialog 0;";
	};
	class ButtonFooter3: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONFOOTER3;
		text = "Footer3"; //--- ToDo: Localize;
		x = 0.459896 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 18; closedialog 0;";
	};
	class ButtonFooter4: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONFOOTER4;
		text = "Footer4"; //--- ToDo: Localize;
		x = 0.545833 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 19; closedialog 0;";
	};
	class ButtonFooter5: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONFOOTER5;
		text = "Footer5"; //--- ToDo: Localize;
		x = 0.631771 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 20; closedialog 0;";
	};
	class ButtonHeader1: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONHEADER1;
		text = "Header1"; //--- ToDo: Localize;
		x = 0.288021 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 21; closedialog 0;";
	};
	class ButtonHeader2: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONHEADER2;
		text = "Header2"; //--- ToDo: Localize;
		x = 0.373958 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 22; closedialog 0;";
	};
	class ButtonHeader3: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONHEADER3;
		text = "Header3"; //--- ToDo: Localize;
		x = 0.459896 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 23; closedialog 0;";
	};
	class ButtonHeader4: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONHEADER4;
		text = "Header4"; //--- ToDo: Localize;
		x = 0.545833 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 24; closedialog 0;";
	};
	class ButtonHeader5: RscButton
	{
		idc = IDC_MAINDIALOG_BUTTONHEADER5;
		text = "Header5"; //--- ToDo: Localize;
		x = 0.631771 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.0802083 * safezoneW;
		h = 0.033 * safezoneH;
		action = "maindialog_action = 25; closedialog 0;";
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
};