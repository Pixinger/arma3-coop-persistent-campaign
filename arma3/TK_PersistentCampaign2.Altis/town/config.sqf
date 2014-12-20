// Klassenname das Town-Objektes im Editor.
pixTown_ConfigObjectClassname = "Land_VRGoggles_01_F";

// Klassennamen der bewohnbaren Häuser
pixTown_ConfigHomeClassnames = [ 
	"Land_i_house_big_01_v1_f",
	"Land_i_house_big_01_v2_f",
	"Land_i_house_big_01_v3_f",
	"Land_i_House_Big_02_V1_F",
	"Land_i_House_Big_02_V2_F",
	"Land_i_House_Big_02_V3_F",
	"Land_i_addon_02_v1_f",
	"Land_i_stone_shed_v1_f",
	"Land_i_stone_shed_v2_f",
	"Land_u_shop_01_v1_f",
	"Land_u_house_big_02_v1_f",
	"Land_u_house_big_01_v1_f",
	"Land_u_house_small_02_v1_f",
	"Land_u_house_small_02_v2_f",
	"Land_u_house_small_02_v3_f",
	"Land_i_stone_housesmall_v1_f",
	"Land_i_stone_housebig_v1_f",
	"Land_i_Shop_01_V2_F",
	"Land_i_house_small_01_v1_f",
	"Land_i_house_small_01_v2_f",
	"Land_i_house_small_02_v1_f",
	"Land_i_house_small_02_v2_f",
	"Land_i_house_small_02_v3_f"];
	
// Klassennamen der zivilien Einheiten
pixTown_ConfigCivClassnames = [
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
	"C_man_p_shorts_4_F_asia",
	"C_journalist_F",
	"C_Orestes",
	"C_Nikos",
	"C_Nikos_aged"];
	
// Klassennamen der feindlichen Einheiten
pixTown_ConfigRedClassnames = [
	"I_G_Soldier_F",
	"I_G_Soldier_lite_F",
	"I_G_Soldier_SL_F",
	"I_G_Soldier_TL_F",
	"I_G_Soldier_AR_F",
	"I_G_medic_F",
	"I_G_engineer_F",
	"I_G_Soldier_exp_F",
	"I_G_Soldier_GL_F",
	"I_G_Soldier_M_F",
	"I_G_Soldier_LAT_F",
	"I_G_Soldier_A_F",
	"I_G_officer_F",
	"i_g_soldier_unarmed_f",
	"i_g_survivor_F"];

// Klassennamen der Warlords	
pixTown_ConfigWarlordClassnames = [
	"I_officer_F",
	"I_Story_Colonel_F"];
	
// Klassenname für Stromoversorgung
pixTown_ConfigPowerClassnames = ["Land_PowerGenerator_F", "Land_spp_Panel_F", "Land_Portable_generator_F"];
pixTown_ConfigPowerValues = [100,100,10];
// Klassenname für Wasserversorgung	
pixTown_ConfigWaterClassname = "Land_WaterTank_F";
// Klassenname für Nahrungsversorgung
pixTown_ConfigFoodClassname = "Land_Sacks_heap_F";
pixTown_ConfigSaniClassname = "B_Truck_01_medical_F";//"B_Truck_01_medical_F" "C_Van_01_box_F"
pixTown_ConfigReSupplyClassnames = ["C_Boat_Civil_04_F"];
	
// PPH = PerPeopleHour = pro Bürger in einer Stunde.
pixTown_ConfigRedGrowRatePPH = 0.04;            // Mindest Zuwachs in PPH.
pixTown_ConfigRedGrowRateMoodLimit = 0.01;		// GrowRatePPH (siehe oben) wird nur angewand, wenn (_townMood < GrowRateMoodLimit) ist.
pixTown_ConfigRedGrowPerBluKill = 0;            // Zuwachs pro Blu-Kill-
pixTown_ConfigRedGrowFactorPerWarlord = 0.5;     // Zuwachsfaktor für jeden Warlord, berechnet: _factor = 1 + (pixTown_ConfigRedGrowFactorPerWarlord * warlordCount) 

