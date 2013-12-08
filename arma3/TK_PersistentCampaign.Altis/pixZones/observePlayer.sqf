/* Client only */

/* Das Überprüfungsinterval */
#define PIXZONE_CHECKINTERVAL	1
/* Die erlaubte Zeit für Bodenfahrzeuge/-einheiten in einem gesperrten Sektor (in Sekunden) */
#define PIXZONE_ALLOWEDREDTIME_INF	15
/* Die erlaubte Zeit für Luftfahrzeuge in einem gesperrten Sektor (in Sekunden) */
#define PIXZONE_ALLOWEDREDTIME_AIR	30
/* Höhe über Grund ab wann die Einheit als Luftfahrzeug gewertet wird */
#define PIXZONE_ALLOWEDAIRALTITUDE	5


/* ------------------------- */
/* Client, oder Serverclient */
/* ------------------------- */
if (!isServer) then
{
	/* Erst nach dem Briefing starten */
	Sleep 0.1;
	
	/* los geht's */
	private["_zoneIndex"];
	while { true } do 
	{
		Sleep PIXZONE_CHECKINTERVAL;
		_zoneIndex = [getPos player] call PC_fnc_GetZoneIndex;		
		if ([_zoneIndex] call PC_fnc_IsZoneForbidden) then
		{
			private["_counter"];
			_counter = PIXZONE_ALLOWEDREDTIME_INF;
			if ((getPos player) select 2 > PIXZONE_ALLOWEDAIRALTITUDE) then { _counter = PIXZONE_ALLOWEDREDTIME_AIR; };
			hint format["You entered an prohibited area. Return immediately or you will be punished!\n\n%1 seconds left", _counter];
			while { ([_zoneIndex] call PC_fnc_IsZoneForbidden) && (_counter > 0) } do
			{
				Sleep 1;
				_counter = _counter - 1;
				_zoneIndex = [getPos player] call PC_fnc_GetZoneIndex;
				hint format["You entered an prohibited area. Return immediately or you will be punished!\n\n%1 seconds left", _counter];
			};
			
			/* Wer jetzt noch in der Zone ist, hat Pech... */
			if ([_zoneIndex] call PC_fnc_IsZoneForbidden) then
			{
				player setDamage 1;
			};
			hint "";			
		};
	};	
};
