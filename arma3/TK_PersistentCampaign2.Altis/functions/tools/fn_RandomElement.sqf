/* 
Gibt ein zufälliges Element aus dem Array zurück.

Parameter:
	_array: Das Array

Return: 
	_element: Ein zufälliges Element aus dem Array
*/

private["_array"];
_array = _this select 0;

private["_result"];
_result = _array select (floor(random count _array));
_result;