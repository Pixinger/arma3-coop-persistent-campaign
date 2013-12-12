private ["_object"];
_object = _this select 0;
private["_ignoreVehicle"];
_ignoreVehicle = objNull;
if (count _this > 1) then 
{
	_ignoreVehicle = _this select 1;
}
else
{
	_ignoreVehicle = objNull;
};


if (((typeof _object) in pixlogisticMovableObjects) || ((typeof _object) in pixlogisticTransportContainers))  then
{
	if (isNull(_object getVariable ["pixlogisticIsMoving",objNull])) then
	{
		pixlogisticMovingObject = _object; /* Überwacht das ablegen */

		/*---------------------------------------*/
		/* Objekt für andere Mitspieler sperren: */
		/*---------------------------------------*/
		_object setVariable ["pixlogisticIsMoving", 1, true];
				
		/*------------------*/
		/* Zeitverzögerung */
		/*------------------*/
		player playMove "AmovPknlMstpSnonWnonDnon";
		sleep 2;
		player playMove "AmovPknlMstpSnonWnonDnon";

		/*--------------------------------------------------------------------*/
		/* Mal schauen pb der Spieler vielleicht die Biege gemacht hat.*/
		if (!alive player) then
		{
			pixlogisticMovingObject = objNull;
			_object setVariable ["pixlogisticIsMoving", objNull, true];
			/* AttachTo because of "load" positions the object aloft:*/
			_object setPos [getPos _object select 0, getPos _object select 1, 0];
			_object setVelocity [0, 0, 0];
		}
		else
		{
			/* Für manche Objekte einen speziellen Offset bestimmen*/
			private["_offsetX"];
			_offsetX = 0;
			private["_offsetY"];
			_offsetY = 4;
			private["_offsetZ"];
			_offsetZ = .1;/*-1.4;*/
			private["_boundingBox"];
			_boundingBox = boundingBoxReal _object; /* An array with the extreme points of the model. Format [[x1,y1,z1],[x2,y2,z2]]. */
			private["_p1"];
			_p1 = _boundingBox select 0; 
			private["_p2"];
			_p2 = _boundingBox select 1; 
			private["_maxWidth"];
			_maxWidth = abs ((_p2 select 0) - (_p1 select 0)); 
			private["_maxLength"];
			_maxLength = abs ((_p2 select 1) - (_p1 select 1)); 
			private["_maxHeight"];
			_maxHeight = abs ((_p2 select 2) - (_p1 select 2));

			/*--------------------------------------------------------------------*/
			/* Jetzt fangen wir an das Objekt zu bewegen*/
			_object attachTo [player, [
				_offsetX,
				_offsetY + ((_maxLength+_maxWidth)/2),
				_offsetZ + _maxHeight]
			];

			private["_actionMenu"];
			_actionMenu = player addAction [("<t color=""#dddd00"">Ablegen</t>"), "pixLogistic\clientReleaseObject.sqf", nil, 5, true, true];
			
			/*--------------------------------------------------------------------*/
			/* Verschiedene Überwachungen*/
			while {!(isNull pixlogisticMovingObject) && (alive player)} do
			{
				if (vehicle player != player) then
				{
					player action ["eject", vehicle player];
					sleep 1;
				};
				
				if ([0,0,0] distance (velocity player) > 2.8) then
				{
					player playMove "AmovPpneMstpSnonWnonDnon";
					sleep 1;
				};
				
				/* Wenn es sich um bewegbare Objekte handelt, dann prüfen ob sie verladen werden sollen.*/
				if ((typeof _object) in pixlogisticMovableObjects) then
				{
							
					private["_vehicles"];
					_vehicles = nearestObjects [(getPos _object), pixlogisticTransportVehicles, 5]; 
					if (count _vehicles == 0) then { _vehicles = nearestObjects [(getPos _object), pixlogisticTransportContainers, 5]; };
					if (count _vehicles > 0) then
					{
						private["_vehicle"];
						_vehicle = _vehicles select 0;
						if (_ignoreVehicle != _vehicle) then
						{
							private["_ladung"];						
							_ladung = _vehicle getVariable "pixLogisticContent";
							if (isNil "_ladung") then {	_ladung = []; };
							
							/* Gesamtgröße der Ladung berechnen*/
							private["_index"];
							private["_totalLoad"];
							_totalLoad = 0;
							{
								_index = pixlogisticMovableObjects find _x;
								if (_index != -1) then { _totalLoad = _totalLoad + (pixlogisticMovableObjectsSize select _index); };
							} foreach _ladung;
							
							/* Maximale Ladefläche suchen*/
							private["_maxLoad"];
							_maxLoad = 0;
							_index = pixlogisticTransportVehicles find (typeOf _vehicle);
							if (_index != -1) then { _maxLoad = pixlogisticTransportVehiclesSize select _index;};
							if (_maxLoad == 0) then
							{
								_index = pixlogisticTransportContainers find (typeOf _vehicle);
								if (_index != -1) then { _maxLoad = pixlogisticTransportContainersSize select _index;};
							};
										
							/* Aktuelle Ladegröße suchen*/
							private["_currentLoad"];
							_currentLoad = 0;
							_index = pixlogisticMovableObjects find (typeOf _object);
							if (_index != -1) then { _currentLoad = (pixlogisticMovableObjectsSize select _index); };

							if (_totalLoad + _currentLoad > _maxLoad) then
							{
								player globalChat "Nicht genug Platz im Laderaum!";
							}
							else
							{
								_ladung set [count _ladung, typeof (_object)];
								_vehicle setVariable ["pixLogisticContent", _ladung, true];
								
								/* Aus der Datenbank entfernen*/
								if (isServer && !isDedicated) then
								{
									player globalChat "simulate server";
									[_object] execVM "pixLogistic\serverDeleteItem.sqf";
								}
								else
								{
									pvehPixlogisticDeleteItem = _object;
									publicVariable "pvehPixlogisticDeleteItem";
								};				
								
								_object = objNull;
								pixlogisticMovingObject = objNull;
							};
						};
					};
				};
					
				sleep 0.25;
			};

			
			player removeAction _actionMenu;
			pixlogisticMovingObject = objNull;

			/*--------------------------------------------------------------------*/
			/* Das Object soll abgelegt werden oder der Spieler ist tot*/
			if (!isNull _object) then
			{
				detach _object;
				_object setPos [getPos _object select 0, getPos _object select 1, 0];
				_object setVelocity [0, 0, 0];				
				_object setVariable ["pixlogisticIsMoving", objNull, true];
			};
		};
	}
	else
	{
		hint "Dieser Gegenstand wird bereits von jemand anderem bewegt.";
	};
}
else
{	
	hint format["Dieser Gegenstand ist nicht bewegbar (%1).", (typeof _object)];		
};	
