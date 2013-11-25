private["_result"];
_result = objNull;
   
private["_vehicle"];
_vehicle  = (vehicle player);

if (_vehicle isKindOf "Helicopter") then 
{
	private["_objects"];
	_objects = nearestObjects [_vehicle, pixLogisticLiftObjects, 50];

	/* Eigenes Objekt entfernen */
	if (count _objects > 0) then { if (driver (_objects select 0) == player) then  { _objects set [0,0]; _objects = _objects - [0];};}; /* Nice trick */

	if (count _objects > 0) then 
	{
		_result = _objects select 0;
	};
};

_result;