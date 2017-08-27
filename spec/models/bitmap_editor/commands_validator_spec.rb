require './errors/feedback_error'
require './lib/bitmap_command_validator'
require './lib/bitmap_reader_writer_methods'
require './lib/bitmap_editor'

RSpec.describe BitmapEditor do
  context 'validates I L V H commands' do
    before(:all) do
      @bitmap_editor = BitmapEditor.new
    end

    context 'validates I command' do
      it 'prints error if M value is not between 1 and 250' do
        File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
          file.write('I')
        end

        # puts adds \n by default at the last. So handle it when reading from the STDOUT
        expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("Invalid I command: M value should be between 1 and 250\n").to_stdout
      end

      it 'prints error if N value is not between 1 and 250' do
        File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
          file.write('I 10')
        end

        # puts adds \n by default at the last. So handle it when reading from the STDOUT
        expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("Invalid I command: N value should be between 1 and 250\n").to_stdout
      end
    end

    context 'validates L command' do
      it 'prints error if X value is not between 1 and Image\'s max column size' do
        File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
          file.write("I 10 10\nL 11 3 C")
        end

        # puts adds \n by default at the last. So handle it when reading from the STDOUT
        expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("Invalid L command: X value should be between 1 and 10\n").to_stdout
      end

      it 'prints error if Y value is not between 1 and Image\'s max row size' do
        File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
          file.write("I 10 10\nL 3 11 C")
        end

        # puts adds \n by default at the last. So handle it when reading from the STDOUT
        expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("Invalid L command: Y value should be between 1 and 10\n").to_stdout
      end

      it 'prints error if the color value is not a alphabet' do
        File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
          file.write("I 10 10\nL 3 1")
        end

        # puts adds \n by default at the last. So handle it when reading from the STDOUT
        expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("Invalid L command: Color value should be between A and Z\n").to_stdout
      end
    end

    context 'validates V command' do
      it 'prints error if the color value is not a alphabet' do
        File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
          file.write("I 10 10\nV 1 1 1")
        end

        # puts adds \n by default at the last. So handle it when reading from the STDOUT
        expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("Invalid V command: Color value should be between A and Z\n").to_stdout
      end
    end

    context 'validates H command' do
      it 'prints error if the color value is not a alphabet' do
        File.open(BitmapEditor::INPUT_FILE, 'w') do |file|
          file.write("I 10 10\nH 2 2 2")
        end

        # puts adds \n by default at the last. So handle it when reading from the STDOUT
        expect{@bitmap_editor.run(File.open(BitmapEditor::INPUT_FILE))}.to output("Invalid H command: Color value should be between A and Z\n").to_stdout
      end
    end
  end
end
