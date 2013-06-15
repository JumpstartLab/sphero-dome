#
#  .----------------.
# | .--------------. |  I AM SPHERO! I can do a lot of things:
# | |     ____     | |
# | |   .'    `.   | |  sphero.color("azure")
# | |  /  .--.  \  | |  sphero.color(random_color)
# | |  | |    | |  | |  sphero.roll(SPEED, DIRECTION_IN_DEGREES)
# | |  \  `--'  /  | |  sphero.heading = DIRECTION_IN_DEGREES
# | |   `.____.'   | |  sphero.keep_going(TIME_IN_SECONDS)
# | |              | |  sphero.stop
# | '--------------' |
#  '----------------'

say "Sphero listens, Sphero obeys!"

sphero.color("green")
sphero.keep_going(3)
sphero.color("gold")