if (!isServer || !isDedicated) then
{
	waitUntil { player == player };

	while {true} do
	{
		if (isNull curatorCamera) then
		{
			if (!(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull]))) then
			{
				player globalChat "remote";

				// Position vor dem Attachen merken
				private["_playerPosition"];
				_playerPosition = getPos player;
				private["_playerDirection"];
				_playerDirection = getDir player;
				

				// Player an die RemoteUnit attachen
				player allowDamage false;
				if (isServer && !isDedicated) then { player hideObject true;} else {player hideObjectGlobal true;};
				player attachTo [missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull], [0, 0, 0]];
				
				// Überwachen
				waitUntil { (isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull])) };
				
				// Spieler wieder zurück setzen
				detach player;
				player setPos _playerPosition;
				player setDir _playerDirection;
				player allowDamage true;
				if (isServer && !isDedicated) then { player hideObject false;} else {player hideObjectGlobal false;};
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

			// Player an die ZeusCamera attachen
			player allowDamage false;
			if (isServer && !isDedicated) then { player hideObject true;} else {player hideObjectGlobal true;};
			player attachTo [curatorCamera, [0, 0, 0]];
			
			// Überwachen
			while { !(isNull curatorCamera) } do
			{
				player setPos (getPos curatorCamera);
				Sleep 1;
			};
			
			// Spieler wieder zurück setzen
			detach player;
			player setPos _playerPosition;
			player setDir _playerDirection;
			player allowDamage true;
			if (isServer && !isDedicated) then { player hideObject false;} else {player hideObjectGlobal false;};
		};
		
		// Sleep a while
		Sleep 1;
	};
};