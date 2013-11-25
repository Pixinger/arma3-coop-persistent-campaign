#include "defines.hpp"

if (!pixLogisticLift_DialogHUDEnabled) then
{
	pixLogisticLift_DialogHUDEnabled = true;

	disableSerialization;
	cutRsc ["PIXLOGISTIC_DIALOG_LIFT_HUD","PLAIN"];
	private["_dialogID"];
	_dialogID = uiNamespace getVariable "PIXLOGISTIC_DIALOG_LIFT_HUDID";
	
	private["_ctrlBackground"]; 
	_ctrlBackground = _dialogID displayCtrl PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Background;
	private["_ctrlObject"];
	_ctrlObject = _dialogID displayCtrl PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Object;
	private["_ctrlHeight"];
	_ctrlHeight = _dialogID displayCtrl PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Height;
	private["_ctrlGround"];
	_ctrlGround = _dialogID displayCtrl PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Ground;
	private["_ctrlText"];
	_ctrlText = _dialogID displayCtrl PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_Text;


	if (isNull pixLogisticLift_AttachedObject) then
	{		
		/* GUI Elemente initialisieren */
		_ctrlText ctrlShow true;
		_ctrlObject ctrlShow false;
		_ctrlHeight ctrlShow true;
		_ctrlHeight ctrlSetText "pixLogistic\lift\dialogHUD\HUD_Height2.paa";
		_ctrlGround ctrlShow false;
		_ctrlBackground ctrlShow true;
		_ctrlBackground ctrlSetText "pixLogistic\lift\dialogHUD\HUD_Background1.paa";

		/* Loopen solange bis: etwas angehangen / spieler tot / nicht im Heli / manuell beendet */
		while { (isNull pixLogisticLift_AttachedObject) && ((alive player) && (vehicle player != player)) && (pixLogisticLift_DialogHUDEnabled)} do
		{
			if (speed (vehicle player) > 50) then { pixLogisticLift_DialogHUDEnabled = false };
			private ["_object"];		
			_object = call fn_pixLogisticLift_FindNearestObject;
			if (!isNull _object) then
			{
				/* Position berechnen */
				private["_rel_pos"];
				_rel_pos = (vehicle player) worldToModel (getPosATL _object);
				private["_object_x"];
				_object_x = (_rel_pos select 0);
				private["_object_y"];
				_object_y = ((_rel_pos select 1) * -1);
				private["_object_z"];
				_object_z = _rel_pos select 2;
				
				/* Objekt Position übertragen in HUD-Koordinaten */
				private["_hud_x"];
				/*_hud_x   = _object_x / 100;
				private["_hud_y"];
				_hud_y   = 0;
				if (_object_y < 0) then {_hud_y = (abs _object_y) / 100} 
				else { if (_object_y > 0) then {_hud_y = (0 - _object_y) / 100};};			*/
				
				/* Clipping */
				if (_object_x < -25) then {_object_x = -25};
				if (_object_x > 25) then {_object_x = 25};
				if (_object_y < -25) then {_object_y = -25};
				if (_object_y > 25) then {_object_y = 25};

				/* Auf GUI skalieren */
				_object_x = _object_x * (PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_BACKGROUND_W / 50);
				_object_y = _object_y * (PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_BACKGROUND_H / 50);
				
				/* Objekt anschalten & positionieren */
				_ctrlObject ctrlShow true;			
				_ctrlObject ctrlSetPosition [PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_OBJECT_X + _object_x, PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_OBJECT_Y + _object_y];
				_ctrlObject ctrlCommit 0;
				_ctrlText ctrlSetText (getText (configFile >> "cfgVehicles" >> typeof _object >> "displayName"));
				
				if ((abs _object_z) > pixLogisticLiftHeightMax) then 
				{
					_ctrlHeight ctrlSetText "pixLogistic\lift\dialogHUD\HUD_Height1.paa";
				}
				else
				{
					if ((abs _object_z) < pixLogisticLiftHeightMin) then 
					{
						_ctrlHeight ctrlSetText "pixLogistic\lift\dialogHUD\HUD_Height3.paa";
					}
					else
					{
						_ctrlHeight ctrlSetText "pixLogistic\lift\dialogHUD\HUD_Height2.paa";
					}
				}
			} 
			else 
			{
				_ctrlObject ctrlShow false;
				_ctrlText ctrlSetText "";
				_ctrlHeight ctrlSetText "";
			};

			sleep 0.2;
		};
	};

	
	/* Wenn etwas angehangen ist, dann in die nächste Schleife rutschen */
	if (!isNull pixLogisticLift_AttachedObject) then
	{
		/* GUI Elemente initialisieren */
		_ctrlText ctrlShow true;
		_ctrlText ctrlSetText (format["%1", getText (configFile >> "cfgVehicles" >> typeof pixLogisticLift_AttachedObject >> "displayName")]);
		_ctrlObject ctrlShow false;
		_ctrlHeight ctrlShow false;
		_ctrlGround ctrlShow true;
		_ctrlGround ctrlSetPosition [PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_X, PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_Y];
		_ctrlBackground ctrlShow true;
		_ctrlBackground ctrlSetText "pixLogistic\lift\dialogHUD\HUD_Background2.paa";

		/* Objektposition unterm Hubschrauber berechnen */
		private["_rel_height"];
		_rel_height = (((vehicle player) worldToModel (getPosATL pixLogisticLift_AttachedObject)) select 2);
		private["_x"];
		_x = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_X;
		private["_y"];
		_y = PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_GROUND_Y;
		
		/* Loopen solange bis: nichts mehr angehangen / spieler tot / nicht im Heli / manuell beendet */
		while { (!isNull pixLogisticLift_AttachedObject) && ((alive player) && (vehicle player != player)) && (pixLogisticLift_DialogHUDEnabled)} do
		{
			/* Objektposition ATL berechnen */
			private["_object_ATL"];
			_object_ATL = ((getPosATL pixLogisticLift_AttachedObject) select 2);

			/* Clipping */
			if (_object_ATL < 0) then { _object_ATL = 0;};
			if (_object_ATL > 50) then { _object_ATL = 50;};
			
			/* In den GUI Wertebereich bringen */
			_object_ATL = _object_ATL * (PIXLOGISTIC_IDC_DIALOG_LIFT_HUD_BACKGROUND_H / 50);

			/* Position setzen */
			_ctrlGround ctrlSetPosition [_x , _y - _object_ATL];
			_ctrlGround ctrlCommit 0;
			
			/* kurz schlafen */
			sleep 0.2;
		};		
	};
	
	/* Alle Kontrollen abschalten */
	_ctrlBackground ctrlShow false;
	_ctrlObject ctrlShow false;
	_ctrlHeight ctrlShow false;
	_ctrlGround ctrlShow false;
	_ctrlText ctrlShow false;	
	cutText ["", "PLAIN"];
};