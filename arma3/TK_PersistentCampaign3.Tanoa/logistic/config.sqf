call compile preprocessFileLineNumbers "logistic\db\config.sqf";
call compile preprocessFileLineNumbers "logistic\gear\config.sqf";

logisticObjectHQClassname = "Land_DataTerminal_01_F";
cfgLogisticRepairObjectClassname = "B_Slingload_01_Repair_F";
cfgLogisticTakePrisonClassname = "SoldierGB";
cfgLogisticTakePrisonOfficerClassname = "I_C_Soldier_Camo_F";

//!! Achtung! Auch in der DP config eintragen!
// ["className", [[attach-offset]]]
private _logisticObjectsMoveableDefinitions = [
	// Statische Waffen
	["B_HMG_01_F",					[[0, 3, 1.75]] ],
	["B_HMG_01_high_F",				[[0, 3, 1.75]] ],
	["B_HMG_01_A_F",				[[0, 3, 1.75]] ],
	["B_GMG_01_F",					[[0, 3, 1.75]] ],
	["B_GMG_01_high_F",				[[0, 3, 1.75]] ],
	["B_GMG_01_A_F",				[[0, 3, 1.75]] ],
	["B_Mortar_01_F",				[[0, 3, 1.75]] ],
	["B_static_AA_F",				[[0, 3, 1.75]] ],
	["B_static_AT_F",				[[0, 3, 1.75]] ],
	["B_T_HMG_01_F",				[[0, 3, 1.75]] ],
	["B_T_GMG_01_F",				[[0, 3, 1.75]] ],
	["B_T_Mortar_01_F",				[[0, 3, 1.75]] ],
	["B_T_Static_AA_F",				[[0, 3, 1.75]] ],
	["B_T_Static_AT_F",				[[0, 3, 1.75]] ],
	
	// Ausrüstungskisten
	["B_CargoNet_01_ammo_F",		[[0, 3, 1]] ],

	// Objekte
	["Land_PortableLight_double_F",	[[0, 3, 1.75]] ],	
	//["CargoNet_01_box_F",			[[0, 3, 1]] ],
	//["CargoNet_01_barrels_F",		[[0, 3, 1]] ],
	["Land_PaperBox_open_full_F",	[[0, 3, 1]] ],
	["Land_PaperBox_closed_F",		[[0, 3, 1]] ],
	["Land_Pipes_small_F",			[[0, 3, 1]] ], 
	["Land_Pipes_large_F",			[[0, 3, 1]] ], 
	["Land_DataTerminal_01_F",		[[0, 3, 1]] ],
	["Land_Pallet_MilBoxes_F",		[[0, 3, 1]] ],
	["Land_Sacks_heap_F",			[[0, 3, 1]] ],
	["Land_WaterBarrel_F",			[[0, 3, 1]] ],
	["Land_Bricks_V1_F",			[[0, 3, 1]] ],
	["Land_Timbers_F",				[[0, 3, 1]] ]
	
	//["Land_Sacks_goods_F",			[[0, 3, 1]] ],
	//["Land_Sacks_heap_F",			[[0, 3, 1]] ],
];
//----------------------------------------------------------------------------------------------------
logisticObjectsMoveables = [];
logisticObjectsMoveableConfigs = [];
{
	logisticObjectsMoveables pushBack (_x select 0);
	logisticObjectsMoveableConfigs pushBack (_x select 1);
} foreach _logisticObjectsMoveableDefinitions;
//----------------------------------------------------------------------------------------------------


