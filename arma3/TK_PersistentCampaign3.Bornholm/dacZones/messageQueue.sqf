waituntil {(DAC_Basic_Value > 0)};
player sidechat "Dei MessageQueue beginnt mit ihrer Arbeit...";

while { true } do
{
	if (count dacZonesMessageQueue > 0) then
	{
		private["_message"];
		_message = call fnc_dacZones_MessageQueuePop;  //[1,1, true]; entspricht Zone EIN
		
		private["_zoneXY"];
		_zoneXY = (_message select 0) call fnc_dacZones_GetZoneXyFromId;
		
		private["_zoneRow"];
		_zoneRow = (_zoneXY select 0);
		private["_zoneLine"];
		_zoneLine = (_zoneXY select 1);

		private["_statusLine"];
		_statusLine = sectorStatusQueue select _zoneLine;
		private["_status"];
		_status = (_statusLine select _zoneRow);
		if (_status != (_message select 1)) then
		{
			if ((_message select 1) == 1) then
			{
				[_message select 0] call fnc_dacZones_ZoneActivate; // [_zoneId] call fnc_dacZones_ZoneActivate;
				_statusLine set [_zoneRow, 1]; // Status mit verfolgen
			}
			else
			{
				[_message select 0] call fnc_dacZones_ZoneDeactivate; // [_zoneId] call fnc_dacZones_ZoneDeactivate;
				_statusLine set [_zoneRow, 0]; // Status mit verfolgen
			};
		};
	}
	else
	{
		Sleep 1;
	}; 
};