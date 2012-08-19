require 'carrierwave/orm/activerecord'
require File.expand_path('../video_uploader', __FILE__)
require File.expand_path('../video_converter', __FILE__)

class Video < ActiveRecord::Base
  validates :name, :file, presence: true

  mount_uploader :file, VideoUploader

  after_create :perform_transcoding
  after_destroy :destroy_upload_dir

  private

  def perform_transcoding
    # perform video transcoding asynchronously with sidekiq
    VideoConverter.perform_async id
  end

  # when model destroyed, we no longer need to store any converted files, so let's remove the dir!
  def destroy_upload_dir
    dir = File.expand_path "../", file.path
    FileUtils.rm_rf dir
  end
end
