private _buttons = [];

private _cursorTarget = cursorTarget;
private _cursorTargetType = typeof _cursorTarget;

if (pixDebug) then { hint format["%1", _cursorTargetType];};

if (typeOf(vehicle player) in logisticHaulers) then 
{
	if (!logisticHaulerPointShowed) then // Nur wenn der Attachpoint nicht angezeigt wird!
	{
		// ...wenn man im Schlepper sitzt kann man nur Schlepper-Aktionen durchführen...
		if (count (attachedObjects (vehicle player)) > 0) then
		{
			_buttons pushBack [localize "str_pc3_Detach", true, true, fnc_Logistic_Hauler_Unload];
		}
		else
		{
			_buttons pushBack [localize "str_pc3_Attach", true, true, fnc_Logistic_Hauler_Load];
		};

		_buttons pushBack [localize "str_pc3_ShowAttachPoint", true, true, fnc_Logistic_Hauler_ShowAttachpoint];	
	};
}
else
{
	if ((vehicle player) isKindOf "Air") then
	{
		if ((getPos (vehicle player)) select 2 > 50) then { _buttons pushBack [localize "str_pc3_HALOJump", true, true, fnc_Logistic_HALOJump]; };
		if (call fnc_Logistic_CanObject_UnloadAll_Plane) then { _buttons pushBack [localize "str_pc3_DropCargo", true, true, fnc_Logistic_Object_UnloadAll_Plane]; };
	}
	else
	{
		if (_cursorTarget distance player < 10) then 
		{
			if (_cursorTargetType == logisticObjectHQClassname) then
			{
				// ...wenn man auf das HQ schaut, kann man nur das HQ bedienen...
				if (_cursorTarget call fnc_Logistic_HQIsOpen) then
				{			
					_buttons pushBack [localize "str_pc3_HQClose", true, true, fnc_Logistic_HQClose];
				}
				else
				{
					_buttons pushBack [localize "str_pc3_HQOpen", true, true, fnc_Logistic_HQOpen];
					_buttons pushBack [localize "str_pc3_HQmove", true, true, fnc_Logistic_Object_Move];
					_buttons pushBack [localize "str_pc3_Load", true, true, fnc_Logistic_Object_Load];
				};
			}
			else
			{
				//... ansonsten kann man alles andere machen...
				
				// Barracken Menü
				if (_cursorTargetType in cfgLogisticGear_MenuObjectClassnames) then 
				{ 
					_buttons pushBack [localize "str_pc3_GearNATO", true, true, fnc_logisticGear_ShowModal, ["loadoutsNATO"]];
					_buttons pushBack [localize "str_pc3_GearCTRG", true, true, fnc_logisticGear_ShowModal, ["loadoutsCTRG"]];
				};
				
				// AIZ Menüs
				if (_cursorTargetType in cfgAizCampTownClassnames) then { _buttons pushBack [localize "str_pc3_ConfiscateDevice", true, true, fnc_aiz_ConfiscateItem];};
				if (_cursorTargetType in cfgAizCampFieldClassnames) then { _buttons pushBack [localize "str_pc3_ConfiscateTent", true, true, fnc_aiz_ConfiscateItem];};

				// Logistic Menüs
				if (_cursorTargetType in logisticObjectsTransportables) then { _buttons pushBack [localize "str_pc3_Load", true, true, fnc_Logistic_Object_Load];};	
				if (_cursorTargetType in logisticTransporters) then { 
					_buttons pushBack [localize "str_pc3_Unload", true, true, fnc_Logistic_Object_Unload];
					_buttons pushBack [localize "str_pc3_UnloadAll", true, true, fnc_Logistic_Object_UnloadAll];
					};
				if (_cursorTargetType in logisticObjectsMoveables) then { _buttons pushBack [localize "str_pc3_Move", true, true, fnc_Logistic_Object_Move];};
				if (call fnc_Logistic_CanSellVehicle) then { _buttons pushBack [localize "str_pc3_Sell", true, true, fnc_Logistic_SellVehicle];};
				if (call fnc_Logistic_CanRepairVehicle) then 
				{ 
					_buttons pushBack [localize "str_pc3_RepairHack", true, true, fnc_Logistic_RepairVehicle];
					if (_cursorTargetType in logisticStripDownables) then { _buttons pushBack [localize "str_pc3_Disassemble", true, true, fnc_Logistic_StripDownVehicle];};
					if (_cursorTargetType in logisticStripDownContainers) then { _buttons pushBack [localize "str_pc3_Assemble", true, true, fnc_Logistic_StripUpVehicle];};
					if (_cursorTargetType in ["B_T_VTOL_01_vehicle_F", "B_T_VTOL_01_infantry_F"]) then { _buttons pushBack [localize "str_pc3_Modify", true, true, fnc_Logistic_VTOLChange];};
					
				};
				if (call fnc_Logistic_CanTakePrison) then { _buttons pushBack [localize "str_pc3_Interrogate", true, true, fnc_Logistic_TakePrison];};
			};
		};

		if (call fnc_Logistic_CanBuryCorpse) then { _buttons pushBack [localize "str_pc3_Bury", true, true, fnc_Logistic_BuryCorpse];};
		if (player getVariable ["isPioneer", false]) then { _buttons pushBack [localize "str_pc3_PioneerMenu", true, true, fnc_Logistic_BuildMenu];};
	};
};


// Zusammengestellte Buttons anzeigen oder DIREKT ausführen wenn es nur einer ist.
//if (count _buttons == 1) then {
//	call ((_buttons select 0) select 3);
//} else {
	[_buttons, localize "str_pc3_LogisticMenu"] execVM "maindialog_showtemplate.sqf";
//};