//!! Achtung! Auch in der DP config eintragen!
// ["className", [grösse,[attach-offset],attach-rotation]]
private _logisticObjectsTransportableDefinitions = [
	// Ausrüstungskisten
	//["CargoNet_01_box_F",		[1,	[0,  0, .1],	0] ],
	
	// Objekte
	//["CargoNet_01_barrels_F",	[1,	[0,  0, .1],	0] ],
	//["Land_Sacks_goods_F",		[1,	[0,  0,  0],	0] ],
	["B_CargoNet_01_ammo_F",		[1,	[0,  0, .3],	0] ],
	["Land_PaperBox_open_full_F",	[1,	[0,  0,  0],	0] ],
	["Land_PaperBox_closed_F",		[1,	[0,  0,  0],	0] ],
	["Land_Pipes_small_F",			[2,	[0,-.8,-.5],	90] ],	
	["Land_Pipes_large_F",			[3,	[0, -2,-.5],	90] ],
	["Land_DataTerminal_01_F",		[1,	[0,  0, .3],	0] ],
	["Land_Pallet_MilBoxes_F",		[1,	[0,  0, .3],	0] ],
	["Land_Sacks_heap_F",			[1,	[0,  0,  0],	0] ],
	["Land_WaterBarrel_F",			[1,	[0,  0,  0],	0] ],
	["Land_Bricks_V1_F",			[1,	[0,  0,-.5],	0] ],
	["Land_Timbers_F",				[3,	[0, -2,  0],	0] ]
];
//----------------------------------------------------------------------------------------------------
logisticObjectsTransportables = [];
logisticObjectsTransportablesConfig = [];
{
	logisticObjectsTransportables pushBack (_x select 0);
	logisticObjectsTransportablesConfig pushBack (_x select 1);
} foreach _logisticObjectsTransportableDefinitions;
//----------------------------------------------------------------------------------------------------


//!! Achtung! Auch in der DP config eintragen!
private _logisticTransporterDefinitions = [
	["B_T_VTOL_01_vehicle_F",		[[0,4.5,-5],[0,3,-5],[0,1.5,-5],[0,0,-5],[0,-1.5,-5]] ],
	["B_T_VTOL_01_infantry_F",		[[0,4.5,-5],[0,3,-5],[0,1.5,-5],[0,0,-5],[0,-1.5,-5]] ],
	["C_Van_01_box_F",				[[0,-1,0],[0,-2.5,0]] ],
	["C_Van_01_transport_F",		[[0,-1,0],[0,-2.5,0]] ],
	["B_T_Truck_01_box_F",			[[0,-.4,0],[0,-.4,0],[0,-.4,0],[0,-.4,0],[0,-.4,0],[0,-.4,0],[0,-.4,0],[0,-.4,0]] ],
	["B_T_Truck_01_transport_F",	[[0,0,0],[0,-1.5,0],[0,-3,0]] ],
	["B_T_Truck_01_covered_F",		[[0,0,0],[0,-1.5,0],[0,-3,0]] ]
];
//----------------------------------------------------------------------------------------------------
logisticTransporters = [];
logisticTransporterConfigs = [];
{
	logisticTransporters pushBack (_x select 0);
	logisticTransporterConfigs pushBack (_x select 1);
} foreach _logisticTransporterDefinitions;
//----------------------------------------------------------------------------------------------------




