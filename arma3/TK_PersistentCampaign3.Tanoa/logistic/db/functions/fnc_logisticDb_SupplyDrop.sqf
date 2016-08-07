if (isServer) then
{
	_this spawn {
		params["_position", "_classnameSupply"];

		private _airPosition = [_position select 0, _position select 1, 50];

		// Supply erstellen
		private _supply =  [_classnameSupply, [0,0,0], 0] call fnc_logisticDb_CreateVehicleCorrected;
		diag_log format["setPosATL %1", _airPosition];
			
		//Fallschirm erstellen
		private _parachute = "B_Parachute_02_F" createVehicle [0,0,0];
		_parachute setPosATL _airPosition;
		_parachute allowDamage false;

		_supply attachTo [_parachute,[0, 0, -2]];

		waitUntil {(getPos _supply) select 2 < 2};
		
		detach _supply;
		private _position = getpos _supply;
		_position set [2,0];
		_supply setPos _position;
		deleteVehicle _parachute;	
	};
}
else
{
	if (count _this == 1) then
	{
		openMap [true, true];
		onMapSingleClick format["[_pos, '%1'] remoteExec ['fnc_logisticDb_SupplyDrop', 2]; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; true;", _this select 0];
	}
	else
	{
		_this remoteExec ["fnc_logisticDb_SupplyDrop", 2]; // 2= only server
	};
};