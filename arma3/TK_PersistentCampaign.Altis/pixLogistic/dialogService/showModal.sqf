private["_building"];
_building = _this select 0;

/* -----------------------------------------------------------------*/	
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_SERVICE"; 	

/* -----------------------------------------------------------------*/	
/* Gültige Objekte in der Nähe suchen*/
private["_vehicleTypes"];
_vehicleTypes = [];
{ _vehicleTypes set[count _vehicleTypes, _x select 3];} foreach pixLogisticStoreVehicles;
private["_vehicles"];
_vehicles = nearestObjects [_building, _vehicleTypes, 50];
/*-------*/
private["_weaponTypes"];
_weaponTypes = [];
{ _weaponTypes set[count _weaponTypes, _x select 3];} foreach pixLogisticStoreWeapons;
private["_weapons"];
_weapons = nearestObjects [_building, _weaponTypes, 50];
/*-------*/
private["_containerTypes"];
_containerTypes = [];
{ _containerTypes set[count _containerTypes, _x select 3];} foreach pixLogisticStoreContainer;
private["_containers"];
_containers = nearestObjects [_building, _containerTypes, 50];
/*-------*/
private["_sellOnlyTypes"];
_sellOnlyTypes = [];
{ _sellOnlyTypes set[count _sellOnlyTypes, _x select 3];} foreach pixLogisticStoreSellOnly;
private["_sellOnlys"];
_sellOnlys = nearestObjects [_building, _sellOnlyTypes, 50];
/*-------*/
private["_objects"];
_objects = [];
{ _objects set [count _objects, _x];} foreach _weapons;
{ _objects set [count _objects, _x];} foreach _vehicles;
{ _objects set [count _objects, _x];} foreach _containers;
{ _objects set [count _objects, _x];} foreach _sellOnlys;

/*-----------------------------------------------------------------	*/
/* Listbox füllen */
{
	lbAdd [PIXLOGISTIC_IDC_DIALOG_SERVICE_List, format["%1: Schaden(%2)", gettext (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName"), round((getDammage _x) * 100)]];
} foreach _objects;
if (count _objects > 0) then { lbSetCurSel [PIXLOGISTIC_IDC_DIALOG_SERVICE_List, 0]; };

/*-----------------------------------------------------------------	*/
/* Dialog anzeigen */
pixLogisticDialogService_ButtonOK = 0;
pixLogisticDialogService_Selection = -1;
waitUntil { !dialog };

/*-----------------------------------------------------------------	*/
/* Wenn OK geklickt wurde, die Eingaben verarbeiten */
if (pixLogisticDialogService_ButtonOK == 1) then
{		
	/* Nur berechtigte Personen dürfen anfragen */
	if ((getPlayerUID player in pvPixLogisticAdminUIDs) || (getPlayerUID player in pvPixLogisticTeamLeaderUIDs) || (isServer && !isDedicated)) then
	{
		private["_object"];
		_object = _objects select pixLogisticDialogService_Selection;
		private["_classname"];
		_classname = typeof _object;

		/*----------------*/
		/*----------------*/
		/* Wert bestimmen */
		/*----------------*/
		private["_recycleMoney"];
		_recycleMoney = 0;
		/* Vehicles */
		{
			if (_x select 3 == _classname) exitWith
			{
				if (damage _object > 0.2) then
				{
					_recycleMoney = round((_x select 1) * 0.33);
				}
				else
				{
					_recycleMoney = round((_x select 1) * 0.8);
				};
			};
		} foreach pixLogisticStoreVehicles;
		/* Containers */
		if (_recycleMoney == 0) then
		{
			{
				if (_x select 3 == _classname) exitWith
				{
					if (damage _object > 0.2) then
					{
						_recycleMoney = round((_x select 1) * 0.33);
					}
					else
					{
						_recycleMoney = round((_x select 1) * 0.8);
					};
				};
			} foreach pixLogisticStoreContainer;
		};
		/* Weapons */
		if (_recycleMoney == 0) then
		{
			{
				if (_x select 3 == _classname) exitWith
				{
					if (damage _object > 0.2) then
					{
						_recycleMoney = round((_x select 1) * 0.33);
					}
					else
					{
						_recycleMoney = round((_x select 1) * 0.8);
					};
				};
			} foreach pixLogisticStoreWeapons;
		};
		/* SellOnly */
		if (_recycleMoney == 0) then
		{
			{
				if (_x select 3 == _classname) exitWith
				{
					if (damage _object > 0.2) then
					{
						_recycleMoney = round((_x select 1) * 0.33);
					}
					else
					{
						_recycleMoney = round((_x select 1) * 0.8);
					};
				};
			} foreach pixLogisticStoreSellOnly;
		};		
						
		/*--------------------------*/
		/* Kontostand aktualisieren */
		/*--------------------------*/
		pvPixLogisticMoney = pvPixLogisticMoney + _recycleMoney;
		publicVariable "pvPixLogisticMoney";
		
		player globalChat format["Recycelt für %1€. HABEN=%2", _recycleMoney, pvPixLogisticMoney];

		if (isServer && !isDedicated) then
		{
			player globalChat "simulate server";
			[_object] execVM "pixLogistic\serverDeleteItem.sqf";
		}
		else
		{
			pvehPixlogisticDeleteItem = _object;
			publicVariable "pvehPixlogisticDeleteItem";
		};		
	}
	else
	{
		player globalChat "Sie sind nicht berechtigt das Recyeln eines Gegenstandes zu beantragen.";
	};
};
pixLogisticDialogService_Selection = nil;