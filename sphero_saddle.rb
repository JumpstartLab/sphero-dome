require 'sphero'
require 'erb'
require 'listen'

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


Thread.abort_on_exception = true
Thread.new do
  listener = Listen.to(".")
  listener.change do |modified,added,removed|
    if modified.first == "sphero.rb"

      begin
        eval File.read(modified.first)

        say "Sphero is ALL DONE!"
        sphero.stop

      rescue Exception => exception
        say "Uh Oh! Sphero Go BOOM! #{exception}"
      end
    end

  end
  listener.start
end

sleep