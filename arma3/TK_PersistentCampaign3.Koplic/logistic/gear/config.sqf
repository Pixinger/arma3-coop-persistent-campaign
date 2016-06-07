// Der Verzeichnissname in dem die Loadouts gespeichert sind. // Parameter (0): Ausrüstung
cfgLogisticGear_LoadoutFolder = (paramsArray select 0); //{"loadoutsBW", "loadoutsNATO", "loadoutsAAF"};
if (pixDebug) then { cfgLogisticGear_LoadoutFolder = "loadoutsBW";};
diag_log format["INFO: cfgLogisticGear_LoadoutFolder: %1", cfgLogisticGear_LoadoutFolder];


// Das Objekt an dem das Barracks Menu aufgerufen werden kann.
cfgLogisticGear_MenuObjectClassnames = ["Land_Pallet_MilBoxes_F"];