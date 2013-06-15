require 'midi'
require 'erb'
require 'sphero'

puts "Connecting to Sphero..."

# class Sphero
#   def initialize(connection) ; end

#   def roll(*params)
#     puts "Rolling with #{params.inspect}"
#   end

#   def color(*args)
#     puts "Changing Color"
#   end

#   def stop
#     puts "Stopping"
#   end
# end


sphero = Sphero.new ENV['sphero'] || ARGV[0] || "/dev/tty.Sphero-GRR-RN-SPP"
puts "Connected to Sphero"

def random_color
  color = Sphero::COLORS.sample
  puts "Picked Color: #{color}"
  color
end

def sphero_template
  @sphero_template ||= ERB.new %{
 .----------------.
| .--------------. |
| |     ____     | |
| |   .'    `.   | |
| |  /  .--.  \\  | |  <%= @message %>
| |  | |    | |  | |
| |  \\  `--'  /  | |
| |   `.____.'   | |
| |              | |
| '--------------' |
 '----------------'
}
end

def say(message)
  @message = message
  puts sphero_template.result
end


NOTES = { "C" => %{
 .----------------.
| .--------------. |
| |     ______   | |  note.note_name : <%= note.note_name %>
| |   .' ___  |  | |  note.name      : <%= note.name %>
| |  / .'   \\_|  | |  note.velocity  : <%= note.velocity %>
| |  | |         | |
| |  \\ `.___.'\\  | |
| |   `._____.'  | |
| |              | |
| '--------------' |
 '----------------'
},
  "D" => %{
 .----------------.
| .--------------. |
| |  ________    | |  note.note_name : <%= note.note_name %>
| | |_   ___ `.  | |  note.name      : <%= note.name %>
| |   | |   `. \\ | |  note.velocity  : <%= note.velocity %>
| |   | |    | | | |
| |  _| |___.' / | |
| | |________.'  | |
| |              | |
| '--------------' |
 '----------------'
},
  "E" => %{
 .----------------.
| .--------------. |
| |  _________   | |  note.note_name : <%= note.note_name %>
| | |_   ___  |  | |  note.name      : <%= note.name %>
| |   | |_  \\_|  | |  note.velocity  : <%= note.velocity %>
| |   |  _|  _   | |
| |  _| |___/ |  | |
| | |_________|  | |
| |              | |
| '--------------' |
'----------------'
},
  "F" => %{
 .----------------.
| .--------------. |
| |  _________   | |  note.note_name : <%= note.note_name %>
| | |_   ___  |  | |  note.name      : <%= note.name %>
| |   | |_  \\_|  | |  note.velocity  : <%= note.velocity %>
| |   |  _|      | |
| |  _| |_       | |
| | |_____|      | |
| |              | |
| '--------------' |
 '----------------'
},
  "G" => %{
 .----------------.
| .--------------. |
| |    ______    | |  note.note_name : <%= note.note_name %>
| |  .' ___  |   | |  note.name      : <%= note.name %>
| | / .'   \\_|   | |  note.velocity  : <%= note.velocity %>
| | | |    ____  | |
| | \\ `.___]  _| | |
| |  `._____.'   | |
| |              | |
| '--------------' |
 '----------------'
},
  "A" => %{
 .----------------.
| .--------------. |
| |      __      | |  note.note_name : <%= note.note_name %>
| |     /  \\     | |  note.name      : <%= note.name %>
| |    / /\\ \\    | |  note.velocity  : <%= note.velocity %>
| |   / ____ \\   | |
| | _/ /    \\ \\_ | |
| ||____|  |____|| |
| |              | |
| '--------------' |
 '----------------'
},
  "B" => %{
 .----------------.
| .--------------. |
| |   ______     | |  note.note_name : <%= note.note_name %>
| |  |_   _ \\    | |  note.name      : <%= note.name %>
| |    | |_) |   | |  note.velocity  : <%= note.velocity %>
| |    |  __'.   | |
| |   _| |__) |  | |
| |  |_______/   | |
| |              | |
| '--------------' |
 '----------------'
}
}

NOTES.default = %{
 .----------------.
| .--------------. |
| |      _       | |  note.note_name : <%= note.note_name %>
| |   /\\| |/\\    | |  note.name      : <%= note.name %>
| |   \\     /    | |  note.velocity  : <%= note.velocity %>
| |  |_     _|   | |
| |   /     \\    | |
| |   \\/|_|\\/    | |
| |              | |
| '--------------' |
 '----------------'
}

puts %{
 .----------------.  .----------------.  .----------------.  .----------------.
| .--------------. || .--------------. || .--------------. || .--------------. |
| |   ______     | || |   _____      | || |      __      | || |  ____  ____  | |
| |  |_   __ \\   | || |  |_   _|     | || |     /  \\     | || | |_  _||_  _| | |
| |    | |__) |  | || |    | |       | || |    / /\\ \\    | || |   \\ \\  / /   | |
| |    |  ___/   | || |    | |   _   | || |   / ____ \\   | || |    \\ \\/ /    | |
| |   _| |_      | || |   _| |__/ |  | || | _/ /    \\ \\_ | || |    _|  |_    | |
| |  |_____|     | || |  |________|  | || ||____|  |____|| || |   |______|   | |
| |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'
}

input = UniMIDI::Input.list.first

MIDI.using(input) do
  thru_except :note

  receive :note do |note|
    return if note.velocity == 0 || note.status.first == 8

    # puts "#{note.inspect}"

    begin
      current_note_text = NOTES[note.note_name]
      current_note_template = ERB.new(current_note_text)
      puts current_note_template.result(binding)
      puts "\n"

    rescue Exception => exception
      puts "Exception: #{exception}"
    end

    begin
      eval File.read("music.rb")
    rescue Exception => exception
      puts "Exception: #{exception}"
    end

  end

  join

end
