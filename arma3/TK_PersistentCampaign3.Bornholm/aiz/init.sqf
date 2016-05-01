if (isServer) then
{
	private["_markerName"];
	for "_iy" from 0 to 10 do 
	{
		for "_ix" from 0 to 10 do 
		{
			_markerName = format["markerAizX%1Y%2", _ix, _iy];
			player sidechat _markerName;
			if (markerType _markerName != "") then
			{
			player sidechat "OK";
				private["_markerPos"];
				_markerPos = markerPos _markerName;
				private["_markerSize"];
				_markerSize = markerSize _markerName;
				private["_markerDir"];
				_markerDir = markerDir _markerName;
				private["_markerIsRectangle"];
				if (markerShape _markerName == "rectangle") then { _markerIsRectangle = true; } else { _markerIsRectangle = false; };

				private["_trigger"];
				_trigger = createTrigger ["EmptyDetector", _markerPos, true];				
				_trigger setTriggerType "NONE";
				_trigger setTriggerArea [_markerSize select 0, _markerSize select 1, _markerDir, _markerIsRectangle];
				_trigger setTriggerActivation ["WEST", "PRESENT", true];
				_trigger setTriggerStatements ["this", format["[%1,%2] call fnc_aiz_OnTriggerActivated;", _ix, _iy], format["[%1,%2] call fnc_aiz_OnTriggerDeactivated;", _ix, _iy]];
				//_trigger setTriggerText format["aizTriggerX%1Y%2", _ix, _iy];
			};
		};
	};
};