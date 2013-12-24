private ["_cursorTarget"];
_cursorTarget = cursorTarget;
if !(isNull _cursorTarget) then
{
	private["_cursorTargetType"];
	_cursorTargetType = typeof _cursorTarget;
	if (_cursorTargetType == pixlogisticBuildingContainer) then
	{
		private["_position"];
		_position = getPos _cursorTarget;
		private["_direction"];
		_direction = getDir _cursorTarget;
		private["_buildingType"];
		_buildingType = _cursorTarget getVariable "pixLogisticContent";
		if (count _buildingType == 1) then
		{
			_buildingType = _buildingType select 0;
			if ((_buildingType in pixlogisticBuildings) || (_buildingType in pixlogisticHQs) || (_buildingType in pixlogisticBuildingsService) || (_buildingType in pixlogisticBuildingsBarracks)) then
			{
				/*-------------------------*/
				/* Das alte Objekt löschen */
				/*-------------------------*/
				if (isServer && !isDedicated) then
				{
					player globalChat "INFO: simulate server";
					[_cursorTarget] execVM "pixLogistic\serverDeleteItem.sqf";
				}
				else
				{
					pvehPixlogisticDeleteItem = _cursorTarget;
					publicVariable "pvehPixlogisticDeleteItem";
				};

				/*--------------------------------------*/
				/* Das Gebäude dafür erzeugen */
				/*--------------------------------------*/
				private["_object"];
				_object = [_buildingType, _position] call fn_pixLogistic_CreateCorrectedVehicle;/*_object = createVehicle [_buildingType, _position, [], 0, "NONE"];*/
				Sleep .2;		
				_object setDir _direction;
				_object setPos _position;

				/* zur Datenbank hinzufügen*/
				if (isServer && !isDedicated) then
				{
					player globalChat "INFO: simulate server";
					[_object] execVM "pixLogistic\serverInsertItem.sqf";
				}
				else
				{
					pvehPixlogisticInsertItem = _object;
					publicVariable "pvehPixlogisticInsertItem";
				};				
			};
		};
	};
};
