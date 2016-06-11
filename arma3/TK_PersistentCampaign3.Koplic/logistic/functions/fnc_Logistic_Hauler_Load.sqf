private["_hauler"];
_hauler = vehicle player;

private["_haulerIndex"];
_haulerIndex = logisticHaulers find (typeOf _hauler);
if (_haulerIndex >= 0) then 
{
	if (driver _hauler == player) then
	{	
		if (count attachedObjects _hauler == 0) then 
		{
			private["_behind"];
			_behind = _hauler modelToWorld [0,-8,0]; 

			private["_cargos"];
			_cargos = nearestObjects [_behind, logisticHaulables, 5];
			if (count _cargos > 0) then
			{
				private["_cargo"];
				_cargo = _cargos select 0;
			
				private["_cargoIndex"];
				_cargoIndex = logisticHaulables find (typeOf _cargo);
				if (_cargoIndex >= 0) then 
				{
					// Hauler Daten
					private["_haulerConfig"];
					_haulerConfig = logisticHaulerConfigs select _haulerIndex;
					private["_haulerAttachPoint"];
					_haulerAttachPoint = _haulerConfig select 0;

					// Cargo Daten
					private["_cargoConfig"];
					_cargoConfig = logisticHaulableConfigs select _cargoIndex;
					private["_cargoAttachOffset"];
					_cargoAttachOffset = _cargoConfig select 0;
					private["_cargoAttachRotation"];
					_cargoAttachRotation = _cargoConfig select 1;			

					// Zusammenrechnen
					private["_finalAttachPoint"];
					_finalAttachPoint = [(_haulerAttachPoint select 0) + (_cargoAttachOffset select 0), (_haulerAttachPoint select 1) + (_cargoAttachOffset select 1), (_haulerAttachPoint select 2) + (_cargoAttachOffset select 2)];

					// Attachen
					_cargo attachTo [_hauler, _finalAttachPoint];
					if (_cargoAttachRotation != 0) then 
					{
						[_cargo, [[1,0,0],[0,0,1]]]  remoteExec ["setVectorDirAndUp", _cargo];
					};
					
					hint "Erfolgreich aufgeladen!";
				};
			}
			else
			{
				hint "Nichts zum aufladen in der Nähe..."
			};
		}
		else
		{
			hint "Du hast schon Ladung auf dem LKW. Mehr is nich...";
		};
	}
	else
	{
		hint "Nur der Fahrer kann die Laderampe bedienen. Deine Arme sind zu kurz um an den Hebel zu kommen.";
	};
};