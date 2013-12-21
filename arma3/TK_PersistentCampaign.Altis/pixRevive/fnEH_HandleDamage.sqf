/* 	
	In diesem Event Handler überprüfen, ob jemand >= 1 damage erhalten hat. Wenn das der Fall ist,
	wird die Einheit per Animation festgesetzt, unverwundbar gemacht und das sterben verhindert.
	Der EH bleibt dann in einer Schleife und überwacht die Einheit, bis diese verblutet ist oder 
	gerettet wurde. 
*/

private ["_unit"];
_unit = _this select 0;
private["_amountOfDamage"];
_amountOfDamage = _this select 2;
/*private["_killer"];_killer = _this select 3;*/

if (alive _unit) then
{
	if (_amountOfDamage >= 1) then
	{
		if ((_unit getVariable "pixRevive_UNC") == 0) then 
		{
			_unit setDamage 0;
			_unit allowDamage false;
			_amountOfDamage = 0; /* für als result verwendet */

			/* Ab hier müssen wir "unblocking" weiter arbeiten. der EH darf nicht blockiert werden. */
			[_unit] spawn {
				private["_unit"];
				_unit = _this select 0;
				
				/* Input deaktivieren */
				disableUserInput true;
				titleText ["", "BLACK FADED"];
				
				/* Eject wenn man in einem Fahrzeug sitzt */
				if (vehicle _unit != _unit) then 
				{
					unAssignVehicle _unit;
					_unit action ["eject", vehicle _unit];					
					sleep 2;
				};
				
				/* Die Einheit auf den Boden legen */
				_unit setDamage 0;
				_unit setVelocity [0,0,0];
				_unit allowDamage false;
				_unit setCaptive true;
				_unit playMove "AinjPpneMstpSnonWrflDnon_rolltoback";				
				sleep 4;
				
				/* Eingaben wieder aktivieren */
				titleText ["", "BLACK IN", 1];
				disableUserInput false;
				
				_unit switchMove "AinjPpneMstpSnonWrflDnon";
				_unit enableSimulation false;
				_unit setVariable ["pixRevive_UNC", 1, true];
				
				private["_bleedOut"];
				_bleedOut = time + pixRevive_Bleedout;
				
				while { (!isNull _unit) && (alive _unit) && (_unit getVariable "pixRevive_UNC" == 1) && (time < _bleedOut) } do
				{
					hintSilent format["Sie verbluten in %1 Sekunden", round (_bleedOut - time)];
					sleep 1;
				};
				
				/* Prüfen ob der Spieler verblutet ist */
				if (time > _bleedOut) then
				{
					/* Leider verblutet */
					_unit setDamage 1;
					_unit setVariable ["pixRevive_UNC", 0, true];
					_unit setVariable ["pixRevive_DRG", 0, true];
				}
				else
				{
					/* Nein, er wurde erfolgreich verarztet */
					private["_cnt"];
					_cnt = pixRevive_ReviveTime; 
					while {_cnt > 0} do
					{
						hintSilent format["Sie werden versorgt: %1", _cnt];
						_cnt = _cnt - 1;
						sleep 1;
					};
					hintSilent "";
					
					_unit enableSimulation true;
					_unit allowDamage true;
					_unit setDamage 0;
					_unit setCaptive false;
					
					_unit playMove "amovppnemstpsraswrfldnon";
					_unit playMove "";
				};		
			};
		};
	};
};

_amountOfDamage

