/* PixRevive is massively based on Farooq's Revive 1.4d */
/* It was rewritten by Pixinger due to incompatibility to the switchUnit command */
if (!isServer || !isDedicated) then
{
	waitUntil {!isNull player};
	
	while { true } do
	{
		waitUntil {alive player};

		private["_playerObject"];
		_playerObject = player;
		_playerObject setVariable ["pixRevive_UNC", 0, true]; /* is unconscious */
		_playerObject setVariable ["pixRevive_DRG", 0, true]; /* is dragged */
		
		pixRevive_CanDrag = false;
		pixRevive_CanRevive = false;
		pixRevive_CanSuicide = false;
		pixRevive_IsDragging = false;

		private["_isMedic"];
		if (getNumber (configfile >> "CfgVehicles" >> typeOf _playerObject >> "attendant") == 1) then { _isMedic = true; } else { _isMedic = false; };
		
		/* addAction args: title, filename, (arguments, priority, showWindow, hideOnUse, shortcut, condition, positionInModel, radius, radiusView, showIn3D, available, textDefault, textToolTip) */
		_playerObject addAction ["<t color=""#C90000"">" + "Drag" + "</t>", "pixRevive\actionDrag.sqf", [], 9, false, true, "", "pixRevive_CanDrag"];
		_playerObject addAction ["<t color=""#C90000"">" + "Suicide" + "</t>", "pixRevive\actionSuicide.sqf", [], 9, false, true, "", "pixRevive_CanSuicide"];
		if (_isMedic) then { _playerObject addAction ["<t color=""#C90000"">" + "Revive" + "</t>", "pixRevive\actionRevive.sqf", [], 10, true, true, "", "pixRevive_CanRevive"]; };
		
		_playerObject removeAllEventHandlers "HandleDamage";
		_playerObject addEventHandler ["HandleDamage", fnEH_HandleDamage];
		_playerObject addEventHandler ["Respawn", fnEH_Respawn];
	
		while { _playerObject == player } do /* Solange die Figur nicht per switchUnit gewechselt wird, trifft genau diese Bedingung zu. */
		{
			pixRevive_CanDrag = call fnCanDrag;
			pixRevive_CanSuicide = call fnCanSuicide;		
			if (_isMedic) then { pixRevive_CanRevive = call fnCanRevive;};
			
			if (animationState _playerObject == "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon" || animationState _playerObject == "helper_switchtocarryrfl" || animationState _playerObject == "AcinPknlMstpSrasWrflDnon") then
			{
				if (pixRevive_IsDragging) then
				{
					_playerObject switchMove "AcinPknlMstpSrasWrflDnon";
				}
				else
				{
					_playerObject switchMove "amovpknlmstpsraswrfldnon";
				};
			};
				
			Sleep 1;
		};
		
		deleteVehicle _playerObject; /* Sicherheitshalber löschen, wahrscheinlich hat sich aber das SwitchUnit skript schon darum gekümmert. */
		player globalchat "finished player object";
	};	
};