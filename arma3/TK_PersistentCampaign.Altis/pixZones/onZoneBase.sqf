closedialog 0;

hint "Wählen Sie ein Zielgebiet mit einem Mausklick auf die Karte.";
openMap [true, true];
pixZones_MapCoordinates = [0,0];
onMapSingleClick "pixZones_MapCoordinates = _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; true;";


private["_timeout"];
_timeout = time + 20;
waitUntil { (pixZones_MapCoordinates select 0 != 0) || (pixZones_MapCoordinates select 1 != 0) || (_timeout < time) };

if (_timeout < time) then
{
	player globalChat "Auswahl wegen Zeitüberschreitung beendet. Erst nachdenken, dann klicken...";
	onMapSingleClick ''; 
	openMap [true, false]; 
	openMap [false, false]; 
}
else
{
	private["_zoneIndex"];
	_zoneIndex = [pixZones_MapCoordinates] call PC_fnc_GetZoneIndex;
	diag_log format["INFO: hqSelectEngagementZone.sqf: selected _zoneIndex: %1", _zoneIndex];
	if (_zoneIndex != -1) then
	{
		private["_mode"];
		_mode = _this select 0; // 0=start 1=win 2=loose		
		if (_mode == 0) then // 0=start, 1=win, 2=loose
		{
			pvehPixZones_ZoneStatus set [_zoneIndex, 1]; // 0 = Sperrzone, 1 = Aktivierte/Angegriffene Zone, 2 = Freundliche Zone 
		}
		else
		{
			if (_mode == 1) then // 0=start, 1=win, 2=loose
			{
				pvehPixZones_ZoneStatus set [_zoneIndex, 2]; // 0 = Sperrzone, 1 = Aktivierte/Angegriffene Zone, 2 = Freundliche Zone 
			}
			else
			{
				pvehPixZones_ZoneStatus set [_zoneIndex, 0]; // 0 = Sperrzone, 1 = Aktivierte/Angegriffene Zone, 2 = Freundliche Zone 
			};
		};
		publicVariable "pvehPixZones_ZoneStatus";
		if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_ZoneStatus.sqf"; }; /* PublicVariableEventHandler simulieren */
	
	};	
};
