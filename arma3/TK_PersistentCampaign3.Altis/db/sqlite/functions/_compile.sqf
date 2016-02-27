if (isServer) then  {
	fncTapDb_CargoInit = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_CargoInit.sqf";
	fncTapDb_CargoLoad = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_CargoLoad.sqf";
	fncTapDb_CargoSave = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_CargoSave.sqf";
	fncTapDb_CargoSelectIds = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_CargoSelectIds.sqf";
	fncTapDb_ItemInit = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_ItemInit.sqf";
	fncTapDb_ItemDelete = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_ItemDelete.sqf";
	fncTapDb_ItemSelect = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_ItemSelect.sqf";
	fncTapDb_ItemSelectIds = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_ItemSelectIds.sqf";
	fncTapDb_ItemUpdate = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_ItemUpdate.sqf";
	fncTapDb_ItemUpdateInsert = compile preprocessFileLineNumbers "db\sqlite\functions\fncTapDb_ItemUpdateInsert.sqf";
};