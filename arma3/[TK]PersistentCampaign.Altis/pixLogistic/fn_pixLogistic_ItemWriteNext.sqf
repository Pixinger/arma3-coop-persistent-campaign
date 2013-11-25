/* _this select 0: Datensatz */
private["_response"];
_response = "OK";

private["_text"];
_text = _this select 0;
if (_text != "["""",[],[0,0,0],0,0]") then
{
	_response = "pixLogistic" callExtension format["WriteNext,%1", _text];
};
_response;
