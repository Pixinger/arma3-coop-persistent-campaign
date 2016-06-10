if (!(surfaceIsWater position player) && (!isOnRoad player)) then 
{
	hint "Bauen gestartet. Bitte stehen bleiben!";
	call fnc_Logistic_WorkAnimationStart;
	Sleep 20;
	call fnc_Logistic_WorkAnimationEnd;
	
	// Objekt erstellen
	private["_object"];
	_object = createVehicle ["CraterLong_small", [(position player) select 0, (position player) select 1, 0], [], 0, "CAN_COLLIDE"]; //_object = "CraterLong_small" createVehicle (position player); //CraterLong_small
	waitUntil {!isNil "_object"};	
	_object setDir (floor random (360));
	//_object setPosATL [(position player) select 0, (position player) select 1, 0];
	
	// Autodelete
	_object spawn {
		Sleep (4*60);
		diag_log format["autoDelete: %1", _this];
		deleteVehicle _this;
	};
};