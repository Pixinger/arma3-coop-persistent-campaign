private["_vehicle","_ladung","_totalLoad","_maxLoad","_index","_objectTexts","_objectCounts","_objectIcons","_objectGuiTexts","_objectName","_object","_tmp"];
_vehicle = _this select 0;
_ladung = _vehicle getVariable "pixLogisticContent";
if (isNil "_ladung") then {	_ladung = []; };

if (((typeof _vehicle) in pixlogisticTransportVehicles) || ((typeof _vehicle) in pixlogisticTransportContainers)) then
{
	/*-----------------------------------------------------------------*/
	/* Gesamtgröße der Ladung berechnen*/
	_totalLoad = 0;
	{
		_index = pixlogisticMovableObjects find _x;
		if (_index != -1) then { _totalLoad = _totalLoad + (pixlogisticMovableObjectsSize select _index); };
	} foreach _ladung;

	/*-----------------------------------------------------------------*/
	/* Maximale Ladefläche suchen*/
	_maxLoad = 0;
	_index = pixlogisticTransportVehicles find (typeOf _vehicle);
	if (_index != -1) then { _maxLoad = pixlogisticTransportVehiclesSize select _index;};
	if (_maxLoad == 0) then
	{
		_index = pixlogisticTransportContainers find (typeOf _vehicle);
		if (_index != -1) then { _maxLoad = pixlogisticTransportContainersSize select _index;};
	};

	/*-----------------------------------------------------------------*/
	/* Objektliste vereinfachen, dafür aber die Anzahl mitzählen*/
	_objectTexts = [];
	_objectCounts = [];
	{
		_index = _objectTexts find _x;
		if (_index == -1) then
		{
			_objectTexts set [count _objectTexts, _x];
			_objectCounts = _objectCounts + [1];
		}
		else
		{
			_objectCounts set [_index, ((_objectCounts select _index) + 1)];
		};		
	} foreach _ladung;

	/*-----------------------------------------------------------------*/
	/* Entsprechend der Objektliste die Icons und GuiTexte laden*/
	_objectIcons = [];
	_objectGuiTexts = [];
	{
		_objectGuiTexts set [count _objectGuiTexts, gettext (configFile >> "CfgVehicles" >> _x >> "displayName")];
		/*_objectIcons set [count _objectIcons, gettext (configFile >> "CfgVehicles" >> _x >> "icon")];*/
	} foreach _objectTexts;


	/* -----------------------------------------------------------------	*/
	/* Dialog erstellen*/
	#include "defines.hpp";
	createDialog "PIXLOGISTIC_DIALOG_OBJECTCONTENT"; 	
	ctrlSetText [PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_Capacity, format["%1/%2", _totalLoad, _maxLoad]];
	ctrlEnable [PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_ButtonMove, ((typeof _vehicle) in pixlogisticTransportContainers)];

	/* Listbox füllen*/
	for [{_i = 0}, {_i < count _objectGuiTexts}, {_i = _i + 1}] do
	{
		lbAdd [PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_List, _objectGuiTexts select _i];				
		/*lbSetPicture [PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_List, _i, _objectIcons select _i];	*/
	};
	lbSetCurSel [PIXLOGISTIC_IDC_DIALOG_OBJECTCONTENT_List, 0];
	
	/* Wenn ESC gedrückt wird, dann als ABBRECHEN werten.*/
	pixLogisticObjectDialogContentButton = 0;
	
	waitUntil { !dialog };
	
	/*-----------------------------------------------------------------	*/
	/* Prüfen welche Taste gedrückt wurde*/
	if (pixLogisticObjectDialogContentButton == 1) then /*OK-Taste*/
	{	
		/* Ladung nocheinmal aktualisieren */
		_ladung = _vehicle getVariable "pixLogisticContent";
		if (isNil "_ladung") then {	_ladung = []; };

		if ((pixLogisticObjectDialogContentSelection > -1) && (pixLogisticObjectDialogContentSelection < count _ladung))then
		{
			_objectName = _objectTexts select pixLogisticObjectDialogContentSelection;
			_ladung set [pixLogisticObjectDialogContentSelection, -1];	_ladung = _ladung - [-1];
			_vehicle setVariable ["pixLogisticContent", _ladung, true];			
			_object = [_objectName, [0,0,0]] call fn_pixLogistic_CreateCorrectedVehicle; /*_object = createVehicle [_objectName, [0,0,0], [], 0, "NONE"];*/
			_tmp = [_object, _vehicle] execVM "pixLogistic\clientMoveObject.sqf";
			
			/* zur Datenbank hinzufügen*/
			if (isServer && !isDedicated) then
			{
				player sidechat "simulate server";
				[_object] execVM "pixLogistic\serverInsertItem.sqf";
			}
			else
			{
				pvehPixlogisticInsertItem = _object;
				publicVariable "pvehPixlogisticInsertItem";
			};		
		};		
	}
	else
	{
		if (pixLogisticObjectDialogContentButton == 2) then /*Move-Taste*/
		{				
			if (isNull(_vehicle getVariable ["pixLogisticIsMoving",objNull])) then
			{
				_tmp = [_vehicle] execVM "pixLogistic\clientMoveObject.sqf";				
			};					
		};
	};
}
else
{
	player sidechat "invalid object";
};