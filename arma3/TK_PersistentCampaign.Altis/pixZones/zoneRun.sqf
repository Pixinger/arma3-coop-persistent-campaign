/* ------------------------------------------------------------------------------------------------------------------------------
   Wird auf Server und Clienten aufgerufen, wenn die Variable "pvehPixZones_MissionInfos" sich ändert.
   Sollte noch keine Missionen gestartet sein, dann werden diese nun gestartet. Ansonsten einfach nur die Änderungen berücksichtigt.
/* ------------------------------------------------------------------------------------------------------------------------------*/

if (str(pvehPixZones_MissionInfos) == "[]") then
{
	pixZones_ActiveIndex = -1;
}
else
{
	if (pixZones_ActiveIndex == -1) then
	{
		pixZones_ActiveIndex = pvehPixZones_MissionInfos select 0;
		
		private["_missionsEnv"];
		_missionsEnv = pvehPixZones_MissionInfos select 1;
		private["_missionsOpt"];
		_missionsOpt = pvehPixZones_MissionInfos select 2;
		private["_missionsRev"];
		_missionsRev = pvehPixZones_MissionInfos select 3;

		/*----------------------------*/
		/* Missions-Status erstellen  */
		/*----------------------------*/
		if (isServer) then
		{
			private["_missionEnvStatus"];
			_missionEnvStatus = [];
			private["_missionOptStatus"];
			_missionOptStatus = [];
			private["_missionRevStatus"];
			_missionRevStatus = [];
			
			for "_i" from 0 to (count (pvehPixZones_MissionInfos select 1) - 1) do
			{
				_missionEnvStatus = _missionEnvStatus + [1]; /* Env sind immer gleich erledigt, laufen aber weiter */
			};
			for "_i" from 0 to (count (pvehPixZones_MissionInfos select 2) - 1) do
			{
				_missionOptStatus = _missionOptStatus + [0];
			};
			for "_i" from 0 to (count (pvehPixZones_MissionInfos select 3) - 1) do
			{
				_missionRevStatus = _missionRevStatus + [0];
			};
			
			pvehPixZones_MissionStatus = [_missionEnvStatus, _missionOptStatus, _missionRevStatus];
			/*--------------------------------*/
			/* An alle Clienten weiterreichen */
			/*--------------------------------*/
			publicVariable "pvehPixZones_MissionStatus";		
			if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */
		};

		/*----------------------*/
		/* Env-Missions starten */
		/*----------------------*/
		for "_i" from 0 to ((count _missionsEnv) - 1) do
		{
			/* [zoneIndex, _missionInfoIndex] */
			[pixZones_ActiveIndex, _i] call compile preprocessFileLineNumbers "missionsEnv\run.sqf";
		};

		/*----------------------*/
		/* Opt-Missions starten */
		/*----------------------*/
		for "_i" from 0 to ((count _missionsOpt) - 1) do
		{
			/* [zoneIndex, _missionInfoIndex] */
			[pixZones_ActiveIndex, _i] call compile preprocessFileLineNumbers "missionsOpt\run.sqf";
		};
		
		/*----------------------*/
		/* Rev-Missions starten */
		/*----------------------*/
		missionsRev_AttackStarted = false;
		missionsRev_AttackFinished = false;
		for "_i" from 0 to ((count _missionsRev) - 1) do
		{
			/* [zoneIndex, _missionInfoIndex] */
			[pixZones_ActiveIndex, _i] call compile preprocessFileLineNumbers "missionsRev\run.sqf";
		};
		

		/*----------------------------------------------------------------------------*/
		/* Der Server muss nun in der Schleife bleiben bis die Missionen vorbei sind. */
		/* Die Clienten dagegen können dieses Skript beenden. Die Überwachung der */
		/* einzelnen Missionen findet jeweils dort statt. */
		/*----------------------------------------------------------------------------*/
		if (isServer) then
		{
			/*--------------------------------------------------------------------------------------------------*/
			/* Wenn es sich um eine ReverseAttack Mission handelt, dann verzögern wir nun noch ein paar Minuten */
			/*--------------------------------------------------------------------------------------------------*/
			if (count (pvehPixZones_MissionInfos select 3) > 0) then
			{
				Sleep (60 * pixParamReverseAttackDelay);
				missionsRev_AttackStarted = true;
			};
			
			/*---------------------------------------------*/
			/* Warten bis die Missionen abgeschlossen sind */	
			/*---------------------------------------------*/
			private["_timeout"];
			_timeout = time + (pixParamzoneCaptureTime * 60);
			while { (!call PC_fnc_AllMissionsFinished) && (time < _timeout)} do
			{	
				Sleep 10;				
			};	
						
			/*----------------------------------------*/
			/* pvehPixZones_ZoneStatus aktualisieren  */
			/*----------------------------------------*/
			if ((time < _timeout) && (call PC_fnc_AllMissionsSuccessfull) then
			{
				pvPixLogisticMoney = pvPixLogisticMoney + pixlogisticRewardForZone;
				{ if (_x >= 2) then { pvPixLogisticMoney = pvPixLogisticMoney + pixlogisticRewardForExistingZone;};	} foreach pvehPixZones_ZoneStatus;				
				publicVariable "pvPixLogisticMoney";
				
				pvehPixZones_ZoneStatus set [pixZones_ActiveIndex, 2]; /* Die Zone geht an BlueFor */
			}
			else
			{
				/* Leider ist die Zone verloren. Deshalb müssen nun alle Fahrzeuge in der DB zerstört werden */
				waitUntil { !pixlogisticDbMutex };
				pixlogisticDbMutex = true;
				{
					if (([getPos _x] call PC_fnc_GetZoneIndex) == pixZones_ActiveIndex) then
					{
						_x setDamage 1;
					};
				} foreach pixlogisticDbItems;
				pixlogisticDbMutex = false;
				
				pvehPixZones_ZoneStatus set [pixZones_ActiveIndex, 0]; /* Die Zone geht an OpFor */
			};
			[] call compile preprocessFileLineNumbers "pixZones\serverSaveToDb.sqf";		
			publicVariable "pvehPixZones_ZoneStatus";
			if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_ZoneStatus.sqf"; }; /* PublicVariableEventHandler simulieren */
			
			pixZones_ActiveIndex = -1;
			pvehPixZones_MissionInfos = [];
			publicVariable "pvehPixZones_MissionInfos";
			if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionInfos.sqf"; }; /* PublicVariableEventHandler simulieren */
		};
	}
	else
	{
		/* Die "pvehPixZones_MissionInfos" Variable wurde aktualisiert. Wir müssen aber eigentlich nichts machen. Diesen Fall sollte es eigentlich nicht geben. */
	};
};