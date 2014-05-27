/*
pixLogistic_
pvPixLogistic_
pvehPixLogistic_

Variablen Übersicht:

 Global:
	pvehPixlogisticInsertItem = ""; 	EventHandler Variable zum Aufnehmen von erzeugten Objekten in der Datenbank. (Client to Server)
	pvehPixlogisticDeleteItem = ""; 	EventHandler Variable zum Entfernen von erzeugten Objekten in der Datenbank. (Client to Server)
	pvehPixlogisticSaveAllItems = ""; 	EventHandler Variable zum Speichern von allen Objekten in der Datenbank. (Client to Server)
	pvehPixlogisticAllItemsSaved = ""; 	EventHandler Variable zum Aktualisieren von erzeugten Objekten in der Datenbank. (Server to Client)
	pvPixLogisticMoney = -1; 			Public Variable zum Aktualisieren des Kontostandes. (Client to Server)
	pvPixLogisticTeamLeaderUIDs			Array mit den UserIds die Teamleader sind
	pvPixLogisticAdminUIDs				Array mit den UserIds die Admins sind
	pvPixLogisticServerInitialized		Public Variable ist true, wenn der Server fertig mit der Initialisierung ist.

Serverseitig:
	pixlogisticDbItems = []; 			Überwachte Items
	pixlogisticDbItemFilename = "";
	pixlogisticDbDataFilename = "";
	pixlogisticRewardForZone = 10000;
	pixlogisticRewardForExistingZone = 1000;
	pixlogisticDbMutex = false;

Clientseitig:
	pixLogisticMovingObject = objNull;		(objNull, object)
	pixLogisitcActionKeyPressed = false;
	pixLogisitcAdminKeyPressed = false;
		
	pixLogisticContent= [];
	pixlogisticIsMoving						(true, false)
	pixLogisticMapClick						Überträgt Map-Click-Koordinaten

	pixlogisticTransportVehicles			(String-Array mit Klassennamen der vorhandenen Transportfahrzeuge)
	pixlogisticTransportVehiclesSize		(Int-Array mit der Größe der Ladefläche des entsprechenden Transportfahrzeugs)
	pixlogisticMovableObjects				(String-Array mit Klassennamen der verschiebbaren Objekte)
	pixlogisticMovableObjectsSize			(Int-Array mit der Größe des verschiebbaren Objektes)
	
	pixlogisticDialogSelection				(Rückgabewert des Auswahl-Dialoges)
	pixLogisticObjectDialogContentButton	(Gibt an, ob bei dem Auswahl-Dialog die OK Taste gedrückt wurde, oder nicht)
	pixLogisticObjectDialogContentSelection = 0;
	pixLogisticDialogHqStore_AdminSpawn = false; (Enthält die SpawnPosition eines Gegenstandes, wenn über das AdminMenü aufgerufen wurd.)
	pixLogisticAdminHide = false;
*/

/* ------------------- */
/* Konfiguration laden */
/* ------------------- */
call compile preprocessFileLineNumbers "pixLogistic\config.sqf";

/*_lll = ["B_HMG_01_A_F","B_HMG_01_A_F","B_HMG_01_A_F","B_HMG_01_F","B_HMG_01_F","B_GMG_01_F","Land_HBarrierBig_F"];*/
/*conti setVariable ["pixLogisticContent", _lll, true];*/

/* -------------------------------- */
/* Spezielle Funktionen kompilieren */
/* -------------------------------- */
fn_pixLogistic_CreateCorrectedVehicle = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_CreateCorrectedVehicle.sqf";

