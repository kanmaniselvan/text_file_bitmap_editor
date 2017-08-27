require './errors/feedback_error'
require './lib/bitmap_command_validator'
require './lib/bitmap_reader_writer_methods'
require './lib/bitmap_editor'

RSpec.describe BitmapEditor do
  it 'processes all the commands and produces the expected image' do
    File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
      file.write("I 5 6\nL 1 3 A\nV 2 3 6 W\nH 3 5 2 Z\nS")
    end

    expect{ system('bin/bitmap_editor examples/show.txt') }.to output("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n").to_stdout_from_any_process
  end
end
