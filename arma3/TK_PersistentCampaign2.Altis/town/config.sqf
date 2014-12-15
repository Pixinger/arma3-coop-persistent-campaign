
// Klassennamen der bewohnbaren Häuser
pixTown_ConfigHomeClassnames = [ 
	"Land_i_house_big_01_v1_f",
	"Land_i_house_big_01_v2_f",
	"Land_i_house_big_01_v3_f",
	"Land_i_house_big_02_v1_f",
	"Land_i_house_big_02_v2_f",
	"Land_i_house_big_02_v3_f",
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
	"C_man_1_1_F"];
	
// Klassennamen der feindlichen Einheiten
pixTown_ConfigRedClassnames = [
	"I_G_Soldier_TL_F",
	"I_G_Soldier_lite_F"];

// Klassennamen der Warlords	
pixTown_ConfigWarlordClassnames = [
	"I_G_Soldier_TL_F",
	"I_G_Soldier_lite_F"];
	
// Klassenname für Stromoversorgung
pixTown_ConfigPowerClassnames = ["Land_PowerGenerator_F", "Land_spp_Panel_F", "Land_Portable_generator_F"];
pixTown_ConfigPowerValues = [100,100,10];
// Klassenname für Wasserversorgung	
pixTown_ConfigWaterClassname = "Land_WaterTank_F";
// Klassenname für Nahrungsversorgung
pixTown_ConfigFoodClassname = "Land_Sacks_heap_F";
pixTown_ConfigSaniClassname = "C_Van_01_box_F";//"B_Truck_01_medical_F"
	
// PPH = PerPeopleHour = pro Bürger in einer Stunde.
pixTown_ConfigRedGrowRatePPH = 0.04;            // Zuwachs in PPH.
pixTown_ConfigRedGrowPerBluKill = 0;            // Zuwachs pro Blu-Kill-
pixTown_ConfigRedGrowFactorPerWarlord = 1.5;     // Zuwachsfaktor für jeden Warlord.

// (Water + Food + Power + Uninfluenced) muss 1 ergeben. Andernfalls werden die Parameter automatisch korrigiert.
pixTown_ConfigCivGrowRatePPH = 0.05;             // Zuwachs in PPH.
pixTown_ConfigCivGrowFactorWater = 0.4;
pixTown_ConfigCivGrowFactorFood = 0.3;
pixTown_ConfigCivGrowFactorPower = 0.3;
pixTown_ConfigCivGrowFactorMinimum = 0.0;

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
