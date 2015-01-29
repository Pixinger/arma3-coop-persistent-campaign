/*

	_rootObject: _this select 0
	_count: _this select 1;
	_distance: _this select 2;

*/

if (isServer) then
{
	_this spawn {
		private["_rootObject"];
		_rootObject = _this select 0;
		private["_count"];
		_count = _this select 1;
		private["_distance"];
		_distance = _this select 2;
		
		for "_i" from 1 to _count do
		{
			private["_object"];
			_object = [typeof _rootObject, getPos _rootObject] call PC_fnc_CreateCorrectedVehicle;
			//_object setPos (getPos _rootObject);
			Sleep .2;
			_object setDir (getDir _rootObject);
			_object setPos [((getPos _rootObject) select 0), ((getPos _rootObject) select 1), ((getPos _rootObject) select 2) + (_i * _distance)];
		};
	};
};