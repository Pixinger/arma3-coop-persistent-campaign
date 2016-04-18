if (!(surfaceIsWater position player) && (!isOnRoad player)) then 
{
	private["_i"];
	_i = 2;
	while { _i > 0 } do
	{
		call fnc_Logistic_WorkAnimation;
		Sleep 7;
		_i = _i - 1;
		player sidechat "loop";
	};
	
	// Objekt erstellen
	private["_object"];
	_object = "CraterLong" createVehicleLocal (position player); //CraterLong_small
	waitUntil {!isNil "_object"};	
	_object setDir (floor random (360));
	_object setPos (position player);
	
	// Autodelete
	_object spawn {
		Sleep 120;
		diag_log format["autoDelete: %1", _this];
		deleteVehicle _this;
	};
};