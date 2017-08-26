require_relative '../../lib/bitmap_reader_writer_methods.rb'
require_relative '../../lib/bitmap_editor.rb'

RSpec.describe BitmapEditor do
  context 'Creates or open a output file in examples/image.txt path' do
    it 'creates a output file in examples/image.txt path if not present' do
      path_to_image = 'examples/image.txt'
      FileUtils.rm('examples/image.txt')

      # Initialize
      BitmapEditor.new

      expect(File.exist?(path_to_image)).to be_truthy
    end

    it 'opens the output file and has the file as `output_file` attribute' do
      bitmap_editor = BitmapEditor.new

      expect(bitmap_editor.output_file).to be_truthy
    end
  end

  context 'Responding to it\'s attribute and instance methods' do
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
end
