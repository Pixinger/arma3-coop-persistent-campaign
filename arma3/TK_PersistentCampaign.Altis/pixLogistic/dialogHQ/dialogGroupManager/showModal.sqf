/* -----------------------------------------------------------------	*/
/* Dialog erstellen*/
#include "defines.hpp";
createDialog "PIXLOGISTIC_DIALOG_HQ_GROUPMANAGER"; 	

/* Gruppen zusammen suchen */
private["_groups"];
_groups = [];
{
	if (!((group _x) in _groups)) then
	{
		private["_group"];
		_group = group _x;
		private["_leader"];
		_leader = leader _group;
		private["_hasGroup"];
		_hasGroup = _leader getVariable "HasGroup";
		if (!isNil "_hasGroup") then
		{
			if (_hasGroup) then
			{
				_groups = _groups + [_group];
			};
		};
	};
} foreach playableUnits;

/* Listbox füllen*/
{
	lbAdd [PIXLOGISTIC_IDC_DIALOG_HQ_GROUPMANAGER_List, name (leader _x)];
} foreach _groups;
if (count _groups > 0) then
{
	lbSetCurSel [PIXLOGISTIC_IDC_DIALOG_HQ_GROUPMANAGER_List, 0];
};

/*-----------------------------------------------------------------	*/
/* Dialog anzeigen*/
pixLogisticDialogHqGroupManager_Button = -1;
pixLogisticDialogHqGroupManager_Selection = -1;
waitUntil { !dialog };
/*-----------------------------------------------------------------	*/

/* Create */
if (pixLogisticDialogHqGroupManager_Button == 1) then 
{		
	player setVariable ["HasGroup",true,true];
	player setUnitRank "COLONEL";
	
	private["_group"];
	_group = createGroup west;
	[player] join _group;	
	player globalChat "INFO: Gruppe erstellt";
};
/* Join */
if ((pixLogisticDialogHqGroupManager_Button == 2) && (pixLogisticDialogHqGroupManager_Selection != -1)) then 
{		
	player setVariable ["HasGroup",false,true];
	player setUnitRank "MAJOR";

	private["_group"];
	_group = _groups select pixLogisticDialogHqGroupManager_Selection;	
	[player] join _group;	
	player globalChat "INFO: Gruppe begetreten";
};
/* Leave */
if (pixLogisticDialogHqGroupManager_Button == 3) then 
{		
	player setVariable ["HasGroup",false,true];
	player setUnitRank "PRIVATE";
	[player] join grpNull;	
	player globalChat "INFO: Gruppe verlassen";
};

pixLogisticDialogHqGroupManager_Button = nil;
pixLogisticDialogHqGroupManager_Selection = nil;
