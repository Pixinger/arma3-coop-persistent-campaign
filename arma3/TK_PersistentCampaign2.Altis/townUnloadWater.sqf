 // _this variable is: [target, caller, ID, arguments]
 private["_target"];
 _target = _this select 0; 
 _position = (getPos _target) findEmptyPosition [0, 40, pixTown_ConfigWaterClassname]; 
if (count _position > 0) then
{
	private["_item"];
	_item = pixTown_ConfigWaterClassname createVehicle _position;
	_item setPos (_position);
	_item setVariable["content", 10, true];	
}
else
{
	player sidechat "Kein Platz für das Wasserfass!";
};
