//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Camps      //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private [
			"_CampTyp","_campBasic","_campAmmo","_campStatic","_campWall","_campObjInit",
			"_campUserObj","_campAddUnit","_campRandomObj","_Unit_Pool_C","_array"
		];

			_CampTyp = _this select 0;_array = [];

switch (_CampTyp) do
{
//-------------------------------------------------------------------------------------------------------------------------
	case 0:
	{
		_campBasic     = ["Flag_CSAT_F",["FirePlace_burning_f",15,10,0],["Land_BagBunker_Tower_F",10,0,0],["Logic",10,15,0],0];
		_campAmmo      = [["Box_East_Wps_F",40,2,0],["Box_East_WpsSpecial_F",40,0,0],["Box_East_Ammo_F",40,-2,0],["Box_East_Support_F",40,-4,0]];
		_campStatic    = [["O_Mortar_01_F",-7,25,0,"O_Soldier_F"],["O_Mortar_01_F",25,25,0,"O_Soldier_F"],["O_Mortar_01_F",25,-20,180,"O_Soldier_F"],["O_Mortar_01_F",-7,-20,180,"O_Soldier_F"]];
		_campAddUnit   = [];
		_campUserObj   = [];
		_campRandomObj = [];
		_campWall      = [];
		_campObjInit   = [[],[],[],[],[],[],[]];
	};
//-------------------------------------------------------------------------------------------------------------------------
	case 1:
	{
		_campBasic     = ["FlagPole_F",["Land_WaterTank_F",10,10,0],["Land_Cargo_HQ_V1_F",10,0,180],["Logic",22,-22,0],0];
		_campAmmo      = [["Box_East_Support_F",30,2,0],["Box_East_AmmoOrd_F",30,0,0],["Box_East_Ammo_F",30,-2,0],["Box_East_Wps_F",30,-4,0]];
		_campStatic    = [["O_MRAP_02_hmg_F",-7,15,45,"O_crew_F"],["O_Mortar_01_F",15,-10,180,"O_crew_F"],["O_Mortar_01_F",-7,-10,180,"O_crew_F"]];
		_campAddUnit   = [];
		_campUserObj   = [["Land_LampHarbour_F",8,-8,0]];
		_campRandomObj = [];
		_campWall      = [];
		_campObjInit   = [[],[],[],[],["_x lock true"],[],[]];
	};
//-------------------------------------------------------------------------------------------------------------------------
	case 2:		// OPFOR
	{
		_campBasic     = ["FlagPole_F",["Land_WaterTank_F",8,5,0],["Land_Cargo_House_V1_F",5,0,0],["Logic",10,15,0],0];
		_campAmmo      = [["Box_East_Support_F",10,2,0],["Box_East_AmmoOrd_F",10,0,0],["Box_East_Ammo_F",10,-2,0],["Box_East_Wps_F",10,-4,0]];
		_campStatic    = [["O_Mortar_01_F",-6,8,0,"O_crew_F"],["O_Mortar_01_F",6,8,0,"O_crew_F"],["O_MRAP_02_hmg_F",-7,-10,180,"O_crew_F"]];
		_campAddUnit   = [];
		_campUserObj   = [["Land_LampStreet_small_F",8,-3,0]];
		_campRandomObj = [];
		_campWall      = [];
		_campObjInit   = [[],[],[],[],["_x lock true"],[],[]];
	};
//-------------------------------------------------------------------------------------------------------------------------
	case 3:		// OPFOR  HQ with 4 x towers 2 x mortar    big walls closed on N side large opening S side 
	{
		_campBasic     = ["FlagPole_F",["Land_WaterTank_F",8,5,0],["Land_Cargo_HQ_V1_F",9,1,180],["Logic",8,-36,0],0];
		_campAmmo      = [["Box_East_Wps_F",7,-6,90],["Box_East_Ammo_F",5,6,0]];
		_campStatic    = [["O_Mortar_01_F",0,12,0,"O_crew_F"],["O_Mortar_01_F",14,12,0,"O_crew_F"], ["O_MRAP_02_hmg_F",-7,15,45,"O_crew_F"] ];
		_campAddUnit   = [];
		_campUserObj   = [
			["Land_Cargo_Patrol_V1_F",-7,26,180],["Land_Cargo_Patrol_V1_F",25,26,180],["Land_Cargo_Patrol_V1_F",24,-23,270],["Land_Cargo_Patrol_V1_F",-9,-23,90],
			["Land_Cargo_House_V1_F",2,20,0],["Land_Cargo_House_V1_F",9,20,0],
			["Land_Mil_ConcreteWall_F",-2,12,90],["Land_Mil_ConcreteWall_F",17,12,90],
			["Land_ClutterCutter_large_F",1,12,90],["Land_ClutterCutter_large_F",13,12,90],["Land_ClutterCutter_large_F",4,-7,0]
		];
		_campRandomObj = [];
		_campWall      = ["Land_Mil_WallBig_4m_F",[-10,30],[40,56,0],[0,2,4,2],[1,0.1],[0,0]];
		_campObjInit   = [[],[],[],[],[],[],[]];
	};
//-------------------------------------------------------------------------------------------------------------------------
	case 4:
	{
		_campBasic     = ["NULL"];
		_campAmmo      = [];
		_campStatic    = [];
		_campAddUnit   = [];
		_campUserObj   = [];
		_campRandomObj = [];
		_campWall      = [];
		_campObjInit   = [[],[],[],[],[],[],[]];
	};
//-------------------------------------------------------------------------------------------------------------------------
	Default {
				if(DAC_Basic_Value != 5) then
				{
					DAC_Basic_Value = 5;publicvariable "DAC_Basic_Value";
					hintc "Error: DAC_Config_Camps > No valid config number";
				};
				if(true) exitwith {};
			};
};

_array = [_campBasic,_campAmmo,_campStatic,_campAddUnit,_campUserObj,_campRandomObj,_campWall,_campObjInit];
_array