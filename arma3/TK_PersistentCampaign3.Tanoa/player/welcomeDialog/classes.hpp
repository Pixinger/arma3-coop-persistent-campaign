#include "defines.hpp"

class WelcomdeDialog
{
	idd = WELCOME_IDD_DIALOG;
	movingEnable = 1;

	controlsBackground[] = 
	{
		WelcomeDialog_Title,
		WelcomeDialog_Background
	};
	objects[] = {};
	Controls[] =
	{
		WelcomeDialog_HTML,
		WelcomeDialog_ButtonOK
	};
	
	class WelcomeDialog_Background: IGUIBack
	{
		idc = -1;
		x = 0;
		y = 0;
		w = GRID_ABS_W;
		h = GRID_ABS_H;
	};	
	class WelcomeDialog_Title : RscTitle
	{
		idc = -1;
		x = 0;
		y = 0 - GRID_TITLE_H;
		w = GRID_ABS_W;
		h = GRID_TITLE_H;
		text = "Hinweis";
	};	
	
	class WelcomeDialog_HTML
	{
		type = CT_HTML; 
		style = ST_LEFT;
		idc = WELCOME_IDC_DIALOG_HTML;
		filename = "";

		x = 0.1 * GRID_W; 
		y = 0.1 * GRID_H; 
		w = 9.8 * GRID_W;
		h = 8.9 * GRID_H;
		
		colorBackground[] = {0,0,0, 0.7};
		colorBold[] = {1, 0, 0, 1};
		colorLink[] = {1, 0, 0, 1};
		colorLinkActive[] = {1, 0, 0, 1};
		colorPicture[] = {1, 1, 1, 1};
		colorPictureBorder[] = {1, 0, 0, 1};
		colorPictureLink[] = {0, 0, 1, 1};
		colorPictureSelected[] = {0, 1, 0, 1};
		colorText[] = {0.8, 0.8, 0.8, 1};

		prevPage = "\ca\ui\data\arrow_left_ca.paa";
		nextPage = "\ca\ui\data\arrow_right_ca.paa";

		class H1 {
			font = "PuristaMedium";
			fontBold = "PuristaMedium";
			sizeEx = 0.055;
		};

		class H2 {
			font = "PuristaMedium";
			fontBold = "PuristaMedium";
			sizeEx = 0.05;
		};

		class H3 {
			font = "PuristaMedium";
			fontBold = "PuristaMedium";
			sizeEx = 0.05;
		};

		class H4 {
			font = "PuristaMedium";
			fontBold = "PuristaMedium";
			sizeEx = 0.04;
		};

		class H5 {
			font = "PuristaMedium";
			fontBold = "PuristaMedium";
			sizeEx = 0.04;
		};

		class H6 {
			font = "PuristaMedium";
			fontBold = "PuristaMedium";
			sizeEx = 0.04;
		};

		class P {
			font = "PuristaMedium";
			fontBold = "PuristaMedium";
			sizeEx = 0.045;
		};
	};
	class WelcomeDialog_ButtonOK : RscButtonMenuOK
	{
		idc = WELCOME_IDC_DIALOG_ButtonOK;
		x = 0.1 * GRID_W; 
		y = 9.1 * GRID_H; 
		w = 9.8 * GRID_W;
		h = 0.8 * GRID_H;
		text = ">> Verstanden";
		action = "closeDialog 0;";
	};
};