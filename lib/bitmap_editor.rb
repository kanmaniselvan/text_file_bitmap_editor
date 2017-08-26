class BitmapEditor
  INPUT_FILE = 'examples/show.txt'
  OUTPUT_FILE = 'examples/image.txt'

  include BitmapCommandValidator
  include BitmapReaderWriterMethods

  def run(file)
    return puts "Please provide correct file in the path `#{INPUT_FILE}`" if file.nil? || !File.exists?(file)

    File.open(file).each_with_index do |_line, index|
      line = _line.chomp
      line_args = line.split(' ')
      command = line[0]

      case command
        when 'I'
          validated_inputs = self.send("validate_#{command.downcase}_command_inputs", line_args)
          self.create_m_x_n_bitmap_image_text_file(*validated_inputs)

        when 'L'

        when 'V'

        when 'H'

        when 'S'
          self.show_the_file_contents

        when 'C'
          self.clear_the_file_contents

        else
          raise FeedbackError.new "At line #{index+1}: Command `#{line}` unrecognised! \n  Please use any of the following commands: \n    I M N - Creates a new M x N image with all pixels coloured white (O).\n    L X Y C - Colours the pixel (X,Y) with colour C.\n    V X Y1 Y2 C - Draws a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).\n    H X1 X2 Y C - Draws a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).\n    S - Shows the contents of the current image.\n    C - Clears the table, setting all pixels to white (O)."
      end
    end

  rescue FeedbackError => ex
    puts ex.message
  end
end
