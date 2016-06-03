townDbPrefix = "PC3TOWN";
townTownCount = 24;
townSupplySearchRadius = 500;
townWalkRadius = 75;
townSupplyClassnames = [
	"Land_Sacks_heap_F",
	"Land_WaterBarrel_F"
	];

townCivClassnames = [
	"C_man_1_1_F",
	"C_man_1_2_F",
	"C_man_1_3_F",
	"C_man_polo_1_F_afro",
	"C_man_polo_1_F_euro",
	"C_man_polo_1_F_asia",
	"C_man_polo_2_F_afro",
	"C_man_polo_2_F_euro",
	"C_man_polo_2_F_asia",
	"C_man_polo_3_F_afro",
	"C_man_polo_3_F_euro",
	"C_man_polo_3_F_asia",
	"C_man_polo_4_F_afro",
	"C_man_polo_4_F_euro",
	"C_man_polo_4_F_asia",
	"C_man_polo_5_F_afro",
	"C_man_polo_5_F_euro",
	"C_man_polo_5_F_asia",
	"C_man_polo_6_F_afro",
	"C_man_polo_6_F_euro",
	"C_man_polo_6_F_asia",
	"C_man_p_fugitive_F_afro",
	"C_man_p_fugitive_F_euro",
	"C_MAN_P_FUGITIVE_F_ASIA",
	"C_man_w_worker_F",
	"C_man_hunter_1_F",
	"C_man_p_shorts_1_F_afro",
	"C_man_p_shorts_1_F_euro",
	"C_man_p_shorts_1_F_asia",
	"C_man_p_shorts_2_F_afro",
	"C_man_p_shorts_2_F_euro",
	"C_man_p_shorts_2_F_asia",
	"C_man_p_shorts_3_F_afro",
	"C_man_p_shorts_3_F_euro",	
	"C_man_p_shorts_3_F_asia",
	"C_man_p_shorts_4_F_afro",
	"C_man_p_shorts_4_F_euro",
	"C_man_p_shorts_4_F_asia"
	];
// ------------------------------------------------------------------------------
// Runtime Variablen initialisieren (nicht verändern!)
townActive = [];
townInfos = [];
townActiveCounter = 0;
townInitCompleted = false;
townDatabaseSaving = false;



// Klassenname für Wasserversorgung	
pixTown_ConfigWaterClassname = "Land_WaterTank_F";
// Klassenname für Nahrungsversorgung
pixTown_ConfigFoodClassname = "Land_Sacks_heap_F";
pixTown_ConfigSaniClassname = "I_Truck_02_medical_F";
// Klassenname das Town-Objektes im Editor.
pixTown_ConfigObjectClassname = "Land_VRGoggles_01_F";

// Basisnamen	
pixTown_ConfigBaseClassCiv = "Civilian_F";
pixTown_ConfigBaseClassRed = "SoldierEB";
pixTown_ConfigBaseClassBlu = "SoldierGB";
pixTown_ConfigSideCiv = civilian;
pixTown_ConfigSideRed = east;
pixTown_ConfigSideBlu = west;

// Klassennamen der zivilien Einheiten