pixTown_ConfigCivGrowRatePPH = 0.05;            // Maximaler Zuwachs in PPH. (wird von den GrowFactoren beeinflust. Sind alle optimal (=1), dann wird das hier angegebene Wachstum erreicht.
pixTown_ConfigCivGrowFactorWater = 0.5;			// Anteil der Wasserversorgung am Gesamtwachstum
pixTown_ConfigCivGrowFactorFood = 0.5;			// Anteil der Nahrungsversorgung am Gesamtwachstum
pixTown_ConfigCivGrowFactorPower = 0.0;			// Anteil der Stromversorgung am Gesamtwachstum
pixTown_ConfigCivGrowFactorMinimum = 0.0;		// Anteil des minimalen Wachstums (also immer vorliegend).
// (Water + Food + Power + Minimum) muss 1 ergeben. Andernfalls werden die Parameter automatisch korrigiert.

pixTown_ConfigFoodConsumptionPPH = 0.2;             // Nahrungsverbrauch in PPH.
if (pixDebug) then { pixTown_ConfigFoodConsumptionPPH = 0.05; };
pixTown_ConfigWaterConsumptionPPH = 0.2;            // Wasserverbrauch in PPH.
if (pixDebug) then { pixTown_ConfigWaterConsumptionPPH = 0.05; };
pixTown_ConfigPowerConsumptionPPH = 0.2;            // Stromverbrauch in PPH.
if (pixDebug) then { pixTown_ConfigPowerConsumptionPPH = 0.05; };

pixTown_ConfigInjuredGrowFactorPPH = 0;		  // Zuwachs an verletzten in PPH.

// Conversion Factors
pixTown_ConfigMaxCiv2RedConversionPPH = 0.05;     // Maximale Konvertierungen von Civ zu Red in PPH
pixTown_ConfigMaxRed2CivConversionPPH = 0.05;     // Maximale Konvertierungen von Red zu Civ in PPH

// Angaben wie die Stimmung bei bestimmten Events beinflusst wird.
pixTown_ConfigMoodPerCivWater = 0.01;
pixTown_ConfigMoodPerCivFood = 0.01;
pixTown_ConfigMoodPerCivPower = 0.5;
pixTown_ConfigMoodPerCivKill = -0.2;
pixTown_ConfigMoodPerRedKill = 0.01;
pixTown_ConfigMoodPerRedArrest = 0.1;
pixTown_ConfigMoodPerHouseSearchCiv = -0.1;
pixTown_ConfigMoodPerHouseSearchRed = 0.05;

// PH = PerHour = pro Stunde
pixTown_ConfigMoodSlabLevelPH = (1.0 / 15.0); // 15 Stunden

// Grenzen ab wann Bewegungen in der Stadt beginnen
pixTown_ConfigRedLeaveTown = 10;  

pixTown_ConfigMainLoopSleep = 30;
if (pixDebug) then { pixTown_ConfigMainLoopSleep = 10; };


// ------------------------------------------------------------
// Überprüfen der Configuration
if (pixTown_ConfigCivGrowFactorWater > 1.0) then { pixTown_ConfigCivGrowFactorWater = 1.0; };
if (pixTown_ConfigCivGrowFactorWater + pixTown_ConfigCivGrowFactorFood > 1.0) then { pixTown_ConfigCivGrowFactorFood = 1.0 - pixTown_ConfigCivGrowFactorWater; };
if (pixTown_ConfigCivGrowFactorWater + pixTown_ConfigCivGrowFactorFood + pixTown_ConfigCivGrowFactorPower > 1.0) then { pixTown_ConfigCivGrowFactorPower = 1.0 - (pixTown_ConfigCivGrowFactorWater + pixTown_ConfigCivGrowFactorFood); };
pixTown_ConfigCivGrowFactorMinimum = 1.0 - (pixTown_ConfigCivGrowFactorWater + pixTown_ConfigCivGrowFactorFood + pixTown_ConfigCivGrowFactorPower);
