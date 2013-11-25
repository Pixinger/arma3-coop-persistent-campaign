/* _this select 0: Datensatz */
private["_response"];
_response = "pixZones" callExtension format["WriteNext,%1", _this select 0];
_response;
