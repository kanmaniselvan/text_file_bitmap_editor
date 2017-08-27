module BitmapCommandValidator
  def validate_i_command_inputs(line_args)
    m_value = line_args[1].to_i
    n_value = line_args[2].to_i

    # The bitmap column value and row value should fall with 1 and 250
    if 0 == m_value || m_value > 250
      raise FeedbackError.new 'Invalid I command: M value should be between 1 and 250'
    end

    if 0 == n_value || n_value > 250
      raise FeedbackError.new 'Invalid I command: N value should be between 1 and 250'
    end

    # Return the validated values.
    [m_value, n_value]
  end

  def validate_l_command_inputs(line_args)
    x_value = line_args[1].to_i
    y_value = line_args[2].to_i

    validate_x_y_range(x_value, y_value, 'X', 'Y', 'L')
    color_value = validate_color(line_args[3])

    [x_value, y_value, color_value, get_m_x_y_array_of_arrays]
  end

  def validate_v_command_inputs(line_args)
    x_value = line_args[1].to_i
    y1_value = line_args[2].to_i
    y2_value = line_args[3].to_i

    validate_x_y_range(x_value, y2_value, 'X', 'Y2', 'V')
    color_value = validate_color(line_args[4])

    if 0 == y1_value || y1_value > y2_value
      raise FeedbackError.new "Invalid V command: Y1 value should be between 1 and #{y2_value}"
    end

    [x_value, y1_value, y2_value, color_value, get_m_x_y_array_of_arrays]
  end

  def validate_h_command_inputs(line_args)
    x1_value = line_args[1].to_i
    x2_value = line_args[2].to_i
    y_value = line_args[3].to_i

    validate_x_y_range(x2_value, y_value, 'X2', 'Y', 'H')
    color_value = validate_color(line_args[4])

    if 0 == x1_value || x1_value > x2_value
      raise FeedbackError.new "Invalid H command: X1 value should be between 1 and #{x2_value}"
    end

    [x1_value, x2_value, y_value, color_value, get_m_x_y_array_of_arrays]
  end

  protected
  # Split the file contents as 2D arrays, since it will be helpful in
  # finding and coloring the pixel.
  def get_m_x_y_array_of_arrays
    get_m_n_value_from_bitmap_file[:file_contents].map do |file_content|
      file_content.split('')
    end
  end

  # This return the column and row pixel of the image file.
  def get_m_n_value_from_bitmap_file
    file_contents = File.read(BitmapEditor::OUTPUT_FILE).split("\n")
    m_value = file_contents.size
    n_value = file_contents.first.split('').size

    { m_value: m_value,
      n_value: n_value,
      file_contents: file_contents }
  end

  def validate_color(color_arg)
    color_value = color_arg.to_s.upcase

    # Validate the color value to be a proper alphabet
    if '' == color_value || !('A'..'Z').include?(color_value)
      raise FeedbackError.new 'Color value should be between A and Z'
    end

    color_value
  end

  def validate_x_y_range(x_value, y_value, x_value_name, y_value_name, command)
    m_n_value = get_m_n_value_from_bitmap_file
    m_value = m_n_value[:m_value]
    n_value = m_n_value[:n_value]

    # Validate the x and y value such that it doesn't exceed the
    # written bitmap table in the image txt file.
    if 0 == x_value || x_value > m_value
      raise FeedbackError.new "Invalid #{command} command: #{x_value_name} value should be between 1 and #{m_value}"
    end

    if 0 == y_value || y_value > n_value
      raise FeedbackError.new "Invalid #{command} command: #{y_value_name} value should be between 1 and #{n_value}"
    end
  end
end
