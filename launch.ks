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

WAIT UNTIL STAGE:READY. // WAIT FOR ENGINE STAGE TO SETTLE

STAGE. // STAGE THE CLAMPS

SET MYSTEER TO HEADING(90,90).
lock steering to MYSTEER.

UNTIL APOAPSIS > 100000 {
    IF SHIP:velocity:surface:mag < 100 {
        SET MYSTEER TO HEADING(90,90).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
    } ELSE IF SHIP:velocity:SURFACE:MAG >= 100  AND SHIP:VELOCITY:SURFACE:MAG < 200 {
        SET MYSTEER TO HEADING(90,80).
        PRINT "PITCHING TO 80 DEG" AT (0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
    
    //Each successive IF statement checks to see if our velocity
    //is within a 100m/s block and adjusts our heading down another
    //ten degrees if so
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 200 AND SHIP:VELOCITY:SURFACE:MAG < 300 {
        SET MYSTEER TO HEADING(90,70).
        PRINT "Pitching to 70 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 300 AND SHIP:VELOCITY:SURFACE:MAG < 400 {
        SET MYSTEER TO HEADING(90,60).
        PRINT "Pitching to 60 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 400 AND SHIP:VELOCITY:SURFACE:MAG < 500 {
        SET MYSTEER TO HEADING(90,50).
        PRINT "Pitching to 50 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 500 AND SHIP:VELOCITY:SURFACE:MAG < 600 {
        SET MYSTEER TO HEADING(90,40).
        PRINT "Pitching to 40 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 600 AND SHIP:VELOCITY:SURFACE:MAG < 700 {
        SET MYSTEER TO HEADING(90,30).
        PRINT "Pitching to 30 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 700 AND SHIP:VELOCITY:SURFACE:MAG < 800 {
        SET MYSTEER TO HEADING(90,11).
        PRINT "Pitching to 20 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    //Beyond 800m/s, we can keep facing towards 10 degrees above the horizon and wait
    //for the main loop to recognize that our apoapsis is above 100km
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 800 {
        SET MYSTEER TO HEADING(90,10).
        PRINT "Pitching to 10 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    }.
}

print "100km APO reached, cutting throttle".
lock throttle to 0.
set ship:control:pilotmainthrottle to 0.