//!! Achtung! Auch in der DP config eintragen!
// ["className", [attachpoint(array), attachrotation, detachOffset(array), buildspeed, requiredResources(array)] ]  ||  requiredResources = [[classname1, quantity1], [classname2, quantity2], ...];
private _logisticBuildableDefinitions = [
	//["Land_CncBarrier_F",			[[0,3,1], 0, -.6, 1, 	[["Land_Bricks_V1_F", 25]] ]],
	//["Land_CncBarrier_stripes_F",	[[0,3,1], 0, -.6, 1, 	[["Land_Bricks_V1_F", 25]] ]],
	//["Land_CncBarrierMedium_F",		[[0,3,1], 0, -1.6, 1, 	[["Land_Bricks_V1_F", 50]] ]],
	//["Land_CncBarrierMedium4_F",	[[0,3,1], 0, -1.6, 1, 	[["Land_Bricks_V1_F", 50]] ]],
	//["Land_Mil_WallBig_Corner_F",	[[0,3,1], 0, -3.5, 1, 	[["Land_Bricks_V1_F", 150], 	["Land_Pipes_large_F", 10]] ]],
	//["Land_CncWall1_F",				[[0,3,2], 0, -3.5, 1, 	[["Land_Bricks_V1_F", 25], 		["Land_Pipes_large_F", 10]] ]],
	//["Land_CncWall4_F",				[[0,3,2], 0, -3.5, 1, 	[["Land_Bricks_V1_F-", 100], 	["Land_Pipes_large_F", 40]] ]],
	//["Land_Cargo_House_V1_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 25]] ]],
	//["Land_Cargo_HQ_V1_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 25]] ]],
	//["Land_HBarrier_1_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 25]] ]],
	//["Land_HBarrier_Big_F",			[[0,3,1], 0, -1.4, 1, 	[["CraterLong_small", 100]] ]],
	//["Land_HBarrierTower_F",		[[0,3,1], 0, -2.0, 1, 	[["CraterLong_small", 200]] ]],	

	//Land_HBarrier_01_wall_6_green_F
	//Land_HBarrier_01_wall_corner_green_F
	//Land_HBarrier_01_wall_4_green_F	

	//["Land_BagFence_Long_F",			[[0,   3, 0.7], 0, [0, 0, -0.8], 1.5,	[["CraterLong_small", 5]] 		]],	
	//["Land_HBarrier_1_F",				[[0, 2.5, 0.8], 0, [0, 0, -1.2], 1.8,	[["CraterLong_small", 20],		["Land_PaperBox_closed_F", 1]]	]],
	//["Land_HBarrier_3_F",				[[0,   4, 0.8], 0, [0, 0, -1.2], 1.5,	[["CraterLong_small", 60],		["Land_PaperBox_closed_F", 3]]	]],
	//["Land_HBarrier_5_F",				[[0,   6, 0.8], 0, [0, 0, -1.2], 1.2,	[["CraterLong_small", 100],		["Land_PaperBox_closed_F", 5]]	]],
	//["Land_BagBunker_Small_F",		[[0,   6, 1.0], 0, [0, 0, -1.6], 1.2, 	[["CraterLong_small", 50], 		["Land_Timbers_F", 10], 	["Land_Bricks_V1_F", 10]] 	]],
	//["Land_BagBunker_Large_F",		[[0,  12, 1.0], 0, [0, 0, -2.1], 1.2,	[["CraterLong_small", 200], 	["Land_Timbers_F", 100], 	["Land_Bricks_V1_F", 100]] 	]]

	["Land_PortableLight_double_F",		[[0,   3, 1.0], 0, [0, 0, -1.4], 1.0, 	[["Land_Pipes_small_F", 5],		["Land_PaperBox_closed_F", 25]] ]],	
	["Land_BarGate_F",					[[0,   5, 4.0], 0, [0, 0, -0.9], 0.7,	[["Land_Pipes_small_F", 5],		["Land_Timbers_F", 10]]			]],
	
	["Land_Mil_WallBig_4m_F",			[[0,   3, 1.0], 0, [0, 0, -3.5], 1.0, 	[["Land_Bricks_V1_F", 150], 	["Land_Pipes_large_F", 10]]     ]],
	["Land_BagFence_01_long_green_F",	[[0,   3, 0.7], 0, [0, 0, -0.8], 1.5,	[["CraterLong_small", 5]] 		]],	
	["Land_HBarrier_01_line_1_green_F",	[[0, 2.5, 0.8], 0, [0, 0, -1.2], 1.8,	[["CraterLong_small", 20],		["Land_PaperBox_closed_F", 1]]	]],
	["Land_HBarrier_01_line_3_green_F",	[[0,   4, 0.8], 0, [0, 0, -1.2], 1.5,	[["CraterLong_small", 60],		["Land_PaperBox_closed_F", 3]]	]],
	["Land_HBarrier_01_line_5_green_F",	[[0,   6, 0.8], 0, [0, 0, -1.2], 1.2,	[["CraterLong_small", 100],		["Land_PaperBox_closed_F", 5]]	]],
	["Land_BagBunker_01_small_green_F",	[[0,   6, 1.0], 0, [0, 0, -1.6], 1.2, 	[["CraterLong_small", 50], 		["Land_Timbers_F", 10], 	["Land_Bricks_V1_F", 10]] 	]],
	["Land_BagBunker_01_large_green_F",	[[0,  12, 1.0], 0, [0, 0, -2.1], 1.2,	[["CraterLong_small", 200], 	["Land_Timbers_F", 100], 	["Land_Bricks_V1_F", 100]] 	]]
];
//----------------------------------------------------------------------------------------------------
logisticBuildables = [];
logisticBuildableConfigs = [];
{
	logisticBuildables pushBack (_x select 0);
	logisticBuildableConfigs pushBack (_x select 1);
} foreach _logisticBuildableDefinitions;
//----------------------------------------------------------------------------------------------------


