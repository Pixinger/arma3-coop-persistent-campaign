	"Land_CratesWooden_F",
	"Land_PaperBox_closed_F",
	"Land_Sacks_goods_F",
	"Land_Bricks_V1_F",
	"Land_IronPipes_F"	
// Land_CratesWooden_F: Sonstige Güter
// Land_Pipes_small_F: Kleine Rohre auf Metall. Wie Wäschespinne
// Land_Pipes_large_F: Wie grosse Fahne oder Abwasserrohre
// Land_IronPipes_F: Riesige Abwasserrohre
// Land_PaperBox_closed_F: TAP Essenskiste
// Land_Pallet_F: Leere Palette
// Land_CinderBlocks_F: YTong Steine
// Land_Bricks_V1_F,3,4: Steinstapel
// Land_Sack_F: Einzelner Sack
// Land_Sacks_goods_F: Mehrere Säcke mit Früchten und Körnern
// Land_Sacks_heap_F: Sackstapel (evtl. mit Körnern) ohne Palette

// Land_CargoBox_V1_F Kleiner Quadratischer Kontainer-
// Land_Cargo20_grey_F 20 Fuss Kontainer
// Land_Cargo40_white_F 40 Fuss Kontainer

	
//[gettext (configFile >> "CfgVehicles" >> "Land_Bricks_V1_F" >> "displayName"), 4000, 0, "Land_Bricks_V1_F", gettext (configFile >> "CfgVehicles" >> "Land_Bricks_V1_F" >> "icon"), []]	

//logisticResources = [ /* Bezeichnung, Kosten, SpawnTyp (>=0:hafen / 1>=:airport), Classname, Image, Content-Array */
//		[gettext (configFile >> "CfgVehicles" >> "Land_Bricks_V1_F" >> "displayName"), 0, 0, "Land_Bricks_V1_F", "", []],
//		[gettext (configFile >> "CfgVehicles" >> "Land_CinderBlocks_F" >> "displayName"), 0, 0, "Land_CinderBlocks_F", "", []],
//		[gettext (configFile >> "CfgVehicles" >> "Land_Pipes_large_F" >> "displayName"), 0, 0, "Land_Pipes_large_F", "", []]
//	];
	

logisticStores = [
	[[8304.81,10055.3,0.00144196], "MyStore", []],
	[[100,100,0], "Name", ["Land_PaperBox_closed_F","Land_CratesWooden_F"]]
];

logisticMovableObjects = [
	"Land_CncWall1_F",
	"Land_CncWall4_F"
	];
	
logisticMovableObjectsSize = [
	10, //"Land_CncWall1_F",
	40 	//"Land_CncWall4_F",
	];
	
logisticStoreObjects = [
	["Land_CratesWooden_F", 40],
	["Land_PaperBox_closed_F", 40],
	["Land_Sacks_goods_F", 40],
	["Land_Bricks_V1_F", 40],
	["Land_IronPipes_F", 40]	
];