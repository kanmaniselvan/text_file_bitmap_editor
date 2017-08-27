require './lib/bitmap_command_validator'
require './lib/bitmap_reader_writer_methods'
require './lib/bitmap_editor'

RSpec.describe BitmapEditor do
  context 'responds to it\'s reader writer instance methods' do
    before(:all) do
      @bitmap_editor = BitmapEditor.new
    end

    it 'responds to create_m_x_n_bitmap_image_text_file method' do
      expect(@bitmap_editor).to respond_to(:create_m_x_n_bitmap_image_text_file).with(2).arguments
    end

    it 'responds to color_x_y_pixels method' do
      expect(@bitmap_editor).to respond_to(:color_x_y_pixels).with(4).arguments
    end

    it 'responds to color_vertical_segments method' do
      expect(@bitmap_editor).to respond_to(:color_vertical_segments).with(5).arguments
    end

    it 'responds to color_horizontal_segments method' do
      expect(@bitmap_editor).to respond_to(:color_horizontal_segments).with(5).arguments
    end

    it 'responds to show_the_file_contents method' do
      expect(@bitmap_editor).to respond_to(:show_the_file_contents)
    end

    it 'responds to clear_the_file_contents method' do
      expect(@bitmap_editor).to respond_to(:clear_the_file_contents)
    end
  end
end
