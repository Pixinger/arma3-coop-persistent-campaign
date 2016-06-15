// Der Verzeichnissname in dem die Loadouts gespeichert sind. // Parameter (0): Ausrüstung
private _folders = ["loadoutsBW", "loadoutsNATO"];
cfgLogisticGear_LoadoutFolder = _folders select (paramsArray select 0);
//if (pixDebug) then { cfgLogisticGear_LoadoutFolder = "loadoutsNATO";};
if (pixDebug) then { cfgLogisticGear_LoadoutFolder = "loadoutsBW";};
diag_log format["INFO: cfgLogisticGear_LoadoutFolder: %1", cfgLogisticGear_LoadoutFolder];

// Das Objekt an dem das Barracks Menu aufgerufen werden kann.
cfgLogisticGear_MenuObjectClassnames = ["Land_Pallet_MilBoxes_F"];






//--------------------------
// Runtime Variablen
runLogisticGear_LastMassResult = ["",0];