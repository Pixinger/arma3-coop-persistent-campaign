[] spawn {
	waituntil{time > 1};
	waituntil {(DAC_Basic_Value > 0)};
	player sidechat "DAC_Basic_Value > 0";
};

[] spawn {
	waituntil{time > 1};
	player sidechat "time > 0";

	if (isServer) then
	{
		private["_maxZoneX"];
		_maxZoneX = 9;
		private["_maxZoneY"];
		_maxZoneY = 11;
		
		// Zum Testen weniger
		if (pixDebug) then 
		{
			_maxZoneX = 4;
			_maxZoneY = 4;
		};	
	
		private["_zoneId"];
		_zoneId = 0;
		for "_ix" from 1 to _maxZoneX do
		{
			for "_iy" from 1 to _maxZoneY do
			{
				private["_triggerName"];
				_triggerName = format["zx%1y%2", _ix, _iy];
				if (!isNil _triggerName) then
				{
					_zoneId = _zoneId + 1;
					if (pixDebug) then 
					{
						[	_triggerName,									// Triggername
							[_zoneId,1,0,0],								//[ZoneID, ZoneDisabled, ZoneEvents, NoMasterWaypoints]
							[1,1,2,2], 										//[INF_COUNT, INF_GROUP_SIZE, INF_WAYPOINTS_TOTAL, INF_WAYPOINTS_GROUP],
							[],												//[WHL_COUNT, WHL_GROUP_SIZE, WHL_WAYPOINTS_TOTAL, WHL_WAYPOINTS_GROUP],
							[],												//[TRK_COUNT, TRK_GROUP_SIZE, TRK_WAYPOINTS_TOTAL, TRK_WAYPOINTS_GROUP],
							[1,1,75,0,100,10,[zx1y1]], 	//[CAMP_COUNT, CAMP_GROUP_SIZE, CAMP_RADIUS, CAMP_VEHICLETYPE, CAMP_PERCENT, CAMP_RESPAWNS, CAMP_LINK],	
							[0,0,0,1,1] 									//[CFG_SIDE_ZONE, CFG_UNIT, CFG_BEHAVIOUR, CFG_CAMP, CFG_WAYPOINT]
						] spawn DAC_Zone;
					
						_markerName = createMarkerLocal [format["markername%1", _triggerName], getPos call compile _triggerName];
						_markerName setMarkerShapeLocal "ICON";
						_markerName setMarkerTypeLocal "o_inf";
						_markerName setMarkerSizeLocal [0.2, 0.2];
						_markerName setMarkerColorLocal "ColorBlue"; 
						_markerName setMarkerAlphaLocal 0.8;	
						_markerName setMarkerTextLocal _triggerName;
					}
					else
					{
						[	_triggerName,									// Triggername
							[_zoneId,1,0,0],								//[ZoneID, ZoneDisabled, ZoneEvents, NoMasterWaypoints]
							[2,3,10,5], 									//[INF_COUNT, INF_GROUP_SIZE, INF_WAYPOINTS_TOTAL, INF_WAYPOINTS_GROUP],
							[1,1,5,3],										//[WHL_COUNT, WHL_GROUP_SIZE, WHL_WAYPOINTS_TOTAL, WHL_WAYPOINTS_GROUP],
							[],												//[TRK_COUNT, TRK_GROUP_SIZE, TRK_WAYPOINTS_TOTAL, TRK_WAYPOINTS_GROUP],
							[1,1,75,0,100,10,[call compile _triggerName]], 	//[CAMP_COUNT, CAMP_GROUP_SIZE, CAMP_RADIUS, CAMP_VEHICLETYPE, CAMP_PERCENT, CAMP_RESPAWNS, CAMP_LINK],	
							//[1,1,75,0,100,10,[_triggerName]], 				//[CAMP_COUNT, CAMP_GROUP_SIZE, CAMP_RADIUS, CAMP_VEHICLETYPE, CAMP_PERCENT, CAMP_RESPAWNS, CAMP_LINK],	
							[0,0,0,1,1]										//[CFG_SIDE_ZONE, CFG_UNIT, CFG_BEHAVIOUR, CFG_CAMP, CFG_WAYPOINT]
						] spawn DAC_Zone;
					};
				};
			};
		};
	};
	
//	waituntil {(DAC_Basic_Value > 0)};
//	player sidechat "DAC_Basic_Value > 0";

//	_values = ["z10",[1,0,0],[5,2,50,8],[],[],[],[1,1,1,1]];
//	[position player, 250, 150, 0, 0,["z10",[1,0,0],[5,2,50,8],[],[],[],[1,1,1,1]]] call DAC_fNewZone;
};
















