module BitmapReaderWriterMethods
  def create_m_x_n_bitmap_image_text_file(m, n)
    image_contents = ""
    # For the given n rows and m columns
    # Form the image table and write into the output file.
    n.times do |i|
      m.times do
        image_contents += "O"
      end

      # Writes into new row.
      # Don't add new line at the last row.
      image_contents += "\n" unless i+1 == n
    end

    File.open(BitmapEditor::OUTPUT_FILE, 'w') do |file|
      file.write(image_contents)
    end
  end

  def color_x_y_pixels(x, y, color)
  end

  def color_vertical_segments(x, y1, y2, color)
  end

  def color_horizontal_segments(x1, x2, y, color)
  end

  def show_the_file_contents
    puts File.read(BitmapEditor::OUTPUT_FILE)
  end

  def clear_the_file_contents
    File.open(BitmapEditor::OUTPUT_FILE, 'w') do |file|
      file.write('')
    end
  end
end
