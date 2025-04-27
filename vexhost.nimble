# Package

version       = "0.1.1"
author        = "Roger Padrell Casar"
description   = "A software to be an origin/host for vex repos"
license       = "MIT"
srcDir        = "src"
bin           = @["vexhost"]


# Dependencies

requires "nim >= 2.2.2"
requires "vexbox >= 0.2.2"
requires "libsha >= 1.0"
requires "jsony >= 1.1.5"
requires "jester >= 0.6.0"
requires "nimAES >= 0.1.2"