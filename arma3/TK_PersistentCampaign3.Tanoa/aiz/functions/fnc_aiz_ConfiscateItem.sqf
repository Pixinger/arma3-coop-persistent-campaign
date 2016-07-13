private["_cursorTarget"];
_cursorTarget = cursorTarget;

if (_cursorTarget distance player < 5) then
{
	deleteVehicle _cursorTarget; 
	hint "Beschlagnahmt!";
}
else
{
	hint "Sie sind nicht nah genug!";
};