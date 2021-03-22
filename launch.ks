clearscreen.

LOCK THROTTLE TO 1.0.

print "Counting down:".
from {local countdown is 4.} until countdown = 0 step {set countdown to countdown - 1.} do {
    print "..." + countdown.
    wait 1.
}

WHEN MAXTHRUST = 0 THEN {
    PRINT "STAGING".
    STAGE.
    PRESERVE.
}

STAGE. // STAGE THE CLAMPS

SET MYSTEER TO HEADING(90,90).
lock steering to MYSTEER.

UNTIL APOAPSIS > 100000 {
    IF SHIP:velocity:surface:mag < 100 {
        SET MYSTEER TO HEADING(90,90).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
    } ELSE IF SHIP:velocity:SURFACE:MAG >= 100 {
        SET MYSTEER TO HEADING(90,80).
        PRINT "PITCHING TO 80 DEG" AT (0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
    }
}