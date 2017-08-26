class BitmapEditor
  attr_reader :output_file

  include BitmapReaderWriterMethods

  def initialize
    @output_file ||= File.open('examples/image.txt', 'a+')
  end

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)

    File.open(file).each do |_line|
      line = _line.chomp
      case line
        when 'S'
          self.output_file.to_s
        else
          puts 'unrecognised command :('
      end
    end
  end
end
