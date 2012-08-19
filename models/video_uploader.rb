# coding: utf-8

class VideoUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.id}"
  end

  def extension_white_list
    %w(webm mp4 avi mpeg mpg mov mkv wmv 3gp flv)
  end
end
