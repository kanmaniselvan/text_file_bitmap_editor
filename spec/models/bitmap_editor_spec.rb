require_relative '../../lib/bitmap_reader_writer_methods.rb'
require_relative '../../lib/bitmap_editor.rb'

RSpec.describe BitmapEditor do
  context 'Responds to it\'s instance methods' do
    before(:all) do
      @bitmap_editor = BitmapEditor.new
    end

    it 'responds to create_m_x_n_image_file method' do
      expect(@bitmap_editor).to respond_to(:create_m_x_n_image_file).with(2).arguments
    end

    it 'responds to color_x_y_pixels method' do
      expect(@bitmap_editor).to respond_to(:color_x_y_pixels).with(3).arguments
    end

    it 'responds to color_vertical_segments method' do
      expect(@bitmap_editor).to respond_to(:color_vertical_segments).with(4).arguments
    end

    it 'responds to color_horizontal_segments method' do
      expect(@bitmap_editor).to respond_to(:color_horizontal_segments).with(4).arguments
    end

    it 'responds to show_the_file_contents method' do
      expect(@bitmap_editor).to respond_to(:show_the_file_contents)
    end

    it 'responds to clear_the_file_contents method' do
      expect(@bitmap_editor).to respond_to(:clear_the_file_contents)
    end
  end

  context 'It performs all inputs commands' do
    before(:each) do
      @bitmap_editor = BitmapEditor.new
    end

    xit 'shows file content when S is received' do
      #todo
    end

    it 'clears file content when C is received' do
      File.open('examples/show.txt', 'w') do |file|
        file.write('C')
      end

      @bitmap_editor.run(File.open('examples/show.txt'))

      expect(File.read('examples/image.txt')).to eq('')
    end

    it 'displays help commands when the received command is not recognized' do
      File.open('examples/show.txt', 'w') do |file|
        file.write('X')
      end

      expect{@bitmap_editor.run(File.open('examples/show.txt'))}.to output("At line 1: Command `X` unrecognised! \n  Please use any of the following commands: \n    I M N - Creates a new M x N image with all pixels coloured white (O).\n    L X Y C - Colours the pixel (X,Y) with colour C.\n    V X Y1 Y2 C - Draws a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).\n    H X1 X2 Y C - Draws a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).\n    S - Shows the contents of the current image.\n    C - Clears the table, setting all pixels to white (O).\n").to_stdout
    end
  end
end