//!! Achtung! Auch in der DP config eintragen!
// [classname, [attachpoint ]]
private _logisticHaulerDefinitions = [
	["B_T_Truck_01_mover_F", [[0,0,0]]]
];
//----------------------------------------------------------------------------------------------------
logisticHaulers = [];
logisticHaulerConfigs = [];
{
	logisticHaulers pushBack (_x select 0);
	logisticHaulerConfigs pushBack (_x select 1);
} foreach _logisticHaulerDefinitions;
//----------------------------------------------------------------------------------------------------



//!! Achtung! Auch in der DP config eintragen!
// [classname, [attachpoint, attachrotation, towing ]]
private _logisticHaulableDefinitions = [
	["B_T_UAV_03_F", 				[[0,  -8, 0.0], 0, true]],
	["B_UAV_02_F", 					[[0,  -8, 0.0], 0, true]],
	["B_UAV_02_CAS_F", 				[[0,  -8, 0.0], 0, true]],

	["B_Slingload_01_Repair_F", 	[[0,  -2.7, 1], 0, false]],
	["B_Slingload_01_Cargo_F", 		[[0,  -2.7, 1], 0, false]],
	["B_Slingload_01_Fuel_F", 		[[0,  -2.7, 1], 0, false]],
	["B_Slingload_01_Ammo_F", 		[[0,  -2.7, 1], 0, false]],
	["B_Slingload_01_Medevac_F",	[[0,  -2.7, 1], 0, false]],

	["B_T_MRAP_02_F", 				[[0,  -8, 0.85], 0, true]],
	["B_T_MRAP_02_gmg_F",			[[0,  -8, 0.85], 0, true]],
	["B_T_MRAP_02_hmg_F",			[[0,  -8, 0.85], 0, true]],
	["B_T_LSV_01_unarmed_F",		[[0,  -8, 0.85], 0, true]],
	["B_T_LSV_01_armed_F",			[[0,  -8, 0.85], 0, true]],
	["B_CTRG_LSV_01_light_F",		[[0,  -8, 0.85], 0, true]],	

	["B_T_APC_Tracked_01_CRV_F",	[[0,  -8, 0.85], 0, true]],
	["B_T_APC_Tracked_01_rcws_F",	[[0,  -8, 0.85], 0, true]],
	["B_T_APC_Wheeled_01_cannon_F",	[[0,  -8, 0.85], 0, true]],

	["I_C_Offroad_02_unarmed_F",	[[0,  -8, 0.85], 0, true]],
	["I_G_Offroad_01_F",			[[0,  -8, 0.85], 0, true]],
	["I_G_Offroad_01_armed_F",		[[0,  -8, 0.85], 0, true]],

	["C_Van_01_box_F", 				[[0,  -8, 0.0], 0, true]],
	["C_Van_01_transport_F", 		[[0,  -8, 0.0], 0, true]],
	["I_G_Van_01_transport_F", 		[[0,  -8, 0.0], 0, true]],	
	["B_T_Truck_01_box_F", 			[[0, -12, 0.5], 0, true]],
	["B_T_Truck_01_covered_F", 		[[0, -12, 0.5], 0, true]],
	["B_T_Truck_01_transport_F", 	[[0, -12, 0.5], 0, true]]
];
//----------------------------------------------------------------------------------------------------
logisticHaulables = [];
logisticHaulableConfigs = [];
{
	logisticHaulables pushBack (_x select 0);
	logisticHaulableConfigs pushBack (_x select 1);
} foreach _logisticHaulableDefinitions;
//----------------------------------------------------------------------------------------------------

