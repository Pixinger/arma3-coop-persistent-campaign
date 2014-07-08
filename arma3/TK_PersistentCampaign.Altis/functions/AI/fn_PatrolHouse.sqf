/* 
	Diese Funktion lässt eine Gruppe in einer Stadt partollieren.
	Die Wegpunkte liegen alle in Gebäudepositionen.
	
Parameter:
	group: 				Die Gruppe die in der Stadt partollieren soll.
	zoneIndex: 			Der ZonenIndex der Zone die patrolliert werden soll.
	centerPosition: 	Die Position die patrolliert werden soll.
	radius: 			Der maximale Umkreis in dem patrolliert werden soll.
	(optional)
	zoneSafetyBorder: 	Sicherheitsabstand zum Rand.
	
	
Return: 
	Wenn erfolgreich true, sonst false.

/*-------------------------------------------------------------------*/

if (!isServer) exitWith {false};

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
if (isNull _group) exitwith {["Empty group parameter"] call BIS_fnc_error; false};

private["_zoneIndex"];
_zoneIndex = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_centerPosition"];
_centerPosition = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_centerPosition)=="[0,0,0]") exitwith {["Invalid centerPosition parameter"] call BIS_fnc_error; false};

private["_radius"];
_radius = [_this, 3, 100, [0]] call BIS_fnc_param;
if (_radius < 10) then { _radius = 10; };

private["_zoneSafetyBorder"];
_zoneSafetyBorder = [_this, 4, 25, [0]] call BIS_fnc_param;
if (_zoneSafetyBorder < 0) then { _zoneSafetyBorder = 0; };

/*-------------------------------------------------------------------*/

private["_result"];
_result = false;

_group setBehaviour "AWARE";
_group setSpeedMode "LIMITED";

/* Eine zufällige Anzahl an Wegpunkten erstellen */
for "_i" from 0 to (2 + floor (random 5)) do 
{
	private["_location"];
	_location = [_zoneIndex, _zoneSafetyBorder, _centerPosition, _radius] call PC_fnc_GetRandomLocationZoneHouse;
	if (str(_location) != "[[0,0,0],0]") then
	{
		private["_house"];
		_house = nearestObject [(_location select 0), "house"];
		if (!isNull _house) then
		{	
			if ([_zoneIndex, getPos _house, 25] call PC_fnc_IsPositionInZone) then
			{
				private["_maxIndex"];
				_maxIndex = 0;
				while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};

				if ((_maxIndex < 8) && (_maxIndex > 0)) then
				{
					private["_waypoint"];
					_waypoint = _group addWaypoint [_house buildingPos (floor random (_maxIndex)), 0];
					_waypoint setWaypointType "MOVE";
					_result = true;

					_group setFormation "COLUMN";
				};
			};
		};
	};
};

/* Der letzte Wegpunkt ist ein CYCLE Punkt */
private["_location"];
_location = [_zoneIndex, _zoneSafetyBorder, _centerPosition, _radius] call PC_fnc_GetRandomLocationZoneHouse;
if (str(_location) != "[[0,0,0],0]") then
{
	private["_house"];
	_house = nearestObject [(_location select 0), "house"];
	if (!isNull _house) then
	{	
		if ([_zoneIndex, getPos _house, 25] call PC_fnc_IsPositionInZone) then
		{
			private["_maxIndex"];
			_maxIndex = 0;
			while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};

			if ((_maxIndex < 8) && (_maxIndex > 0)) then
			{
				private["_waypoint"];
				_waypoint = _group addWaypoint [_house buildingPos (floor random (_maxIndex)), 0];
				_waypoint setWaypointType "CYCLE";
				_result = true;

				_group setFormation "COLUMN";
			};
		};
	};
};

if (!_result) exitwith {["PC_fnc_PatrolBuildings failed."] call BIS_fnc_error; false};

_result