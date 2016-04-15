

/* Objekte die Bewegt und in Container/Fahrzeuge geladen werden k�nnen */
logisticMovableObjects = [
	"Land_CncWall1_F",
	"Land_CncWall4_F"
	];
	
/* Ben�tigter Ladeplatz */
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

logisticObjectsTransportable = [
	"Land_CratesWooden_F",
	"Land_PaperBox_closed_F",
	"Land_Sacks_goods_F",
	"Land_Bricks_V1_F",
	"Land_IronPipes_F"	
];

logisticObjectsMoveable = [
	"Land_CratesWooden_F",
	"Land_PaperBox_closed_F",
	"Land_Sacks_goods_F",
	"Land_Bricks_V1_F",
	"Land_IronPipes_F"	
];

logisticObjectsTransformable = [
	"Land_CratesWooden_F",
	"Land_PaperBox_closed_F",
	"Land_Sacks_goods_F",
	"Land_Bricks_V1_F",
	"Land_IronPipes_F"	
];

logisticTransporters = [
	"B_G_Van_01_transport_F",
	"B_G_Offroad_01_F",
	"B_Truck_01_box_F",
	"B_Truck_01_transport_F",
	"B_Truck_01_covered_F"
];

logisticTransporterConfig = [
	["B_G_Van_01_transport_F", 2, 0], // [classname, ladeplatzanzahl-Links, ladeplpatzanzahl-Rechts]
	["B_G_Offroad_01_F", 1, 0],
	["B_Truck_01_box_F", 4, 4],
	["B_Truck_01_transport_F", 4, 0],
	["B_Truck_01_covered_F", 4, 0]
];

	
// Land_CratesWooden_F: Sonstige G�ter
// Land_Pipes_small_F: Kleine Rohre auf Metall. Wie W�aschespinne
// Land_Pipes_large_F: Wie gro�e Fahne oder Abwasserrohre
// Land_IronPipes_F: Riesige Abwasserrohre
// Land_PaperBox_closed_F: TAP Essenskiste
// Land_Pallet_F: Leere Palette
// Land_CinderBlocks_F: YTong Steine
// Land_Bricks_V1_F,3,4: Steinstapel
// Land_Sack_F: Einzelner Sack
// Land_Sacks_goods_F: Mehrere S�cke mit Fr�chten und K�rnern
// Land_Sacks_heap_F: Sackstapel (evtl. mit K�rnern) ohne Palette

// Land_CargoBox_V1_F Kleiner Quadratischer Kontainer
// Land_Cargo20_grey_F 20 Fuss Kontainer
// Land_Cargo40_white_F 40 Fuss Kontainer

	
//[gettext (configFile >> "CfgVehicles" >> "Land_Bricks_V1_F" >> "displayName"), 4000, 0, "Land_Bricks_V1_F", gettext (configFile >> "CfgVehicles" >> "Land_Bricks_V1_F" >> "icon"), []]	
logisticResources = [ /* Bezeichnung, Kosten, SpawnTyp (>=0:hafen / 1>=:airport), Classname, Image, Content-Array */
		[gettext (configFile >> "CfgVehicles" >> "Land_Bricks_V1_F" >> "displayName"), 0, 0, "Land_Bricks_V1_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Land_CinderBlocks_F" >> "displayName"), 0, 0, "Land_CinderBlocks_F", "", []],
		[gettext (configFile >> "CfgVehicles" >> "Land_Pipes_large_F" >> "displayName"), 0, 0, "Land_Pipes_large_F", "", []]
	];
	
	
logisticStores = [
	[[8304.81,10055.3,0.00144196], "MyStore", []],
	[[100,100,0], "Name", ["Land_PaperBox_closed_F","Land_CratesWooden_F"]]
];