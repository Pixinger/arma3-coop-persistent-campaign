private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionOpt"]; /* [missionIndex, missionPosition, missionDirection, markerPosition, markerRadius] */
_missionOpt = ((pvehPixZones_MissionInfos select 2) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionOpt select 1;
private["_missionDirection"];
_missionDirection = _missionOpt select 2; /* Wird hier verwendet um den Fahrzeug Typen zu bestimmen */
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------*/
/* Building Typen definieren */
/*---------------------------*/
private["_buildingClassnames"];
_buildingClassnames = ["Land_Cargo20_cyan_F"];

/* Aus der zufälligen Richtung den Klassennamen errechnen */
private["_buildingClassnameIndex"];
_buildingClassnameIndex = floor (((count _buildingClassnames) / 360) * _missionDirection);
if (_buildingClassnameIndex < 0) then { _buildingClassnameIndex = 0;};
if (_buildingClassnameIndex >= count _buildingClassnames) then { _buildingClassnameIndex = (count _buildingClassnames) - 1;};

private["_buildingClassname"];
_buildingClassname = _buildingClassnames select _buildingClassnameIndex;


/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	[_missionPosition, _missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _buildingClassname] spawn {
		/* Variablen übergeben */
		private["_missionPosition"];
		_missionPosition = _this select 0;
		private["_missionInfoIndex"];
		_missionInfoIndex = _this select 1;
		private["_missionMarkerPosition"];
		_missionMarkerPosition = _this select 2;
		private["_missionMarkerRadius"];
		_missionMarkerRadius = _this select 3;
		private["_buildingClassname"];
		_buildingClassname = _this select 4;
		/*-------------------------*/
		/* Missions vorbereitungen */
		/*-------------------------*/
		/* Munitionskisten suchen (warten bis erzeugt) */
		private["_counter"];
		_counter = 20;
		private["_objects"];
		_objects = [];
		while { (count _objects != 1) && (_counter > 0) } do
		{
			Sleep 0.5;
			_objects = nearestObjects [_missionPosition, [_buildingClassname], 100];
			_counter = _counter - 1;
		};
		
		/* Action Menü zu den Objekten hinzufügen */
		{ _x addAction["Sprengladung platzieren", "missionsOpt\diveDestroy\actionPlaceCharge.sqf"]; } foreach _objects;

		/*----------------------------------------*/
		/* Standart Missions verarbeitung starten */
		/*----------------------------------------*/
		private["_taskTitle"];
		_taskTitle = "Container zerstören";
		private["_taskDescription"];
		_taskDescription = "Wir haben einen Container mit geheimem Material verloren. Finden und zerstören sie den Container.";
		private["_tmp"];
		_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
	};
};

if (isServer) then
{
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];
	
	/*--------------------*/
	/* Fahrzeug erstellen */
	/*--------------------*/
	private["_container"];
	_container = _buildingClassname createVehicle _missionPosition;
	_container setdir (random 360);
	_container setPosASL _missionPosition;
	_buildings = _buildings + [_container];
	
	if (pixParamMissionOpt == 1) then
	{
		/*-------------------------*/
		/* Patroullierende Truppen */
		/*-------------------------*/
		for "_i" from 0 to 3 do 
		{
			private["_groupInfos"];
			_groupInfos = [["OI_diverTeam"], _zoneIndex, _missionPosition, 500, 25] call PC_fnc_SpawnGroupPatrolObjectWater;		
			if (count _groupInfos > 0) then
			{
				_groups = _groups + [(_groupInfos select 0)];
				_vehicles = _vehicles + (_groupInfos select 1);
			};
		};
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {(!alive _container) || (pixZones_ActiveIndex == -1)};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	[_missionInfoIndex] call PC_fnc_FinishMissionStatus;

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};