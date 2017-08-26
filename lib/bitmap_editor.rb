class BitmapEditor
  include BitmapReaderWriterMethods

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)

    File.open(file).each do |_line|
      line = _line.chomp
      case line
        when 'S'
          puts 'There is no image'
        else
          puts 'unrecognised command :('
      end
    end
  end
end
