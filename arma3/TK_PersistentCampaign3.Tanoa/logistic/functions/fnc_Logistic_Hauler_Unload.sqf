private["_hauler"];
_hauler = vehicle player;

private["_haulerIndex"];
_haulerIndex = logisticHaulers find (typeOf _hauler);
if (_haulerIndex >= 0) then 
{
	if (driver _hauler == player) then
	{	
		if (count attachedObjects _hauler > 0) then 
		{
			private _cargo = (attachedObjects _hauler) select 0;			

			private["_cargoIndex"];
			_cargoIndex = logisticHaulables find (typeOf _cargo);
			if (_cargoIndex >= 0) then 
			{
				// Cargo Daten
				private _cargoConfig = logisticHaulableConfigs select _cargoIndex;
				private _cargoAttachOffset = _cargoConfig select 0;
				private _cargoAttachRotation = _cargoConfig select 1;			
				private _cargoTowing = _cargoConfig select 2;				
				
				private["_position"];
				if (!_cargoTowing) then
				{
					// Freien Platz suchen
					_position = [(_hauler modelToWorld [0,-8,0]), typeof _cargo] call PIX_fnc_FindEmptyPositionClosest;
				}
				else
				{
					_position = getPosATL _cargo;
					_position set [2,0];
				};

				
				/* Entkoppeln */
				detach _cargo;
				_cargo setPosATL _position;	
				hint localize "str_pc3_OneObjectSuccessfullyUnloaded";
			}
			else
			{
				detach _cargo;
				hint "Ladungsart konnte nicht bestimmt werden.";
			};
		}
		else
		{
			hint "Es kracht, es knackt... aber es fällt nichts runter. War wohl nichts geladen.";
		};
	}
	else
	{
		hint "Nur der Fahrer kann die Laderampe bedienen. Deine Arme sind zu kurz um an den Hebel zu kommen.";
	};
};