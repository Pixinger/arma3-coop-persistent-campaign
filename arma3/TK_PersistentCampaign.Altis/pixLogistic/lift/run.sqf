/*
Inspired by =BTC= Giallustio
*/
if (!isServer || !isDedicated) then
{	
	player globalChat "lift.run.sqf started";

	/* Wenn noch nicht compiliert, dann jetzt compilieren */
	if (isNil "fn_pixLogisticLift_FindNearestObject") then { fn_pixLogisticLift_FindNearestObject = compile preprocessFileLineNumbers "pixLogistic\lift\fn_pixLogisticLift_FindNearestObject.sqf"; };

	[] spawn
	{			
		pixLogisticLift_AttachedObject = objNull;
		pixLogisticLift_DialogHUDEnabled = false;
		pixLogisticLift_ShowMenuAttach = false;
		pixLogisticLift_ShowMenuDetach = false;
		
		waitUntil {!isNull player};
		
		private["_playerObject"];
		_playerObject = player;
		
		private["_menuId1"];
		_menuId1 = _playerObject addAction [("<t color=""#ED2744"">" + ("Lift") + "</t>"),"pixLogistic\lift\actionAttach.sqf", [], 101, true, true, "", "pixLogisticLift_ShowMenuAttach"];
		private["_menuId2"];
		_menuId2 = _playerObject addAction [("<t color=""#ED2744"">" + ("Release") + "</t>"),"pixLogistic\lift\actionDetach.sqf", [], 100, true, true, "", "pixLogisticLift_ShowMenuDetach"];

		/* Infinite Loop */
		while { _playerObject == player } do
		{
		
			Sleep 1;
			private["_inHeli"];
			_inHeli = (((vehicle _playerObject) isKindOf "Helicopter") && (driver (vehicle player) == player));
			pixLogisticLift_ShowMenuAttach = (_inHeli) && (isNull pixLogisticLift_AttachedObject);
			pixLogisticLift_ShowMenuDetach = (_inHeli) && (!(isNull pixLogisticLift_AttachedObject));			
		};
		
		player globalChat "lift.run.sqf finished due to player exchange.";
	};
};