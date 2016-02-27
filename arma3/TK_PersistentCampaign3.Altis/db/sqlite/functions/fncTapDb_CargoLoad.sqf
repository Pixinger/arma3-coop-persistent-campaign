private["_duration"];
_duration = diag_tickTime;

private["_cargoObject"];
_cargoObject = _this select 0;
private["_table"];
_table = _this select 1;
private["_cargoId"];
_cargoId = _this select 2;

clearWeaponCargoGlobal _cargoObject;
clearMagazineCargoGlobal _cargoObject;
clearItemCargoGlobal _cargoObject;
clearBackpackCargoGlobal _cargoObject;

private["_dbResult", "_cargoArray","_cargoType", "_timeout"];
_cargoType = "WPN";
_timeout = 10;
_dbResult = "";
while { true } do
{
	_dbResult = "Arma2NET" callExtension format["TAP cargo|select|%1|%2|%3", _table, _cargoId, _cargoType];	
	if ((_dbResult != "ERROR_CARGO_SELECT_ACTIVE") || (_timeout <= 0)) exitWith {};	
	Sleep 1;
	_timeout = _timeout - 1;
};
if (_dbResult == "OK") then {
	_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	while { (_dbResult != "EOF") && (_dbResult != "ERROR") } do {
		_cargoArray = call compile _dbResult;
		_cargoObject addWeaponCargoGlobal _cargoArray;
		_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	};
};

_cargoType = "MAG";
_timeout = 10;
_dbResult = "";
while { true } do
{
	_dbResult = "Arma2NET" callExtension format["TAP cargo|select|%1|%2|%3", _table, _cargoId, _cargoType];	
	if ((_dbResult != "ERROR_CARGO_SELECT_ACTIVE") || (_timeout <= 0)) exitWith {};	
	Sleep 1;
	_timeout = _timeout - 1;
};
if (_dbResult == "OK") then {
	_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	while { (_dbResult != "EOF") && (_dbResult != "ERROR") } do {
		_cargoArray = call compile _dbResult;
		_cargoObject addMagazineCargoGlobal _cargoArray;
		_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	};
};

_cargoType = "ITM";
_timeout = 10;
_dbResult = "";
while { true } do
{
	_dbResult = "Arma2NET" callExtension format["TAP cargo|select|%1|%2|%3", _table, _cargoId, _cargoType];	
	if ((_dbResult != "ERROR_CARGO_SELECT_ACTIVE") || (_timeout <= 0)) exitWith {};	
	Sleep 1;
	_timeout = _timeout - 1;
};
if (_dbResult == "OK") then {
	_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	while { (_dbResult != "EOF") && (_dbResult != "ERROR") } do {
		_cargoArray = call compile _dbResult;
		_cargoObject addItemCargoGlobal _cargoArray;
		_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	};
};

_cargoType = "BKP";
_timeout = 10;
_dbResult = "";
while { true } do
{
	_dbResult = "Arma2NET" callExtension format["TAP cargo|select|%1|%2|%3", _table, _cargoId, _cargoType];	
	if ((_dbResult != "ERROR_CARGO_SELECT_ACTIVE") || (_timeout <= 0)) exitWith {};	
	Sleep 1;
	_timeout = _timeout - 1;
};
if (_dbResult == "OK") then {
	_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	while { (_dbResult != "EOF") && (_dbResult != "ERROR") } do {
		_cargoArray = call compile _dbResult;
		_cargoObject addBackpackCargoGlobal _cargoArray;
		_dbResult = "Arma2NET" callExtension "TAP cargo|selectnext";	
	};
};
diag_log format ["[DURATION] CargoLoad: %1", (diag_tickTime - _duration) ];
