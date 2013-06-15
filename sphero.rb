#
#  .----------------.
# | .--------------. |  I AM SPHERO! I can do a lot of things:
# | |     ____     | |
# | |   .'    `.   | |  sphero.color("azure")
# | |  /  .--.  \  | |  sphero.roll(SPEED,DIRECTION_IN_DEGREES)
# | |  | |    | |  | |  sphero.heading = DIRECTION_IN_DEGREES
# | |  \  `--'  /  | |  sphero.keep_going(TIME_IN_SECONDS)
# | |   `.____.'   | |  sphero.stop
# | |              | |
# | '--------------' |
#  '----------------'

say "Sphero listens, Sphero obeys!"

sphero.color("green")
sphero.keep_going(3)
sphero.color("gold")