logisticObjectsMoveables = [
	"Land_CratesWooden_F",
	"Land_PaperBox_closed_F",
	"Land_Sacks_goods_F",
	"Land_Bricks_V2_F",
	"B_CargoNet_01_ammo_F",
	"CargoNet_01_box_F",
	"CargoNet_01_barrels_F",
	"Land_Pipes_large_F",
	"Land_Pipes_small_F"	
];
logisticObjectsMoveableConfigs = [
	[[0, 5, 1]], //"Land_CratesWooden_F",
	[[0, 5, 1]], //"Land_PaperBox_closed_F",
	[[0, 5, 1]], //"Land_Sacks_goods_F",
	[[0, 5, 1]], //"Land_Bricks_V2_F",
	[[0, 5, 1]], //"B_CargoNet_01_ammo_F",
	[[0, 5, 1]], //"CargoNet_01_box_F",
	[[0, 5, 1]], //"CargoNet_01_barrels_F",
	[[0, 5, 1]], //"Land_Pipes_large_F",
	[[0, 5, 1]] //"Land_Pipes_small_F"	
];

logisticObjectsTransportables = [
	"Land_CratesWooden_F",
	"Land_PaperBox_closed_F",
	"Land_Sacks_goods_F",
	"Land_Bricks_V2_F",
	"B_CargoNet_01_ammo_F",
	"CargoNet_01_box_F",
	"CargoNet_01_barrels_F",
	"Land_Pipes_large_F",
	"Land_Pipes_small_F"	
];
// [grösse,[attach-offset],attach-rotation]
logisticObjectsTransportablesConfig = [
	[1,[0,  0,  0],0], 		//"Land_CratesWooden_F",
	[1,[0,  0,  0],0], 		//"Land_PaperBox_closed_F",
	[1,[0,  0,  0],0], 		//"Land_Sacks_goods_F",
	[1,[0,  0,-.5],0], 		//"Land_Bricks_V1_F",
	[1,[0,  0, .3],0], 		//"B_CargoNet_01_ammo_F",
	[1,[0,  0, .1],0], 		//"CargoNet_01_box_F",
	[1,[0,  0, .1],0], 		//"CargoNet_01_barrels_F",
	[3,[0, -2,-.5],90], 	//"Land_Pipes_large_F"	
	[2,[0,-.8,-.5],90]  	//"Land_Pipes_small_F"	
];

logisticTransporters = [
	"C_Van_01_box_F",
	"C_Van_01_transport_F",
	"B_Truck_01_box_F",
	"B_Truck_01_transport_F",
	"B_Truck_01_covered_F"
];
logisticTransporterConfigs = [
	[[0,-1],[0,-2.5]],													//"C_Van_01_box_F",
	[[0,-1],[0,-2.5]],													//"C_Van_01_transport_F",
	[[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4],[0,-.4]],	//"B_Truck_01_box_F",
	[[0,0],[0,-1.5],[0,-3]],											//"B_Truck_01_transport_F",
	[[0,0],[0,-1.5],[0,-3]]												//"B_Truck_01_covered_F"
];

logisticBuildables = [
	"Land_HBarrier_1_F",
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",
	"Land_HBarrier_Big_F",
	"Land_HBarrierTower_F",
	"Land_CncBarrier_F",
	"Land_CncBarrier_stripes_F",
	"Land_CncBarrierMedium_F",
	"Land_CncBarrierMedium4_F",
	"Land_Mil_WallBig_4m_F",
	"Land_Mil_WallBig_Corner_F",
	"Land_BagFence_Long_F",
	"Land_CncWall1_F",
	"Land_CncWall4_F"
];
// [attachpoint, attachrotation, detachheight, buildspeed, requiredResources]
// requiredResources = [[classname1, quantity1], [classname2, quantity2], ...];
logisticBuildableConfigs = [
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_HBarrier_1_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_HBarrier_3_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_HBarrier_5_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_HBarrier_Big_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_HBarrierTower_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_CncBarrier_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_CncBarrier_stripes_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_CncBarrierMedium_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_CncBarrierMedium4_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_Mil_WallBig_4m_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_Mil_WallBig_Corner_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]] ],		//"Land_BagFence_Long_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 25], ["Land_Pipes_large_F", 10]] ],		//"Land_CncWall1_F",
	[[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 100], ["Land_Pipes_large_F", 40]] ]		//"Land_CncWall4_F"
];