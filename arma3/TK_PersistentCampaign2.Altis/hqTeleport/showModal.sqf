#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_HQTELEPORT"; 	

private["_vehicles"];
_vehicles = entities "B_APC_Wheeled_01_cannon_F";
player sidechat format["%1", _vehicles];


{
	private["_position"];
	_position = getPos _x;	
	lbAdd [PIXLOGISTIC_IDC_DIALOG_HQTELEPORT_List, format["%1 / %2", round(_position select 0), round(_position select 1)]];
} foreach _vehicles;
lbSetCurSel [PIXLOGISTIC_IDC_DIALOG_HQTELEPORT_List, 0];


pixLogisticDialogHqTeleport_ButtonOK = 0;
pixLogisticDialogHqTeleport_Selection = -1;
waitUntil { !dialog };


if (pixLogisticDialogHqTeleport_ButtonOK == 1) then
{		
	private["_position"];
	_position = getPos (_vehicles select pixLogisticDialogHqTeleport_Selection);
	_position = _position findEmptyPosition [5, 50, (typeof player)];
	if (count _position > 0) then
	{
		player setPos _position;
	}
	else
	{
		player setPos getPos (_vehicles select pixLogisticDialogHqTeleport_Selection);
	};
};
pixLogisticDialogHqTeleport_Selection = nil;
