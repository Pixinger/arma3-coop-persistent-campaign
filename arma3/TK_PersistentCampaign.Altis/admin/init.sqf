/* ---------------------------- */
/* Nur Client oder ServerClient */
/* ---------------------------- */
if (!isServer || !isDedicated) then
{
	/* Das Spawn ist nicht zwingend notwendig, aber verhindert dass die Initialisierung bockiert wird. */
	if ((getPlayerUID player in ["76561197990435624"]) || (isServer && !isDedicated))then
	{
		[] spawn {
			waitUntil {!isNull player};
			waitUntil {alive player};
			waituntil {!(IsNull (findDisplay 46))};
	
			pixAdminKeyPressed = false;

			private["_tmp"];
			_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if ((!pixAdminKeyPressed) && (_this select 1 == 24)) then { pixAdminKeyPressed = true; _tmp = [] execVM 'admin\showModal.sqf';}"];
		};
	};
};