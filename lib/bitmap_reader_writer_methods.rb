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

    write_file_contents(image_contents)
  end

  def color_x_y_pixels(x, y, color, file_contents)
    # Replace the exact pixel in x column and y row and write it in the file.
    file_contents[y-1][x-1] = color

    image_contents = self.form_string_table_from_pixed_arrays(file_contents)
    write_file_contents(image_contents)
  end

  def color_vertical_segments(x, y1, y2, color, file_contents)
    (y1..y2).each do |pixel_index|
      file_contents[pixel_index-1][x-1] = color
    end

    image_contents = self.form_string_table_from_pixed_arrays(file_contents)
    write_file_contents(image_contents)
  end

  def color_horizontal_segments(x1, x2, y, color, file_contents)
  end

  def show_the_file_contents
    puts File.read(BitmapEditor::OUTPUT_FILE)
  end

  def clear_the_file_contents
    write_file_contents('')
  end

  protected
  def form_string_table_from_pixed_arrays(file_contents)
    image_contents = ""
    row_size = file_contents.size

    # From the given 2D array, join the elements of inner array,
    # add a new line for each row and then write that into as a string
    # which can be directly written to the image txt file.
    # This represent the string table of image txt file.
    file_contents.each_with_index do |file_array, index|
      image_contents += file_array.join('')

      image_contents += "\n" unless index+1 == row_size
    end

    image_contents
  end

  def write_file_contents(image_contents)
    File.open(BitmapEditor::OUTPUT_FILE, 'w') do |file|
      file.write(image_contents)
    end
  end
end
