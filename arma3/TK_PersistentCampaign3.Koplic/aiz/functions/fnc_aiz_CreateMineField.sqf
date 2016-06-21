#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

/* 
	Erzeugt ein Minenfeld.
	
Parameter:
	position: Die Position des Minenfeldes
	radius: Der Durchmesser des Minenfeldes
	count: Die Anzahl der Minen
	types: Die zu verwendenden Minentypen: ["APERSMine"]	
			-APERSMine
			-APERSBoundingMine
			-APERSTripMine
			-ATMine
			-SLAMDirectionalMine
			-UnderwaterMine

Return: 
	Always true.

/*-------------------------------------------------------------------*/

if (ExecuteHeadlessCode) then
{
	private["_position"];
	_position = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

	private["_radius"];
	_radius = [_this, 1, 100, [0]] call BIS_fnc_param;
	if (_radius < 10) then { _radius = 10; };

	private["_count"];
	_count = [_this, 2, 1, [0]] call BIS_fnc_param;
	if (_count < 1) then { _count = 1; };

	private["_types"];
	_types = [_this, 3, [], [[]] ] call BIS_fnc_param;

	/*-------------------------------------------------------------------*/

	private["_counter"];
	_counter = _count;
	while { _counter > 0 } do
	{ 
		_counter = _counter - 1;
		private["_type"];
		_type = _types call BIS_fnc_selectRandom;
		
		private["_posX"];
		_posX = (_position select 0) + (random (_radius*2) - _radius);
		private["_posY"];
		_posY = (_position select 1) + (random (_radius*2) - _radius);
		
		if (!surfaceIsWater [_posX,_posY]) then
		{		
			private["_mine"];
			_mine = createMine [_type, [_posX,_posY,0], [], 0];
			_mine setDir (random 360);
			pixTown_ConfigSideCiv revealMine _mine;
			pixTown_ConfigSideRed revealMine _mine;
			
			#ifdef MARKER_ENABLED
			_markername = [] call fnc_TownSM_GetUniqueMarkerName;
			createMarkerLocal [_markerName,  getPos _mine];
			_markerName setMarkerDirLocal (getDir _mine);
			_markerName setMarkerShapeLocal "ICON";
			_markerName setMarkerTypeLocal "mil_dot";
			_markerName setMarkerSizeLocal [.5, .5];
			_markerName setMarkerAlphaLocal 1;
			_markerName setMarkerColorLocal "ColorRed";
			_markerName setMarkerTextLocal "";
			#endif
		};
	};

};

true;