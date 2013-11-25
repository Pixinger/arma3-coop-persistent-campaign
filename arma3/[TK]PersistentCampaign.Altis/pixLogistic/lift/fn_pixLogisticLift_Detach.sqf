if (!isNull pixLogisticLift_AttachedObject) then
{
	/* Entkoppeln */
	detach pixLogisticLift_AttachedObject;
	
	/* Melden */
	(vehicle player) vehicleChat format["%1 dropped", getText (configFile >> "cfgVehicles" >> typeof pixLogisticLift_AttachedObject >> "displayName")];
	
	/* Alles was unter den Boden gerät wird oberhalb abgesetzt. */
	private["_height"];
	_height = (getPos pixLogisticLift_AttachedObject) select 2;
	if (_height < 0) then
	{
		pixLogisticLift_AttachedObject setPos [getPos pixLogisticLift_AttachedObject select 0, getPos pixLogisticLift_AttachedObject select 1, 0];
	};

	/* Statische Objekte manuell nach unten bewegen */
	if (pixLogisticLift_AttachedObject isKindOf "Strategic") then 
	{	
		private["_tmp"];
		_tmp = [pixLogisticLift_AttachedObject] spawn fn_pixLogisticLift_ObjectFall;
	} 
	else 
	{
		_vel = velocity (vehicle player);
		pixLogisticLift_AttachedObject setVelocity _vel;	
	};
	 
	/* HUD abschalten */
	pixLogisticLift_DialogHUDEnabled = false;

	/* Objekt aus der Tracker-Variablen nehmen */
	pixLogisticLift_AttachedObject = objNull;	
 };
 