/*

#define DATA_ID					1
#define DATA_DISABLED			0
#define DATA_EVENTS				0
#define DATA_NOMASTER_WAYPOINTS	0

#define INF_COUNT				1
#define INF_GROUP_SIZE			1
#define INF_WAYPOINTS_TOTAL		2
#define INF_WAYPOINTS_GROUP		2

#define WHL_COUNT				0
#define WHL_GROUP_SIZE			0
#define WHL_WAYPOINTS_TOTAL		0
#define WHL_WAYPOINTS_GROUP		0

#define TRK_COUNT				0
#define TRK_GROUP_SIZE			0
#define TRK_WAYPOINTS_TOTAL		0
#define TRK_WAYPOINTS_GROUP		0

#define CAMP_COUNT				1
#define CAMP_GROUP_SIZE 		1
#define CAMP_RADIUS				100
#define CAMP_VEHICLETYPE		0
#define CAMP_PERCENT			100
#define CAMP_RESPAWNS			10
#define CAMP_LINK				[call compile _triggerName]

#define CFG_SIDE_ZONE			0
#define CFG_UNIT				0
#define CFG_BEHAVIOUR			0
#define CFG_CAMP				1
#define CFG_WAYPOINT			0

[] spawn {
	waituntil{time > 1};
	player sidechat "time > 0";

	onMapSingleClick "player setPosATL [_pos select 0, _pos select 1, 0]; true;";
	
	if (isServer) then
	{
	
		private["_zoneId"];
		_zoneId = 0;
		for "_ix" from 1 to 9 do
		{
			for "_iy" from 1 to 5 do
			{
				private["_triggerName"];
				_triggerName = format["zx%1y%2", _ix, _iy];
				if (!isNil _triggerName) then
				{
					_zoneId = _zoneId + 1;
					[	_triggerName,			// Triggername
						[_zoneId,1,0,0],		// ZoneID, ZoneDisabled, ZoneEvents, NoMasterWaypoints
						[INF_COUNT, INF_GROUP_SIZE, INF_WAYPOINTS_TOTAL, INF_WAYPOINTS_GROUP ],		
						[],//[WHL_COUNT, WHL_GROUP_SIZE, WHL_WAYPOINTS_TOTAL, WHL_WAYPOINTS_GROUP ],
						[],//[TRK_COUNT, TRK_GROUP_SIZE, TRK_WAYPOINTS_TOTAL, TRK_WAYPOINTS_GROUP ],
						[CAMP_COUNT, CAMP_GROUP_SIZE, CAMP_RADIUS, CAMP_VEHICLETYPE, CAMP_PERCENT, CAMP_RESPAWNS, [call compile _triggerName]],		// HELI/CAMP
						[CFG_SIDE_ZONE, CFG_UNIT, CFG_BEHAVIOUR, CFG_CAMP, CFG_WAYPOINT]								// CFGs
					] spawn DAC_Zone;
					
					_markerName = createMarkerLocal [format["markername%1", _triggerName], getPos call compile _triggerName];
					_markerName setMarkerShapeLocal "ICON";
					_markerName setMarkerTypeLocal "o_inf";
					_markerName setMarkerSizeLocal [0.2, 0.2];
					_markerName setMarkerColorLocal "ColorBlue"; 
					_markerName setMarkerAlphaLocal 0.8;	
					_markerName setMarkerTextLocal _triggerName;
				};
			};
		};
	};
	
//	waituntil {(DAC_Basic_Value > 0)};
//	player sidechat "DAC_Basic_Value > 0";

//	_values = ["z10",[1,0,0],[5,2,50,8],[],[],[],[1,1,1,1]];
//	[position player, 250, 150, 0, 0,["z10",[1,0,0],[5,2,50,8],[],[],[],[1,1,1,1]]] call DAC_fNewZone;
};




/*


[	"z1",			// Triggername
			[1,0,0,0],		// DATA
			[INF_COUNT, INF_GROUP_SIZE, INF_WAYPOINTS_TOTAL, INF_WAYPOINTS_GROUP ],		// INF8,2,50,8
			[],//[WHL_COUNT, WHL_GROUP_SIZE, WHL_WAYPOINTS_TOTAL, WHL_WAYPOINTS_GROUP ],		// INF8,2,50,8
			[],//[TRK_COUNT, TRK_GROUP_SIZE, TRK_WAYPOINTS_TOTAL, TRK_WAYPOINTS_GROUP ],		// INF8,2,50,8
			[],		// HELI/CAMP
			[CFG_SIDE_ZONE, CFG_UNIT, CFG_BEHAVIOUR, 0, CFG_WAYPOINT]								// CFGs
		] spawn DAC_Zone;

		
		
		[	"z2",			// Triggername
			[1,0,0,0],		// DATA
			[],//[INF_COUNT, INF_GROUP_SIZE, INF_WAYPOINTS_TOTAL, INF_WAYPOINTS_GROUP ],		
			[],//[WHL_COUNT, WHL_GROUP_SIZE, WHL_WAYPOINTS_TOTAL, WHL_WAYPOINTS_GROUP ],		
			[],//[TRK_COUNT, TRK_GROUP_SIZE, TRK_WAYPOINTS_TOTAL, TRK_WAYPOINTS_GROUP ],		
			[CAMP_COUNT, CAMP_GROUP_SIZE, CAMP_RADIUS, CAMP_VEHICLETYPE, CAMP_PERCENT, CAMP_RESPAWNS],		// HELI/CAMP
			[CFG_SIDE_ZONE, CFG_UNIT, CFG_BEHAVIOUR, CFG_CAMP, CFG_WAYPOINT]								// CFGs
		] spawn DAC_Zone;


[position,sizeX,sizeY,type,direction,parameter] call DAC_fNewZone

[(position player),250,150,0,0,parameter] call DAC_fNewZone

waituntil{DAC_NewZone == 0};
_values = ["z1",[1,0,0],[5,2,50,8],[],[],[],[1,1,1,1]];
[(position player),250,150,0,0,_values] call DAC_fNewZone


waituntil{DAC_NewZone == 0};
["zone1","zone2","zone3","zone4"] call DAC_fDeleteZone
*/