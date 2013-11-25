#include "defines.hpp"

class PIXLOGISTIC_DIALOG_LIFT_HUD
{
   	idd = PIXLOGISTIC_IDD_DIALOG_LIFT_HUD;
   	movingEnable = 0;
   	duration = 1e+011;
   	onLoad = "uiNamespace setVariable [""PIXLOGISTIC_DIALOG_LIFT_HUDID"", _this select 0];";
   	name = "PIXLOGISTIC_DIALOG_LIFT_HUD";
	controlsBackground[] = {};
   	objects[] = {};
   	class controls 
	{
		class PIXLOGISTIC_DIALOG_LIFT_HUD_Background : RscPicture
		{
			idc = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Background;
			x = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_BACKGROUND_X;
			y = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_BACKGROUND_Y;
			w = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_BACKGROUND_W;
			h = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_BACKGROUND_H;
			sizeEx = 0.03;
			text = "pixLogistic\lift\dialogHUD\HUD_Background1.paa";
		};
		class PIXLOGISTIC_DIALOG_LIFT_HUD_Object : RscPicture
		{
			idc = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Object;
			x = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_OBJECT_X;
			y = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_OBJECT_Y;
			w = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_OBJECT_W;
			h = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_OBJECT_H;
			sizeEx = 0.04;
			text = "pixLogistic\lift\dialogHUD\HUD_Object.paa";
		};
		class PIXLOGISTIC_DIALOG_LIFT_HUD_Height : RscPicture
		{
			idc = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Height;
			x = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_HEIGHT_X;
			y = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_HEIGHT_Y;
			w = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_HEIGHT_W;
			h = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_HEIGHT_H;
			sizeEx = 0.03;
			text = "";
		};
		class PIXLOGISTIC_DIALOG_LIFT_HUD_Ground : RscPicture
		{
			idc = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Ground;
			x = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_X;
			y = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_Y;
			w = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_W;
			h = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_H;
			sizeEx = 0.03;
			text = "pixLogistic\lift\dialogHUD\HUD_Height3.paa";
		};
		class PIXLOGISTIC_DIALOG_LIFT_HUD_Text : RscText
		{
			idc = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Text;
			x = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_TEXT_X;
			y = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_TEXT_Y;
			w = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_TEXT_W;
			h = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_TEXT_H;
			sizeEx = 0.03;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			text = "";
			style = 528;
		};
	};
 };