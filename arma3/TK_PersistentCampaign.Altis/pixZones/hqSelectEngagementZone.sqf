﻿if (pixZones_ActiveIndex != -1) then
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
		private["_zoneIndex"];
		_zoneIndex = [pixZones_MapCoordinates] call PC_fnc_GetZoneIndex;
		if (_zoneIndex != -1) then
		{
			private["_canEngage"];
			_canEngage = [_zoneIndex] call fn_pixZones_CanBlueforEngageZone;
			if (_canEngage) then
			{				
				/* Reverse Attack laut Parameter  */
				private["_reverseAttack"];
				if (pixParamZoneAttackType == 0) then
				{
					if (random 1 < 0.2) then
					{
						_reverseAttack = true;
					}
					else
					{
						_reverseAttack = false;
					};
				}
				else
				{
					if (pixParamZoneAttackType == 1) then
					{
						_reverseAttack = false;
					}
					else
					{
						_reverseAttack = true;
					};
				};
				
				if (_reverseAttack) then
				{
					/* Pürfen welche Zonen angegriffen werden könnten */
					private["_validConnectedZones"];
					_validConnectedZones = [_zoneIndex] call fn_pixZones_GetConnectedHostileZones;					
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
							Bereiten sie alles für die Verteidigung vor. Laut unseren Informanten beginnt der Angriff in ewta %1 Minuten.", pixZones_ReverseAttackTime];
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
