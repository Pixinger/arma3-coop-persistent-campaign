private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticObjectsTransportable) then {
	private["_vehicles"];
	_vehicles = nearestObjects [player, logisticTransporters, 20];
	if (count _vehicles > 0) then {
		private["_vehicle"];
		_vehicle = _vehicles select 0;
		
		private["_emptySlot"];
		_emptySlot = [_vehicle, _cursorTargetType] call fnc_Logistic_Transporter_GetEmptySlot;
		if (count _emptySlot > 0) then {
			_cursorTarget attachTo [_vehicle, _emptySlot];
		};
	};
};
