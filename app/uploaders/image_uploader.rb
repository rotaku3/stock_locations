class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  
  process resize_to_fit: [200,300]

  if Rails.env.development? # 開発環境の場合
      storage :file
  else # 本番環境の場合
      storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  #デフォルト画像の設定
  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    'default.png'
  end
  
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  
  def size_range
    0..5.megabytes
  end
  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
