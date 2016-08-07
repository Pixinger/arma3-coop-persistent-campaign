private _aircraft = (vehicle player);
if (!(_aircraft isKindOf "Air")) exitWith { false; };

if ((getPosATL _aircraft) select 2 < 50) exitWith { false; };

if (count (attachedObjects _aircraft) == 0) exitWith { false; };

true;