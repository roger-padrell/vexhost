import os

proc clear*() = 
    for i in walkDirRec(getAppDir(), {pcDir}):
        removeDir(i)

if isMainModule:
    clear()