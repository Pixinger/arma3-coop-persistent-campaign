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
		
		Sleep (random 5);
		
		private["_i"];
		_i = 0;
		while { _i < _count } do 
		{
			private["_spawnpos"];
			_spawnpos = (getPos _rootObject) findEmptyPosition [0,100,(typeof _rootObject)];
			/* Fahrzeug erstellen */
			private["_object"];
			_object = (typeof _rootObject) createVehicle _spawnpos;
			_object allowDamage false;
			waitUntil {!isNil "_object"};		
			Sleep .2;
			_object setDir (getDir _rootObject);
			_object setPos [((getPos _rootObject) select 0), ((getPos _rootObject) select 1), 2];
			Sleep (random 5);
			_object allowDamage true;
			_i = _i + 1;
		};
	};
};