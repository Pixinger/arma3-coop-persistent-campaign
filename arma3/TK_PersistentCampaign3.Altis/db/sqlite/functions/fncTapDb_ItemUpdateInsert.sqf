private["_duration"];
_duration = diag_tickTime;

private["_table"];
_table = _this select 0;
private["_itemId"];
_itemId = _this select 1;
private["_itemData"];
_itemData = _this select 2;

private["_dbResult"];	
_dbResult = "Arma2NET" callExtension format["TAP item|updateinsert|%1|%2|%3", _table, _itemId, _itemData];
if (_dbResult == "OK") exitWith { true };

private["_result"];
_result = (_dbResult == "OK");
diag_log format ["[DURATION] ItemUpdateInsert: %1", (diag_tickTime - _duration) ];
_result;
