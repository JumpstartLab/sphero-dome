# Sphero Examples

## Installation

```
$ bundle
```

## Sphero

The sphero command example allows you to write and save commands to a file and
have sphero execute those commands. Sphero will automatically execute the
commands written into the `sphero.rb` file whenever they are saved.

### Run

```
$ bundle exec ruby sphero_saddle.rb
```

### Write

* Open the file `sphero.rb` with your text editor
* Write commands
* Save the file

## Music Sphero

The music sphero command example allows you to write and save commands to a
file. Midi commands and commands to sphero will be executed every time a new
midi key has been pressed. Changes to the `midi.rb` file will automatically
be incorporated everytime the file is saved.

### Run

```
$ ruby midi_saddle.rb
```

### Write

* Open the file `midi.rb` with your text editor
* Write commands
* Save the file
