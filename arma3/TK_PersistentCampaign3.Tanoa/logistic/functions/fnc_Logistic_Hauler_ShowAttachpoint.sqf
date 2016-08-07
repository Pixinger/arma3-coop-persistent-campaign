private _hauler = vehicle player;
private _haulerIndex = logisticHaulers find (typeOf _hauler);
if (_haulerIndex >= 0) then 
{
	// Hauler Daten
	private _haulerConfig = logisticHaulerConfigs select _haulerIndex;
	private _haulerAttachPoint = _haulerConfig select 0;

	// Sphere erstellen
	private _sphere = createVehicle ["Sign_Arrow_Large_F", [0,0,0], [], 0, "NONE"];//"Sign_Arrow_Large_F", "Sign_Sphere100cm_F"
	_sphere attachTo [_hauler, [0 + (_haulerAttachPoint select 0), -8 + (_haulerAttachPoint select 1), 0 + (_haulerAttachPoint select 2)]];
	
	// Nach einiger Zeit wieder löschen
	_sphere spawn {	
		Sleep 60;
		deleteVehicle _this;
	};
};