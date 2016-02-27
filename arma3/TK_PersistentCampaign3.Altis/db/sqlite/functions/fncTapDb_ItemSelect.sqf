private["_duration"];
_duration = diag_tickTime;

private["_table"];
_table = _this select 0;
private["_itemId"];
_itemId = _this select 1;

private["_result"];
_result = "Arma2NET" callExtension format["TAP item|select|%1|%2", _table, _itemId];
diag_log format ["[DURATION] ItemSelect: %1", (diag_tickTime - _duration) ];
_result;
