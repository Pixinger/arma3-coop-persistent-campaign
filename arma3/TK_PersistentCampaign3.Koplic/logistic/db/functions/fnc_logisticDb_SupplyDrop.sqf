if (isServer) then
{
	_this spawn {
		params["_position", "_classnameSupply"];

		private _airPosition = [_position select 0, _position select 1, 175];

		// Supply erstellen
		private _supply =  [_classnameSupply, [0,0,0], 0] call fnc_logisticDb_CreateVehicleCorrected;
		diag_log format["setPosATL %1", _airPosition];
			
		//Fallschirm erstellen
		private _parachute = "B_Parachute_02_F" createVehicle [0,0,0];
		_parachute setPosATL _airPosition;
		_supply attachTo [_parachute,[0, 0, -1.2]];

		// Rauchgranate
		_smoke = "SmokeShellYellow" createVehicle position _supply;
		_smoke attachto [_supply,[0,0,0]];

		// Nach 10 Sekunden den Rau löschen und neuen erstellen
		Sleep 10;
		_smoke setDamage 1;
		deleteVehicle _smoke;

		// Rauchgranate
		_smoke = "SmokeShellYellow" createVehicle position _supply;
		_smoke attachto [_supply,[0,0,0]];

		// Warten bis die Lieferung gelandet ist
		waituntil {((getPos _supply) select 2) < 5};	
		
		// Detachen
		detach _supply;
		Sleep 5;
		deleteVehicle _parachute;

		// Nochmal ordentlich smoken !!!
		_smoke = "SmokeShellYellow" createVehicle position _supply;
		_smoke attachto [_supply,[0,0,0]];
		Sleep 10;
		_smoke setDamage 1;
		deleteVehicle _smoke;
		_smoke = "SmokeShellYellow" createVehicle position _supply;
		_smoke attachto [_supply,[0,0,0]];
	};
}
else
{
	_this remoteExec ["fnc_logisticDb_SupplyDrop", 2]; // 2= only server
};