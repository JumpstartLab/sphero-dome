#
#  .----------------.
# | .--------------. |  I AM SPHERO! I can do a lot of things:
# | |     ____     | |
# | |   .'    `.   | |  sphero.color("azure")
# | |  /  .--.  \  | |  sphero.roll(SPEED,DIRECTION_IN_DEGREES)
# | |  | |    | |  | |  sphero.stop
# | |  \  `--'  /  | |
# | |   `.____.'   | |
# | |              | |
# | '--------------' |
#  '----------------'

if note.note_name == "C"
  puts "I just played a C"
  sphero.color("green")
  puts "Setting the heading"
end

if note.velocity > 100
  puts "I just played a note really hard"
  sphero.color("gold")
end