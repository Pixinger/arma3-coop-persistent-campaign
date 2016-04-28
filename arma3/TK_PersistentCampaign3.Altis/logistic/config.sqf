
logisticObjectsMoveableDefinitions = [
	// Statische Waffen
	["B_HMG_01_F",					[[0, 3, 1]] ],
	["B_HMG_01_high_F",				[[0, 3, 1]] ],
	["B_HMG_01_A_F",				[[0, 3, 1]] ],
	["B_GMG_01_F",					[[0, 3, 1]] ],
	["B_GMG_01_high_F",				[[0, 3, 1]] ],
	["B_GMG_01_A_F",				[[0, 3, 1]] ],
	["B_Mortar_01_F",				[[0, 3, 1]] ],
	["B_static_AA_F",				[[0, 3, 1]] ],
	["B_static_AT_F",				[[0, 3, 1]] ],
	
	// Ausrüstungskisten
	["B_CargoNet_01_ammo_F",		[[0, 3, 1]] ],

	// Objekte
	["Land_PortableLight_double_F",	[[0, 3, 1]] ],
	["Land_PaperBox_closed_F",		[[0, 3, 1]] ],
	["Land_Bricks_V1_F",			[[0, 3, 1]] ],
	["CargoNet_01_box_F",			[[0, 3, 1]] ],
	["CargoNet_01_barrels_F",		[[0, 3, 1]] ],
	["Land_Pipes_large_F",			[[0, 3, 1]] ],
	["Land_Pipes_small_F",			[[0, 3, 1]] ] 
	
	//["Land_Sacks_goods_F",			[[0, 3, 1]] ],
	//["Land_Sacks_heap_F",			[[0, 3, 1]] ],
];
//----------------------------------------------------------------------------------------------------
logisticObjectsMoveables = [];
logisticObjectsMoveableConfigs = [];
{
	logisticObjectsMoveables pushBack (_x select 0);
	logisticObjectsMoveableConfigs pushBack (_x select 1);
} foreach logisticObjectsMoveableDefinitions;
logisticObjectsMoveableDefinitions = nil; // Speicher freigeben
//----------------------------------------------------------------------------------------------------



// ["className", [grösse,[attach-offset],attach-rotation]]
logisticObjectsTransportableDefinitions = [
	// Ausrüstungskisten
	["B_CargoNet_01_ammo_F",	[1,	[0,  0, .3],	0] ],
	
	// Objekte
	["Land_PaperBox_closed_F",	[1,	[0,  0,  0],	0] ],
	["Land_Bricks_V1_F",		[1,	[0,  0,-.5],	0] ],
	["Land_Pipes_large_F",		[3,	[0, -2,-.5],	90] ],
	["Land_Pipes_small_F",		[2,	[0,-.8,-.5],	90] ],
	["CargoNet_01_box_F",		[1,	[0,  0, .1],	0] ],
	["CargoNet_01_barrels_F",	[1,	[0,  0, .1],	0] ]
//	["Land_Sacks_goods_F",		[1,	[0,  0,  0],	0] ],
];
//----------------------------------------------------------------------------------------------------
logisticObjectsTransportables = [];
logisticObjectsTransportablesConfig = [];
{
	logisticObjectsTransportables pushBack (_x select 0);
	logisticObjectsTransportablesConfig pushBack (_x select 1);
} foreach logisticObjectsTransportableDefinitions;
logisticObjectsTransportableDefinitions = nil; // Speicher freigeben
//----------------------------------------------------------------------------------------------------



logisticTransporterDefinitions = [
	["C_Van_01_box_F",			[[0,-1],[0,-2.5]] ],
	["C_Van_01_transport_F",	[[0,-1],[0,-2.5]] ],
	["B_Truck_01_box_F",		[[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4]] ],
	["B_Truck_01_transport_F",	[[0,0],[0,-1.5],[0,-3]] ],
	["B_Truck_01_covered_F",	[[0,0],[0,-1.5],[0,-3]] ]
];
//----------------------------------------------------------------------------------------------------
logisticTransporters = [];
logisticTransporterConfigs = [];
{
	logisticTransporters pushBack (_x select 0);
	logisticTransporterConfigs pushBack (_x select 1);
} foreach logisticTransporterDefinitions;
logisticTransporterDefinitions = nil; // Speicher freigeben
//----------------------------------------------------------------------------------------------------




