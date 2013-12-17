
if (player isKindOf "SoldierWB") then
{
	if (isNull pixlogisticMovingObject) then
	{	
		if ((typeof (vehicle player)) in pixlogisticHaulers) then
		{
			/*-------------------------------*/
			/* Wir sitzen in einem Schlepper */
			/*-------------------------------*/
			[] call compile preprocessFileLineNumbers "pixLogistic\clientAttachToHauler.sqf";			
		}
		else
		{
			private ["_cursorTarget"];
			_cursorTarget = cursorTarget;
			if !(isNull _cursorTarget) then
			{
				private["_scrp"];
				if (pixDebug) then { hint format["pixLogistic: %1", typeof(_cursorTarget)]; };
				
				if (player distance _cursorTarget < 13) then
				{
					private["_cursorTargetType"];
					_cursorTargetType = typeof _cursorTarget;
					
					if (_cursorTargetType in pixlogisticBuildingsService)  then
					{
						/*----------------------*/
						/* Show Service Actions */
						/*----------------------*/
						[_cursorTarget] call compile preprocessFileLineNumbers "pixLogistic\dialogService\showModal.sqf";
					}
					else
					{
						if (_cursorTargetType in pixlogisticBuildingsBarracks)  then
						{
							/*-----------------------*/
							/* Show Barracks Actions */
							/*-----------------------*/
							[_cursorTarget] call compile preprocessFileLineNumbers "pixLogistic\dialogBarracks\showModal.sqf";
						}
						else
						{
							if (_cursorTargetType in pixlogisticHQs)  then
							{
								/*-----------------*/
								/* Show HQ Actions */
								/*-----------------*/
								[_cursorTarget] call compile preprocessFileLineNumbers "pixLogistic\dialogHQ\showModal.sqf";
							}
							else
							{
								if (_cursorTargetType in pixlogisticBuildings)  then
								{
									/*---------------------------------*/
									/* Show Building Actions */
									/*---------------------------------*/
									[_cursorTarget] call compile preprocessFileLineNumbers "pixLogistic\dialogBuilding\showModal.sqf";
								}
								else
								{
									if (_cursorTargetType == pixlogisticBuildingContainer) then
									{
										/*--------------------------------*/
										/* Show Folded-Container Actions  */
										/*--------------------------------*/
										[_cursorTarget] call compile preprocessFileLineNumbers "pixLogistic\dialogFoldedBuilding\showModal.sqf";
									}
									else
									{
										if (_cursorTargetType in pixlogisticTransportVehicles)  then
										{	
											/*--------------------------*/
											/* Unload Transport-VEHICLE */
											/*--------------------------*/
											_scrp = [_cursorTarget] execVM "pixLogistic\dialogContent\showModal.sqf";					
											waituntil { scriptDone _scrp;};
										}
										else 
										{
											if (_cursorTargetType in pixlogisticTransportContainers)  then
											{	
												/*----------------------------*/
												/* Unload Transport-CONTAINER */
												/*----------------------------*/					
												_scrp = [_cursorTarget] execVM "pixLogistic\dialogContent\showModal.sqf";					
												waituntil { scriptDone _scrp;};
											}
											else 
											{	
												if (_cursorTargetType == "Land_Suitcase_F") then
												{
													_cursorTarget setDamage 1;
													_cursorTarget setPos [0,0,0];
												}
												else
												{
													/*--------------------*/
													/* Move object around */
													/*--------------------*/
													[_cursorTarget] call compile preprocessFileLineNumbers "pixLogistic\clientMoveObject.sqf";				
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	}
	else
	{
		hint "Du bewegst bereits einen Gegenstand. Dieser muss erst abgelegt werden.";
	};
	
	pixLogisitcActionKeyPressed = false; /* Die T-Taste wieder freigeben */
};
