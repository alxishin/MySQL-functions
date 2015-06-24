FUNCTION DistantFromPointToLines(route linestring, point1 point)
  RETURNS decimal(9,6)
  DETERMINISTIC
BEGIN
  DECLARE i int DEFAULT 0;
  DECLARE minDistance,x,y,x0,y0,x1,y1,a,b,c,cosa,cosb,cosc decimal(9,6) DEFAULT 0.0;
  DECLARE currentDistance decimal(9, 6) DEFAULT 0.0;
  DECLARE currentpoint point;
  DECLARE size int DEFAULT 0;
  SET size = NUMPOINTS(route);
  SET i = 0;

  SET x = X(point1);
  SET y = y(point1);
  SET minDistance = -1;
simple_loop:
  LOOP
    SET i = i + 1;
    SET x0 = X(POINTN(route, i));
    SET y0 = y(POINTN(route, i));
    SET x1 = X(POINTN(route, i+1));
    SET y1 = y(POINTN(route, i+1));
    SET a = sqrt(pow(x1-x0,2) + pow(y1-y0,2));
    SET b = sqrt(pow(x-x0,2) + pow(y-y0,2));
    SET c = sqrt(pow(x1-x,2) + pow(y1-y,2));
    SET cosa = (POW(b,2)+POW(c,2)-POW(a,2))/(2*b*c);
    SET cosb = (POW(a,2)+POW(c,2)-POW(b,2))/(2*a*c);
    SET cosc = (POW(b,2)+POW(a,2)-POW(c,2))/(2*b*a);
    IF cosb < 0 OR cosc < 0
    THEN
      SET currentDistance = LEAST(c,b);
    ELSE
      SET currentDistance = LEAST(c,b,ABS(((y0-y1)*x+(x1-x0)*y+(x0*y1-x1*y0))/SQRT(POWER(x1-x0,2)+POWER(y1-y0,2))));
    END IF;
    IF minDistance = -1
    THEN
      SET minDistance = currentDistance;
    END IF;

    IF currentDistance < minDistance
    THEN
      SET minDistance = currentDistance;
    END IF;

    IF i = size
    THEN
      LEAVE simple_loop;
    END IF;
  END LOOP simple_loop;
  RETURN (minDistance);
END
