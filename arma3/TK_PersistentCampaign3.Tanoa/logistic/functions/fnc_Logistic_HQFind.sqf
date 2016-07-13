private _centerPosition = if (count _this > 0) then { _this select 0 } else { logisticDbMapCenter };
private _radius = if (count _this > 1) then { _this select 1 } else { logisticDbMapRadiusSqr };
nearestObjects [_centerPosition, [logisticObjectHQClassname], _radius];