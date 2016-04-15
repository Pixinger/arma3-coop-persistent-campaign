private["_object"];
_object = _this select 0;

// Entladen
detach _object;

// Freien Platz suchen
private["_position"];
_position = (position player) findEmptyPosition [0,100, typeof _object];

// Auf freien Platz setzen
_object setPos _position;