// ["className", [attachpoint, attachrotation, detachheight, buildspeed, requiredResources] ]  ||  requiredResources = [[classname1, quantity1], [classname2, quantity2], ...];
logisticBuildableDefinitions = [
	["Land_PortableLight_double_F",	[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 25]] ]],
	["Land_BagFence_Long_F",		[[0,3,1], 0, -.9, 1, 	[["CraterLong_small", 5]] ]],
	["Land_HBarrier_1_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 25]] ]],
	["Land_HBarrier_3_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 75]] ]],
	["Land_HBarrier_5_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 125]] ]],
	["Land_HBarrier_Big_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 100]] ]],
	["Land_HBarrierTower_F",		[[0,3,1], 0, -2.0, 1, 	[["CraterLong_small", 200]] ]],
	["Land_CncBarrier_F",			[[0,3,1], 0, -.6, 1, 	[["Land_Bricks_V1_F", 25]] ]],
	["Land_CncBarrier_stripes_F",	[[0,3,1], 0, -.6, 1, 	[["Land_Bricks_V1_F", 25]] ]],
	["Land_CncBarrierMedium_F",		[[0,3,1], 0, -1.6, 1, 	[["Land_Bricks_V1_F", 50]] ]],
	["Land_CncBarrierMedium4_F",	[[0,3,1], 0, -1.6, 1, 	[["Land_Bricks_V1_F", 50]] ]],
	["Land_Mil_WallBig_4m_F",		[[0,3,1], 0, -3.5, 1, 	[["Land_Bricks_V1_F", 150], 	["Land_Pipes_large_F", 10]] ]],
	["Land_Mil_WallBig_Corner_F",	[[0,3,1], 0, -3.5, 1, 	[["Land_Bricks_V1_F", 150], 	["Land_Pipes_large_F", 10]] ]],
	["Land_CncWall1_F",				[[0,3,2], 0, -3.5, 1, 	[["Land_Bricks_V1_F", 25], 		["Land_Pipes_large_F", 10]] ]],
	["Land_CncWall4_F",				[[0,3,2], 0, -3.5, 1, 	[["Land_Bricks_V1_F-", 100], 	["Land_Pipes_large_F", 40]] ]]
];
//----------------------------------------------------------------------------------------------------
logisticBuildables = [];
logisticBuildableConfigs = [];
{
	logisticBuildables pushBack (_x select 0);
	logisticBuildableConfigs pushBack (_x select 1);
} foreach logisticBuildableDefinitions;
logisticBuildableDefinitions = nil; // Speicher freigeben
//----------------------------------------------------------------------------------------------------


// [classname, [attachpoint ]]
logisticHaulerDefinitions = [
	["B_Truck_01_mover_F", [[0,0,0]]]
];
//----------------------------------------------------------------------------------------------------
logisticHaulers = [];
logisticHaulerConfigs = [];
{
	logisticHaulers pushBack (_x select 0);
	logisticHaulerConfigs pushBack (_x select 1);
} foreach logisticHaulerDefinitions;
logisticHaulerDefinitions = nil; // Speicher freigeben
//----------------------------------------------------------------------------------------------------



// [classname, [attachpoint, attachrotation ]]
logisticHaulableDefinitions = [
	["B_Truck_01_box_F", [[0,0,0], 0]]
];
//----------------------------------------------------------------------------------------------------
logisticHaulables = [];
logisticHaulableConfigs = [];
{
	logisticHaulables pushBack (_x select 0);
	logisticHaulableConfigs pushBack (_x select 1);
} foreach logisticHaulableDefinitions;
logisticHaulableDefinitions = nil; // Speicher freigeben
//----------------------------------------------------------------------------------------------------
