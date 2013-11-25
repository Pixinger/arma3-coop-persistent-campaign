if (isNull pixLogisticLift_AttachedObject) then
{
	/* HUD starten (bei Bedarf) */
	if (!pixLogisticLift_DialogHUDEnabled) then
	{
		private["_tmp"];
		_tmp = [] execVM "pixLogistic\lift\dialogHUD\show.sqf";
	};
	
	private["_vehicle"];
	_vehicle = vehicle player;
	
	/* Versuchen etwas in der Nähe zu finden */
	private ["_object"];		
	_object = call fn_pixLogisticLift_FindNearestObject;
	if (!(isNull _object)) then
	{
		private["_rel_pos"];
		_rel_pos   = _vehicle worldToModel (getPosATL _object);
		private["_posX"];
		_posX = _rel_pos select 0;
		private["_posY"];
		_posY = _rel_pos select 1;
		private["_posZ"];
		_posZ = _rel_pos select 2;

		/* Berechnen ob in Reichweite zum Einhaken */
		if (((abs _posZ) < pixLogisticLiftHeightMax) && ((abs _posZ) > pixLogisticLiftHeightMin) && ((abs _posX) < pixLogisticLiftRadius) && ((abs _posY) < pixLogisticLiftRadius)) then
		{
			pixLogisticLift_AttachedObject = _object;
		
			/* Attach Position berechnen */
			private["_rel_position"];
			_rel_position = _vehicle worldToModel (getPosATL pixLogisticLift_AttachedObject);
			private["_attachHeight"];
			_attachHeight = (_rel_position select 2) + 2.5;
			
			/* Attachen */
			pixLogisticLift_AttachedObject attachTo [_vehicle, [0, 0, _attachHeight]];
			
			/* Melden */
			_vehicle vehicleChat format ["%1 lifted", (getText (configFile >> "cfgVehicles" >> typeof pixLogisticLift_AttachedObject >> "displayName"))];
		};
	};
}
else
{
	player sidechat "ERROR: Already something attached.";	
};