private["_buttons"];	
_buttons = [];

private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;
hint format["%1", _cursorTargetType];

if (typeOf(vehicle player) in logisticHaulers) then 
{
	// ...wenn man im Schlepper sitzt kann man nur Schlepper-Aktionen durchführen...
	_buttons pushBack ["Anhängen", true, true, fnc_Logistic_AttachToHauler];
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
				_buttons pushBack ["HQ öffnen", true, true, fnc_Logistic_HQOpen];
				_buttons pushBack ["HQ bewegen", true, true, fnc_Logistic_Object_Move];
			}
			else
			{
				_buttons pushBack ["HQ schließen", true, true, fnc_Logistic_HQClose];
			};
		}
		else
		{
			//... ansonsten kann man alles andere machen...
			
			// Barracken Menü
			if (_cursorTargetType in cfgLogisticGear_MenuObjectClassnames) then { _buttons pushBack ["Ausrüsten (Waffen)", true, true, fnc_logisticGear_ShowModal];};		
			
			// AIZ Menüs
			if (_cursorTargetType in cfgAizCampTownClassnames) then { _buttons pushBack ["Gerät beschlagnahmen", true, true, fnc_aiz_ConfiscateItem];};
			if (_cursorTargetType in cfgAizCampFieldClassnames) then { _buttons pushBack ["Zelt beschlagnahmen", true, true, fnc_aiz_ConfiscateItem];};

			// Logistic Menüs
			if (_cursorTargetType in logisticObjectsTransportables) then { _buttons pushBack ["Aufladen", true, true, fnc_Logistic_Object_Load];};	
			if (_cursorTargetType in logisticTransporters) then { _buttons pushBack ["Abladen", true, true, fnc_Logistic_Object_Unload];};
			if (_cursorTargetType in logisticObjectsMoveables) then { _buttons pushBack ["Bewegen", true, true, fnc_Logistic_Object_Move];};
		};
	};

	if (player getVariable ["isPioneer", false]) then { _buttons pushBack ["Pionier Menü", true, true, fnc_Logistic_BuildMenu];};
};


// Zusammengestellte Buttons anzeigen oder DIREKT ausführen wenn es nur einer ist.
if (count _buttons == 1) then {
	call ((_buttons select 0) select 3);
} else {
	[_buttons, "Logistik Menü"] execVM "maindialog_showtemplate.sqf";
};