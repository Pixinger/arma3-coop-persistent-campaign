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
			private["_cargo"];
			_cargo = (attachedObjects _hauler) select 0;			

			// Freien Platz suchen
			private["_behind"];
			_behind = _hauler modelToWorld [0,-8,0]; 
			private["_distance"];
			_distance = 5;
			private["_position"];
			_position = _behind findEmptyPosition [0, _distance, typeof _cargo];
			while { count _position == 0 } do
			{
				_distance = _distance + 5;
				_position = _behind findEmptyPosition [0, _distance, typeof _cargo];
			};
			
			/* Entkoppeln */
			detach _cargo;
			_cargo setPosATL _distance;	
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