if (isServer) then
{
	diag_log format["pixLogistic: %1", call compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DllVersion.sqf"];
	if (pixDebug) then { player globalChat format["INFO: pixLogistic: %1", call compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DllVersion.sqf"];};
	
	/* ------------------------ */
	/* Variablen Initialisieren */
	/* ------------------------ */
	pixlogisticDbItems = []; /* Überwachte Items */
	pixlogisticDbMutex = false;
	pvehPixlogisticInsertItem = ""; 	/* EventHandler Variable zum Aufnehmen von erzeugten Objekten in der Datenbank. */
	pvehPixlogisticDeleteItem = ""; 	/* EventHandler Variable zum Entfernen von erzeugten Objekten in der Datenbank. */
	pvehPixlogisticUpdateItem = ""; 	/* EventHandler Variable zum Aktualisieren von erzeugten Objekten in der Datenbank. */
	pvehPixlogisticSaved = 0; 			/* Wird bei jedem speichern um eins erhöht */
	pvPixLogisticServerInitialized = false;
	pvehPixlogisticHidePlayer = "";
	publicVariable "pvPixLogisticServerInitialized";

	/* -------------------------------------------------------------- */
	/* Zur Sicherheit einmal aufräumen (evtl. vorherige Skriptfehler) */
	/* -------------------------------------------------------------- */
	if ((call compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DllCleanup.sqf") != "OK") then
	{
		diag_log format["ERROR: fn_pixLogistic_Cleanup failed: %1", _result];
		player globalChat format["ERROR: fn_pixLogistic_Cleanup failed: %1", _result];
	};
	
	/*------------------------------------*/
	/* Alle Items aus der Datenbank laden */
	/*------------------------------------*/
	[] call compile preprocessFileLineNumbers "pixLogistic\serverLoadAllItems.sqf";
	
	/* --------------------------- */
	/* EventHandler Initialisieren */
	/* --------------------------- */
	"pvehPixlogisticHidePlayer" addPublicVariableEventHandler {
		private["_tmp"];
		_tmp = (_this select 1) execVM "pixLogistic\serverHideObject.sqf";		
	};
	"pvehPixlogisticInsertItem" addPublicVariableEventHandler {
		private["_tmp"];
		_tmp = [_this select 1] execVM "pixLogistic\serverInsertItem.sqf";
	};
	"pvehPixlogisticDeleteItem" addPublicVariableEventHandler {
		private["_tmp"];
		_tmp = [_this select 1] execVM "pixLogistic\serverDeleteItem.sqf";
	};
	"pvehPixlogisticSaveAllItems" addPublicVariableEventHandler {
		pvehPixlogisticSaveAllItems = false;
		private["_tmp"];
		_tmp = [] execVM "pixLogistic\serverSaveAllItems.sqf";
	};
	
	/* -------- */
	/* Autosave */
	/* -------- */
	private["_tmp"];
	_tmp = [] execVM "pixLogistic\serverAutosave.sqf";
	
	pvPixLogisticServerInitialized = true;
	publicVariable "pvPixLogisticServerInitialized";
};

/* ---------------------------- */
/* Nur Client oder ServerClient */
/* ---------------------------- */
if (!isServer || !isDedicated) then
{
	pixLogisticObjectDialogContentSelection = 0;
	pixLogisticObjectDialogContentButton = 0;
	pixLogisticMovingObject = objNull;
	pixLogisitcActionKeyPressed = false;
	pixLogisitcAdminKeyPressed = false;
	pixLogisticDialogHqStore_AdminSpawn = false; 
	pixLogisticLastLoadOut = "Default.sqf";
	pixLogisticAdminHide = false;
	
	fn_pixLogistic_FoldBuilding = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_FoldBuilding.sqf";
	fn_pixLogistic_UnfoldBuilding = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_UnfoldBuilding.sqf";

		
	/* --------------------------- */
	/* EventHandler Initialisieren */
	/* --------------------------- */
	"pvehPixlogisticAllItemsSaved" addPublicVariableEventHandler {		
		player globalChat "pixLogistic: All items saved";
	};

	waitUntil { !(isNil "pvPixLogisticMoney") };
	waitUntil { !(isNil "pvPixLogisticTeamLeaderUIDs") };
	waitUntil { !(isNil "pvPixLogisticAdminUIDs") };
	waitUntil { !(isNil "pixlogisticRewardForZone") };
	waitUntil { !(isNil "pixlogisticRewardForExistingZone") };
			
	/* Das Spawn ist nicht zwingend notwendig, aber verhindert dass die initialisierung bockiert wird. */
	[] spawn {
		/* 	20=T 22=U 86=< 24=O 21=Z 220=rwin, 221=rapp 37=K*/
		waituntil {!(IsNull (findDisplay 46))};
		private["_tmp"];
		/*_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];*/
		_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if ((!pixLogisitcActionKeyPressed) && ((_this select 1 == 220) || (_this select 1 == 86))) then { pixLogisitcActionKeyPressed = true; _tmp = [] execVM 'pixlogistic\clientActionKey.sqf';}"];
		if ((getPlayerUID player in pvPixLogisticAdminUIDs) || (isServer && !isDedicated))then
		{
			_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if ((!pixLogisitcAdminKeyPressed) && (_this select 1 == 24)) then { pixLogisitcAdminKeyPressed = true; _tmp = [] execVM 'pixlogistic\clientAdminKey.sqf';}"];
		};
		
		waitUntil {alive player};
		if (side player == west) then
		{
			private["_tmp"]; 
			_tmp = [player, pixLogisticLastLoadOut] call compile preprocessFileLineNumbers "pixLogistic\dialogBarracks\applyLoadOut.sqf";			
		};
	};
};

/*-------------------------*/
/* Lift-Skripte aktivieren */
/*-------------------------*/
call compile preprocessFileLineNumbers "pixLogistic\lift\init.sqf";