closeDialog 0;
if (pixLogisticZeusFix) then
{
	pixLogisticZeusFix = false;
	player globalChat "Disabling ZeusFix";
}
else
{
	pixLogisticZeusFix = true;
	player globalChat "ZeusFix enalbed";

	while {pixLogisticZeusFix} do
	{
		if (isNull curatorCamera) then
		{
			/*if (!(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull]))) then
			{
				/*player globalChat "remote";

				// Position vor dem Attachen merken
				private["_playerPosition"];
				_playerPosition = getPos player;
				private["_playerDirection"];
				_playerDirection = getDir player;
				private["_captiveNum"];
				_captiveNum = captiveNum player;

				// Player an die RemoteUnit attachen
				player setCaptive 3;
				player allowDamage false;
				//pvehPixlogisticHidePlayer = [getPlayerUID player, true];
				//publicVariableServer "pvehPixlogisticHidePlayer";
				//if (!isDedicated) then	{ pvehPixlogisticHidePlayer call compile preprocessFileLineNumbers "pixLogistic\serverHideObject.sqf"; }; /* PublicVariableEventHandler simulieren */
				//player attachTo [missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull], [0, 0, 0]];
				
				// Überwachen
			/*	while { !(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull])) } do
				{
					private["_remote"];
					_remote = missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull];
					player setPos (getPos _remote);
					player setDir (getDir _remote);
					Sleep 0.2;					
				};
				
				// Spieler wieder zurück setzen
				//detach player;
				player setPos _playerPosition;
				player setDir _playerDirection;
				Sleep 0.5;
				player allowDamage true;
				player setDamage 0;
				player setCaptive _captiveNum;
				//pvehPixlogisticHidePlayer = [getPlayerUID player, pixLogisticAdminHide];
				//publicVariableServer "pvehPixlogisticHidePlayer";
				//if (!isDedicated) then	{ pvehPixlogisticHidePlayer call compile preprocessFileLineNumbers "pixLogistic\serverHideObject.sqf"; }; /* PublicVariableEventHandler simulieren */
			/*};*/
		}
		else
		{
			// player is using Zeuscamera
			player globalChat "Zeuscam";
			
			// Position vor dem Attachen merken
			private["_playerPosition"];
			_playerPosition = getPos player;
			private["_playerDirection"];
			_playerDirection = getDir player;
			private["_captiveNum"];
			_captiveNum = captiveNum player;

			// Player an die ZeusCamera attachen
			player setCaptive 3;
			player allowDamage false;
			
			// Überwachen
			while { (!(isNull curatorCamera)) && (pixLogisticZeusFix) } do
			{
				player setPos (getPos curatorCamera);
				Sleep 0.2;
			};
			
			// Spieler wieder zurück setzen
			//detach player;
			player setPos _playerPosition;
			player setDir _playerDirection;
			Sleep 0.5;
			player allowDamage true;
			player setDamage 0;
			player setCaptive _captiveNum;
		};
		
		// Sleep a while
		Sleep 1;
	};

	player globalChat "ZeusFix disabled";	
};