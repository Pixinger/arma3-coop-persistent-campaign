/*
Inspired by =BTC= Giallustio
*/

/*--------------------------*/
/* Variablen initialisieren */
/*--------------------------*/
pixLogisticLift_AttachedObject = objNull;
pixLogisticLift_DialogHUDEnabled = false;
pixLogisticLift_DialogPiPEnabled = false;
pixLogisticLift_ShowMenuPiP = false;
pixLogisticLift_ShowMenuAttach = false;
pixLogisticLift_ShowMenuDetach = false;

/* -------------------------------- */
/* Spezielle Funktionen kompilieren */
/* -------------------------------- */
fn_pixLogisticLift_Attach = compile preprocessFileLineNumbers "pixLogistic\lift\fn_pixLogisticLift_Attach.sqf";
fn_pixLogisticLift_Detach = compile preprocessFileLineNumbers "pixLogistic\lift\fn_pixLogisticLift_Detach.sqf";
fn_pixLogisticLift_ObjectFall = compile preprocessFileLineNumbers "pixLogistic\lift\fn_pixLogisticLift_ObjectFall.sqf";
fn_pixLogisticList_AddActionMenus = compile preprocessFileLineNumbers "pixLogistic\lift\fn_pixLogisticList_AddActionMenus.sqf";
fn_pixLogisticLift_FindNearestObject = compile preprocessFileLineNumbers "pixLogistic\lift\fn_pixLogisticLift_FindNearestObject.sqf";


/*--------------------------------------------------*/
/* Clientside die Spielerüberwachung initialisieren */
/*--------------------------------------------------*/
if (!isServer || !isDedicated) then
{	
	[] spawn
	{			
		waitUntil {!isNull player};
		if ((pixLogisticLiftPilots find (typeof player)) != - 1) then
		{
			call fn_pixLogisticList_AddActionMenus;

			private["_inHeli"];
			_inHeli = false;
			/* Infinite Loop */
			while { true } do
			{
				Sleep 1;
			
				_inHeli = (((vehicle player) isKindOf "Helicopter") && (driver (vehicle player) == player));
				/*pixLogisticLift_ShowMenuPiP = (((vehicle player) isKindOf "Helicopter") && (driver (vehicle player) == player));*/
				pixLogisticLift_ShowMenuAttach = (_inHeli) && (isNull pixLogisticLift_AttachedObject);
				pixLogisticLift_ShowMenuDetach = (_inHeli) && (!(isNull pixLogisticLift_AttachedObject));
				
				if (!alive player) then
				{
					waitUntil {Sleep 1; alive player};
					call fn_pixLogisticList_AddActionMenus;
					pixLogisticLift_ShowMenuPiP = false;
					pixLogisticLift_ShowMenuAttach = false;
					pixLogisticLift_ShowMenuDetach = false;
				};			
			};
		};
	};
};