if (isServer) then
{
	diag_log format["fnc_dacZones_Deactivate: _this = %1", _this];

	private["_spalte"];
	_spalte = (_this select 0) - 1;
	private["_zeile"];
	_zeile = (_this select 1) - 1;

	private["_links"];
	_links = (sectorLinks select _zeile) select _spalte;

	{
		private["_linkSpalte"];
		_linkSpalte = _x select 0;
		private["_linkZeile"];
		_linkZeile = _x select 1;
		
		private["_sectorStatusZeile"];
		_sectorStatusZeile = sectorStatus select _linkZeile;
			
		// Referenzzähler verringern
		_sectorStatusZeile set [_linkSpalte, (_sectorStatusZeile select _linkSpalte) - 1];

		// Referenz auf Deaktivierung prüfen
		if ((_sectorStatusZeile select _linkSpalte) <= 0) then
		{
			private["_respawns"];
			_respawns = [_linkSpalte, _linkZeile] call fnc_dacZones_GetCampData_Respawns;
			if (_respawns == 0) then
			{
				private["_triggerName"];
				_triggerName = format["zx%1y%2", _linkSpalte, _linkZeile];
				/*private["_trigger"];
				_trigger = call compile _triggerName;
				private["_triggerPosition"];
				_triggerPosition = position _trigger;
				private["_triggerArea"];
				_triggerArea = triggerArea _trigger;
				private["_triggerActivation"];
				_triggerActivation = triggerActivation _trigger;
				private["_triggerStatements"];
				_triggerStatements = triggerStatements _trigger;
				private["_triggerType"];
				_triggerType = triggerType _trigger;*/
						
				waituntil{DAC_NewZone == 0};
				[_triggerName] call DAC_fDeleteZone;
				
				/*[_triggerName, _triggerPosition, _triggerArea, _triggerActivation, _triggerStatements, _triggerType] spawn
				{
					Sleep 5;
					
					private["_trg"];
					_trg = createTrigger ["EmptyDetector", _this select 1];
					_trg setTriggerArea [(_this select 2) select 0, (_this select 2) select 1, (_this select 2) select 2, (_this select 2) select 3];
					_trg setTriggerActivation (_this select 3);
					_trg setTriggerStatements (_this select 4);
					_trg setTriggerType "NONE";//_this select 5;
					call compile format["%1 = _trg;", _this select 0];

					[_this select 0,										// Triggername
							[999,1,0,0],									//[ZoneID, ZoneDisabled, ZoneEvents, NoMasterWaypoints]
							[1,1,10,5], 									//[INF_COUNT, INF_GROUP_SIZE, INF_WAYPOINTS_TOTAL, INF_WAYPOINTS_GROUP],
							[],												//[WHL_COUNT, WHL_GROUP_SIZE, WHL_WAYPOINTS_TOTAL, WHL_WAYPOINTS_GROUP],
							[],												//[TRK_COUNT, TRK_GROUP_SIZE, TRK_WAYPOINTS_TOTAL, TRK_WAYPOINTS_GROUP],
							[], 											//[CAMP_COUNT, CAMP_GROUP_SIZE, CAMP_RADIUS, CAMP_VEHICLETYPE, CAMP_PERCENT, CAMP_RESPAWNS, CAMP_LINK],	
							[0,0,0,0,1]										//[CFG_SIDE_ZONE, CFG_UNIT, CFG_BEHAVIOUR, CFG_CAMP, CFG_WAYPOINT]
					] spawn DAC_Zone;				
					
					//[position,sizeX,sizeY,type,direction,parameter] call DAC_fNewZone
				};*/
			};
			
			[] call compile format["tmp = [zx%1y%2] call DAC_Deactivate;", _linkSpalte, _linkZeile];
			_sectorStatusZeile set [_linkSpalte, 0]; // Zur Sicherheit...
		};
	} foreach _links;
};