closeDialog 0;
if (pixLogisticZeusFix) then
{
	pixLogisticZeusFix = false;
	player globalChat "Disabling ZeusFix";
}
else
{
	pixLogisticZeusFix = true;
	pixLogisticZeusFixRemote = false;
	player globalChat "ZeusFix enalbed";

	while {pixLogisticZeusFix} do
	{
		if (isNull curatorCamera) then
		{
			if (!(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull]))) then
			{
				if (pixLogisticZeusFixRemote) then
				{
					player globalChat "ZeuFix remote enabled";

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
					player disableCollisionWith (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull]);
					
					// Überwachen
					private["_remote"];
					while { (!(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull]))) && (pixLogisticZeusFix) } do
					{
						_remote = missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull];
						player setPos (getPos _remote);
						player setDir (getDir _remote);
						Sleep 1;					
					};
					
					// Spieler wieder zurück setzen
					player enableCollisionWith _remote;
					player setPos _playerPosition;
					player setDir _playerDirection;
					Sleep 0.5;
					player allowDamage true;
					player setDamage 0;
					player setCaptive _captiveNum;			
					player globalChat "ZeuFix remote finished";
				};
			};
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
				Sleep 0.5;
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