class VideoUploader < CarrierWave::Uploader::Base
  # include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::Video
  include CarrierWave::MiniMagick

  # RESOLUTIONS = [
  #     { version: :p1080, resolution: '1920x1080'},
  #     { version: :p720, resolution: '1280x720'}
  #   ]

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  before :store, :remember_cache_id
  after :store, :delete_tmp_dir

  # store! nil's the cache_id after it finishes so we need to remember it for deletion
  def remember_cache_id(new_file)
    @cache_id_was = cache_id
  end

  def delete_tmp_dir(new_file)
    # make sure we don't delete other things accidentally by checking the name pattern
    if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
      FileUtils.rm_rf(File.join(root, cache_dir, @cache_id_was))
    end
  end

  version :mp4 do
    process encode_video: [:mp4]

    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.mp4'
    end

    # RESOLUTIONS.each do |resolution|
    #   version resolution[:version], if: "bigger_than_#{resolution[:resolution]}?".to_sym
    #
    #   version resolution[:version] do
    #     process encode_video: [:mp4, resolution: resolution[:resolution]]
    #   end
    # end
  end
  version :thumb do
    process :resize_to_fit => [200, 200]
  end

  version :small do
    process :resize_to_fit => [350, 350]
    # process :quality => 100
  end

  version :medium do
    process :resize_to_fit => [500, 500]
    # process :quality => 100
  end
  version :webm do
    process encode_video: [:webm]

    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.webm'
    end
    #
    # RESOLUTIONS.each do |resolution|
    #   version resolution[:version], if: "bigger_than_#{resolution[:resolution]}?".to_sym
    #
    #   version resolution[:version] do
    #     process encode_video: [:webm, resolution: resolution[:resolution]]
    #   end
    # end
  end

  version :ogv do
    process encode_video: [:ogv]

    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.ogv'
    end

    # RESOLUTIONS.each do |resolution|
    #   version resolution[:version], if: "bigger_than_#{resolution[:resolution]}?".to_sym
    #
    #   version resolution[:version] do
    #     process encode_video: [:ogv, resolution: resolution[:resolution]]
    #   end
    # end
  end

  # RESOLUTIONS.each do |resolution|
  #   define_method("bigger_than_#{resolution[:resolution]}?") do |argument|
  #     video(argument.path).resolution > resolution[:resolution] ? true : false
  #   end
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(mp4 mov avi mkv 3gp mpg mpeg)
    %w(jpg jpeg gif png)
    /image\//
  end
  def content_type_blacklist
  ['application/text', 'application/json']
  end
end
