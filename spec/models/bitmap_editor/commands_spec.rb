require './errors/feedback_error'
require './lib/bitmap_command_validator'
require './lib/bitmap_reader_writer_methods'
require './lib/bitmap_editor'

RSpec.describe BitmapEditor do
  context 'It performs all inputs commands' do
    before(:each) do
      @bitmap_editor = BitmapEditor.new
    end

    it 'it create file with M x N table contents written into it' do
      File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
        file.write('I 5 6')
      end

      @bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))

      expect(File.read(BitmapEditor::OUTPUT_FILE)).to eq("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO")
    end

    it 'colors the pixel in x and y position with the color C' do
      File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
        file.write('L 1 3 A')
      end

      @bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))

      expect(File.read(BitmapEditor::OUTPUT_FILE)).to eq("OOOOO\nOOOOO\nAOOOO\nOOOOO\nOOOOO\nOOOOO")
    end

    it 'draws a vertical segment of colour C in column X between rows Y1 and Y2' do
      File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
        file.write('V 2 3 6 W')
      end

      @bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))

      expect(File.read(BitmapEditor::OUTPUT_FILE)).to eq("OOOOO\nOOOOO\nAWOOO\nOWOOO\nOWOOO\nOWOOO")
    end

    it 'draws a horizontal segment of colour C in row Y between columns X1 and X2' do
      File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
        file.write('H 3 5 2 Z')
      end

      @bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))

      expect(File.read(BitmapEditor::OUTPUT_FILE)).to eq("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO")
    end

    it 'shows file content when S is received' do
      File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
        file.write('S')
      end

      # puts adds \n by default at the last. So handle it when reading from the STDOUT
      expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n").to_stdout
    end

    it 'clears file content when C is received' do
      File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
        file.write('C')
      end

      @bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))

      expect(File.read(BitmapEditor::OUTPUT_FILE)).to eq('')
    end

    it 'displays help commands when the received command is not recognized' do
      File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
        file.write('X')
      end

      # puts adds \n by default at the last. So handle it when reading from the STDOUT
      expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("At line 1: Command `X` unrecognised! \n  Please use any of the following commands: \n    I M N - Creates a new M x N image with all pixels coloured white (O).\n    L X Y C - Colours the pixel (X,Y) with colour C.\n    V X Y1 Y2 C - Draws a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).\n    H X1 X2 Y C - Draws a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).\n    S - Shows the contents of the current image.\n    C - Clears the table, setting all pixels to white (O).\n").to_stdout
    end
  end
end
