if (pixZones_ActiveIndex != -1) then
{
	player globalChat "Es ist bereits eine Zone aktiv. Eine neue Zone kann nicht angegriffen werden.";	
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
		player globalChat "Auswahl wegen Zeitüberschreitung beendet. Erst nachdenken, dann klicken...";
		onMapSingleClick ''; 
		openMap [true, false]; 
		openMap [false, false]; 
	}
	else
	{
		private["_attackMode"]; /* 0=random 1=attack 2=reverseattack */
		_attackMode = _this select 0;

		private["_zoneIndex"];
		_zoneIndex = [pixZones_MapCoordinates] call PC_fnc_GetZoneIndex;
		diag_log format["INFO: hqSelectEngagementZone.sqf: selected _zoneIndex: %1", _zoneIndex];
		if (pixDebug) then { player sidechat format["_zoneIndex: %1", _zoneIndex];};
		if (_zoneIndex != -1) then
		{
			private["_canEngage"];
			_canEngage = [_zoneIndex] call PC_fnc_CanBlueforEngageZone;
			if (_canEngage) then
			{				

				/* Reverse Attack laut Parameter  */
				private["_reverseAttack"];
				_reverseAttack = false; /* just for safety */
				if (_attackMode == 0) then
				{
					if ((random 100) < 20) then
					{
						_reverseAttack = true;
					}
					else
					{
						_reverseAttack = false;
						pixZones_IgnoreReverseAttack = false;
					};
				}
				else
				{
					if (_attackMode == 1) then
					{
						_reverseAttack = false;
						pixZones_IgnoreReverseAttack = false;
					}
					else
					{
						_reverseAttack = true;
					};
				};
				
				if ((!pixZones_IgnoreReverseAttack) && (_reverseAttack)) then
				{
					/* Es wird nur der Zonenindex der Zone übernmittelt. Der Server entscheidet später anhand des Zonen-Status, */
					/* ob es sich um einen Gegenangriff handelt oder nicht. */
					/* Gehört die Zone eigentlich mir, ist es eine Gegenangriff. */
					/* Ist die Zone noch feindlich, ist es ein normaler Angriff. */
					
					/* ReverseAttack nur einmal zulassen */
					pixZones_IgnoreReverseAttack = true;
					
					/* Prüfen welche Zonen angegriffen werden könnten */
					private["_validConnectedZones"];
					_validConnectedZones = [_zoneIndex] call PC_fnc_GetConnectedHostileZones;					
					if (count _validConnectedZones > 0) then
					{
						/* Jetzt tricksen wir ein wenig. Bisher steht in "_zoneIndex" der Index der Zone die BlueFor angreifen will 
						Da das System aber einen Gegenangriff angeordnet hat, schreiben wir nun den Index der Zone die von OpFor 
						angeriffen wird in "_zoneIndex". Dadurch können wir die Zone ganz normal starten. */
						/* Bestimmen welche Zone durch Opfor angegriffen wird */
						_zoneIndex = _validConnectedZones select (floor(random(count _validConnectedZones)));
						/* Dem Teamleader noch einen Hinweis auf das Problem geben */
						hintC format["Unser Nachrichtendienst meldet uns Bewegung in feindlichen Sektoren.
							Es scheint so als würde der Gegner einen Gegenangriff vorbereiten.
							Die Satelliten melden Bewegung in mehreren Sektoren.
							Bereiten sie alles für die Verteidigung vor. (%1 Minuten)", pixParamReverseAttackDelay];
					}
					else
					{
						diag_log "Found no zone for reverse attack. reverse attack aborted";
					};
				};
				
				/* Die gewünschte Zonen kann nun normal gestartet werden. 
				zoneInitialize.sqf kann über den aktuellen Status der Zone herausfinden, ob es sich um einen Gegenangriff handeln soll, oder nicht.
				Wenn die Zone BlueFor ist, dann ist es ein Gegenangriff - sonst nicht. Position, Stärke und andere Details werden erst n der "run.sqf" der Zone bestimmt. */
				pvehPixZones_OnRequestActivation = _zoneIndex;
				publicVariableServer "pvehPixZones_OnRequestActivation";
				if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_OnRequestActivation.sqf"; }; /* PublicVariableEventHandler simulieren */
				
			}
			else
			{
				player globalChat "Diese Zone kann nicht angegriffen werden.";
			};
		};	
	};
};