//!! Achtung! Auch in der DP config eintragen!
// [classname, [storeClassnames, paymentClassname]]]
private _logisticSellablesDefinitions = [
	["I_C_Offroad_02_unarmed_F", 	[["Civilian"], ["Land_PaperBox_open_full_F","Land_PaperBox_open_full_F"]]],
	["I_G_Offroad_01_F",			[["Civilian"], ["Land_PaperBox_open_full_F","Land_PaperBox_open_full_F"]]],
	["I_G_Offroad_01_armed_F",		[["Civilian"], ["Land_PaperBox_open_full_F","Land_PaperBox_open_full_F"]]],
	["I_G_Van_01_transport_F",		[["Civilian"], ["Land_PaperBox_open_full_F","Land_PaperBox_open_full_F"]]]
];
//----------------------------------------------------------------------------------------------------
logisticSellables = [];
logisticSellablesConfigs = [];
{
	logisticSellables pushBack (_x select 0);
	logisticSellablesConfigs pushBack (_x select 1);
} foreach _logisticSellablesDefinitions;
//----------------------------------------------------------------------------------------------------

//!! Achtung! Auch in der DP config eintragen!
// [classname, [time, newClassname]]]
private _logisticRepairablesDefinitions = [
	["I_HMG_01_F", 			[30, "B_T_HMG_01_F"]],
	["I_HMG_01_high_F", 	[30, "B_HMG_01_high_F"]],
	["I_HMG_01_A_F", 		[30, "B_HMG_01_A_F"]],
	["I_GMG_01_F", 			[30, "B_T_GMG_01_F"]],
	["I_GMG_01_high_F", 	[30, "B_GMG_01_high_F"]],
	["I_GMG_01_A_F", 		[30, "B_GMG_01_A_F"]],
	["I_Mortar_01_F", 		[30, "B_T_Mortar_01_F"]],
	["I_static_AA_F", 		[30, "B_T_Static_AA_F"]],
	["I_static_AT_F", 		[30, "B_T_Static_AT_F"]]	
];
//----------------------------------------------------------------------------------------------------
logisticRepairables = [];
logisticRepairablesConfigs = [];
{
	logisticRepairables pushBack (_x select 0);
	logisticRepairablesConfigs pushBack (_x select 1);
} foreach _logisticRepairablesDefinitions;

// Automatisch alle Haulables reperaturfähig machen
{
	if (!(_x in logisticRepairables)) then
	{
		logisticRepairables pushBack _x;
		logisticRepairablesConfigs pushBack [120, _x];		
		diag_log format["Extending %1", _x];
	};
} foreach logisticHaulables;
//----------------------------------------------------------------------------------------------------

//!! Achtung! Auch in der DP config eintragen!
// [classname, [containerCount, duration]]]
private _logisticStripDownDefinitions = [
	["B_T_Truck_01_box_F",			[3, 60]],
	["B_T_Truck_01_covered_F",		[2, 60]],
	["B_T_Truck_01_transport_F",	[2, 60]],
	["B_T_Truck_01_mover_F",		[1, 60]]
];

//----------------------------------------------------------------------------------------------------
logisticStripDownContainers = ["B_Slingload_01_Cargo_F"];
logisticStripDownables = [];
logisticStripDownablesConfigs = [];
{
	logisticStripDownables pushBack (_x select 0);
	logisticStripDownablesConfigs pushBack (_x select 1);
} foreach _logisticStripDownDefinitions;
//----------------------------------------------------------------------------------------------------
logisticWorkAnimExit = true;