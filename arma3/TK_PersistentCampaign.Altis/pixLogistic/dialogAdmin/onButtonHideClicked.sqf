closeDialog 0;
pvehPixlogisticHidePlayer = [player, _this select 0];
publicVariableServer "pvehPixlogisticHidePlayer";
if (!isDedicated) then	{ pvehPixlogisticHidePlayer call compile preprocessFileLineNumbers "pixLogistic\serverHideObject.sqf"; }; /* PublicVariableEventHandler simulieren */

    