// YOU PROBABLY NEED TO "SWITCH TO 0." IN THE KOS TERMINAL, FOLLOWED BY "RUN LAUNCH."
clearscreen.

LOCK THROTTLE TO 1.0.

print "Counting down:".
from {local countdown is 3.} until countdown = 0 step {set countdown to countdown - 1.} do {
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

SET SRB1 TO SHIP:PARTSTAGGED("SRB")[0].
WHEN SRB1:FLAMEOUT THEN {
    PRINT "STAGING TO LET SRBS GO".
    STAGE.
}

SET MYSTEER TO HEADING(90,90,270).
lock steering to MYSTEER.

DECLARE HORIZONTAL_TARGET_SPEED TO 1100.
LOCK VRATIO TO SHIP:velocity:surface:mag/HORIZONTAL_TARGET_SPEED.

UNTIL APOAPSIS > 100000 {
    SET PITCH TO 90 - (CHOOSE VRATIO*90 IF HORIZONTAL_TARGET_SPEED > SHIP:velocity:surface:mag ELSE 90).
    SET MYSTEER TO HEADING(90,PITCH,270).
    PRINT "PITCHING TO " + PITCH + " DEG" AT (0,15).
    PRINT "VELOCITY MAG: " + SHIP:velocity:surface:mag AT (0,16).
    PRINT "APO: " + ROUND(SHIP:APOAPSIS,0) AT (0,17).
}

print "100km APO reached, cutting throttle".
lock throttle to 0.
set ship:control:pilotmainthrottle to 0.
