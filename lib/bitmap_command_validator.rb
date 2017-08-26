module BitmapCommandValidator
  def validate_i_command_inputs(line_args)
    m_value = line_args[1].to_i
    n_value = line_args[2].to_i

    # The bitmap column value and row value should fall with 1 and 250
    if m_value < 0 || m_value > 255
      raise FeedbackError.new 'M value should be between 1 and 250'
    end

    if n_value < 0 || n_value > 255
      raise FeedbackError.new 'N value should be between 1 and 250'
    end

    # Return the validated values.
    [m_value, n_value]
  end

  def validate_l_command_inputs(line_args)
    x_value = line_args[1].to_i
    y_value = line_args[2].to_i
    color_value = line_args[3].to_s.upcase

    file_contents = File.read(BitmapEditor::OUTPUT_FILE).split("\n")
    m_value = file_contents.size
    n_value = file_contents.first.split('').size
    # Validate the x and y value such that it doesn't exceed the
    # written bitmap table in the image txt file.
    if 0 == x_value || x_value > m_value
      raise FeedbackError.new "X value should be between 1 and #{m_value}"
    end

    if 0 == y_value || y_value > n_value
      raise FeedbackError.new "Y value should be between 1 and #{n_value}"
    end

    # Validate the color value to be a proper alphabet
    if '' == color_value || !('A'..'Z').include?(color_value)
      raise FeedbackError.new 'Color value should be between A and Z'
    end

    # Split the file contents as 2D arrays, since it will be helpful in
    # finding and coloring the pixel.
    m_x_y_array_of_arrays = file_contents.map do |file_content|
      file_content.split('')
    end

    [x_value, y_value, color_value, m_x_y_array_of_arrays]
  end
end
