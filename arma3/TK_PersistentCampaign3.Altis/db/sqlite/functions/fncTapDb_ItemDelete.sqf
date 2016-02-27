private["_duration"];
_duration = diag_tickTime;

private["_table"];
_table = _this select 0;
private["_itemId"];
_itemId = _this select 1;

private["_dbResult"];	
_dbResult = "Arma2NET" callExtension format["TAP item|delete|%1|%2", _table, _itemId];

private["_result"];
_result = (_dbResult == "OK"); 
diag_log format ["[DURATION] ItemDelete: %1", (diag_tickTime - _duration) ];
_result;