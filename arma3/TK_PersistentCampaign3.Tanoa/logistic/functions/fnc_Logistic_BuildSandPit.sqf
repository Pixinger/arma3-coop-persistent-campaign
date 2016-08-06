if (!(surfaceIsWater position player) && (!isOnRoad player)) then 
{

	private _sleepTime = [] call fnc_Logistic_GetBuildSleepTime; // _sleepTime = 1 bis 3. 2 entspricht ca 500 Mass-Einheiten

	call fnc_Logistic_WorkAnimationStart;
	logisticBuild = true;
	private _actionMenu = player addAction [format["<t color=""#dddd00"">%1</t>", localize "str_pc3_Abort"], { logisticBuild = false; }, nil, 5, true, true];
	private _loopcount = 10;
	while { (logisticBuild) && (alive player) && (_loopcount > 0) } do
	{
		if (pixDebug) then { Sleep 0.2; } else { Sleep _sleepTime; };
		_loopcount = _loopcount - 1;
	};
	call fnc_Logistic_WorkAnimationEnd;

	player removeAction _actionMenu;

	if ((logisticBuild) && (alive player)) then
	{
		// Objekt erstellen
		private["_object"];
		_object = createVehicle ["CraterLong_small", [(position player) select 0, (position player) select 1, 0], [], 0, "CAN_COLLIDE"]; //_object = "CraterLong_small" createVehicle (position player); //CraterLong_small
		waitUntil {!isNil "_object"};	
		_object setDir (floor random (360));
		_object setPosATL [(position player) select 0, (position player) select 1, 0];
		
		// Autodelete
		_object spawn {
			Sleep (5*60);
			deleteVehicle _this;
		};
	};

	logisticBuild = nil;
};