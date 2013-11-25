if (pixZones_ActiveIndex != -1) then
{
	player sidechat "Es ist bereits eine Zone aktiv. Eine neue Zone kann nicht angegriffen werden.";	
}
else
{
	hint "Wählen Sie ein Zielgebiet mit einem Mausklick auf die Karte.";
	openMap [true, true];
	pixZones_MapCoordinates = [0,0];
	onMapSingleClick "pixZones_MapCoordinates = _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; true;";


	private["_timeout"];
	_timeout = time + 20;
	waitUntil { (pixZones_MapCoordinates select 0 != 0) || (pixZones_MapCoordinates select 1 != 0) || (_timeout < time) };

	if (_timeout < time) then
	{
		player sidechat "Auswahl wegen Zeitüberschreitung beendet. Erst nachdenken, dann klicken...";
		onMapSingleClick ''; 
		openMap [true, false]; 
		openMap [false, false]; 
	}
	else
	{
		private["_zoneIndex"];
		_zoneIndex = pixZones_MapCoordinates call fn_pixZones_GetZoneIndex;
		if (_zoneIndex != -1) then
		{
			private["_canEngage"];
			_canEngage = [_zoneIndex] call fn_pixZones_CanEngageZone;
			if (_canEngage) then
			{
				pvehPixZones_OnRequestActivation = _zoneIndex;
				publicVariableServer "pvehPixZones_OnRequestActivation";
				if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_OnRequestActivation.sqf"; }; /* PublicVariableEventHandler simulieren */
			}
			else
			{
				player sidechat "Diese Zone kann nicht angegriffen werden.";
			};
		};	
	};
};
