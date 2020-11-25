from ahk import AHK
import time
import random
import sys

ahk = AHK()

cod_win = None

for w in list(ahk.windows()):
    if 'Cold War' in str(w.title):
        cod_win = w

if cod_win is None:
    raise ValueError('Could not find window for BLOPSCW, are you sure it is running?')

cod_win.enable()

## Uncomment for full backgrounding
#cod_win.minimize()

while True:
    ## Save previous state
    pos = ahk.mouse_position
    print("initial pos", pos)
    prevwin = ahk.active_window
    print(prevwin.title)

    cod_win.click(0, 0)
    print("post pos", ahk.mouse_position)
    prevwin.activate()
    ahk.mouse_position = pos

    ## TODO: This can be improved, as it does cause mouse dragging
    ## Ideally we should be checking to see if we are within a small radius of
    ## where the mouse previously was
    while ahk.mouse_position != pos:
        ahk.mouse_position = pos

    print("final pos", ahk.mouse_position)

    ## Don't ban us treyarch :^)
    time.sleep(random.uniform(0.25, 0.85))
