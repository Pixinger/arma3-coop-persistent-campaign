private["_wareList"];
_wareList = _this select 0;  /* [Bezeichnung, Kosten, SpawnTyp (>=0:hafen / 1>=:airport), Classname, Image, Content-Array] */
private["_title"];
_title = _this select 1;

/* -----------------------------------------------------------------	*/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_HQ_STORE"; 	
ctrlSetText [PIXLOGISTIC_IDC_DIALOG_HQ_STORE_Title, _title];
ctrlSetText [PIXLOGISTIC_IDC_DIALOG_HQ_STORE_SubTitle, format["HABEN: %1€", pvPixLogisticMoney]];

/*-----------------------------------------------------------------		*/
/* Listbox füllen*/
private["_i"];
private["_c"];
_c = (count _wareList) - 1;
for "_i" from 0 to _c do
{	
	private["_ware"];
	_ware = _wareList select _i;
	lbAdd [PIXLOGISTIC_IDC_DIALOG_HQ_STORE_List, format["%1€: %2", _ware select 1, _ware select 0]];
	lbSetPicture [PIXLOGISTIC_IDC_DIALOG_HQ_STORE_List, _i, _ware select 4];
};
lbSetCurSel [PIXLOGISTIC_IDC_DIALOG_HQ_STORE_List, 0];

/*-----------------------------------------------------------------	*/
/* Dialog anzeigen*/
pixLogisticDialogHqStore_ButtonOK = 0;
pixLogisticDialogHqStore_Selection = -1;
waitUntil { !dialog };

/*-----------------------------------------------------------------	*/
/* Wenn OK geklickt wurde, die Eingaben verarbeiten*/
if (pixLogisticDialogHqStore_ButtonOK == 1) then
{		
	private["_ware"];
	_ware = _wareList select pixLogisticDialogHqStore_Selection;	
	private["_money"];
	_money = _ware select 1;
	
	if ((pixLogisticDialogHqStore_AdminSpawn) || (pvPixLogisticMoney - _money >= 0)) then
	{	
		/* Nur mit Karte im Inventar kann auf der Map geklickt werden */
		if ("ItemMap" in (items player)) then
		{
			/* Position bestimmen an der die Ware spawnen soll. */
			private["_spawnObject"];
			_spawnObject = [_ware select 2] call compile preprocessFileLineNumbers "pixLogistic\dialogHQ\dialogStore\fn_getSpawnLocation.sqf"; /* Wenn Admin-Spawn, dann wird hier der Spieler zurückgegeben */ 
			if (str(_spawnObject) != "") then
			{
				private["_classname"];
				_classname = _ware select 3;
				private["_content"];
				_content = _ware select 5;
				
				private["_zoneIndex"];
				_zoneIndex = (getPos _spawnObject) call fn_pixZones_GetZoneIndex;
				if (_zoneIndex >= 0) then
				{
					if ((pvehPixZones_ZoneStatus select _zoneIndex) >= 2) then 
					{				
						/* Nur berechtigte Personen dürfen anfragen */
						if ((getPlayerUID player in pvPixLogisticAdminUIDs) || (getPlayerUID player in pvPixLogisticTeamLeaderUIDs) || (isServer && !isDedicated)) then
						{
							private["_pos"];
							if (pixLogisticDialogHqStore_AdminSpawn) then 
							{
								_pos = player modelToWorld [0,8,0]; 
							} 
							else 
							{ 
								_pos = getPos _spawnObject;
								pvPixLogisticMoney = pvPixLogisticMoney - _money;
								publicVariable "pvPixLogisticMoney"; /* An alle weiterleiten */
							};				
							
							private["_object"];
							_object = [_classname, _pos] call fn_pixLogistic_CreateCorrectedVehicle;/*	_object = _classname createVehicle (getPos _spawnObject);*/
							if (str(_content) != "[]") then { _object setVariable ["pixLogisticContent", _content, true];};
							_object setDir (getDir _spawnObject);

							if (isServer && !isDedicated) then
							{
								player sidechat "simulate server";
								[_object] execVM "pixLogistic\serverInsertItem.sqf"
							}
							else
							{
								pvehPixlogisticInsertItem = _object;
								publicVariable "pvehPixlogisticInsertItem";
							};
							
							player sidechat "Die Waren wurden erfolgreich geliefert.";
						}
						else
						{
							player sidechat "Sie sind nicht berechtigt Materialanfragen zu stellen.";
						};
					}
					else
					{
						player sidechat "Die Ladestelle liegt nicht in Ihrer Zone!";
					};
				}
				else
				{
					player sidechat "ERROR: Invalid ZoneIndex";
				};
			}
			else
			{
				player sidechat "ERROR: Ungültige Position";
			};
		}
		else
		{
				player sidechat "ERROR: Du musst eine Karte im Inventar haben.";
		};
	}
	else
	{
		player sidechat format["Nicht genug Geld um diesen Gegenstand anzufordern. SOLL(%1) HABEN(%2).", _money, pvPixLogisticMoney];
	};
};

pixLogisticDialogHqStore_AdminSpawn = false;