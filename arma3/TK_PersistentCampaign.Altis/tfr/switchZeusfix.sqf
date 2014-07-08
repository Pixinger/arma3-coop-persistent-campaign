if (pixTfarZeusFix_enabled) then
{
	pixTfarZeusFix_enabled = false;
	player globalChat "Zeusfix: Disabling...";
}
else
{
	pixTfarZeusFix_enabled = true;
	player globalChat "ZeusFix: Enabled";

	// Variablen initialisieren 
	pixTfarZeusfix_SwPressed = false;
	pixTfarZeusfix_LrPressed = false;

	// Benötigte Funktionen compilieren
	pixTfar_fnc_radiofix_keyup = compile preprocessFileLineNumbers "tfr\fnc_tfar_radiofix_keyup.sqf";
	pixTfar_fnc_radiofix_keydown = compile preprocessFileLineNumbers "tfr\fnc_tfar_radiofix_keydown.sqf";

	while { pixTfarZeusFix_enabled } do
	{
		if (!isNull (findDisplay 312)) then /* if (ZeusDisplay aktiv) then */
		{
			// Player is using Zeuscamera
			player globalChat "Zeusfix: Interface opened";

			// Key-Events erstellen
			_tmp = (findDisplay 312) displayaddEventHandler ["KeyDown", "_this call pixTfar_fnc_radiofix_keydown;"];
			_tmp = (findDisplay 312) displayaddEventHandler ["KeyUp", "_this call pixTfar_fnc_radiofix_keyup;"];

			// Position vor dem Attachen merken
			private["_playerPosition"];
			_playerPosition = getPos player;
			private["_playerDirection"];
			_playerDirection = getDir player;
			private["_captiveNum"];
			_captiveNum = captiveNum player;

			if (pixTfarZeusFix_attachToCamera) then
			{
				player globalChat "Zeusfix: Attached to camera";

				// Player an die ZeusCamera attachen
				player setCaptive 3;
				player allowDamage false;
				player enableSimulationGlobal false;

				// Überwachen
				while { (!(isNull curatorCamera)) && (pixTfarZeusFix_enabled) } do
				{
					player setPos (getPos curatorCamera);
					Sleep 0.5;
				};

				// Spieler wieder zurück setzen
				player enableSimulationGlobal true;
				player setvelocity [0,0,0];
				player setPos _playerPosition;
				player setDir _playerDirection;
				player setvelocity [0,0,0];
				Sleep 0.5;
				player allowDamage true;
				player setDamage 0;
				player setCaptive _captiveNum;
				
				player globalChat "Zeusfix: Detached from camera";
			}
			else
			{			
				// Überwachen
				while { (!(isNull curatorCamera)) && (pixTfarZeusFix_enabled) } do
				{
					Sleep 0.5;
				};
			};			
		}
		else
		{
			if (!(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull]))) then
			{
				player globalChat "ZeuFix: Attached to remoteunit";

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
				while { (!(isnull (missionnamespace getvariable ["bis_fnc_moduleRemoteControl_unit",objnull]))) && (pixTfarZeusFix_enabled) } do
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
				player globalChat "ZeuFix: detached from remoteunit";
			};
		};
		
		// Sleep a while
		Sleep 1;
	};

	player globalChat "ZeusFix: Disabled";	
};