require File.expand_path('../../init', __FILE__)
require File.expand_path('../video', __FILE__)

class VideoConverter
  include Sidekiq::Worker
  sidekiq_options retry: false

  # ffmpeg options
  OPTIONS = { resolution: "640x480" }
  TRANSCODER_OPTIONS = { preserve_aspect_ratio: :width }

  def perform(id)
    sleep 1 # sidekiq is too fast, so we need to wait :)

    # fetch video
    video = Video.find id rescue nil
    return unless video

    # trying transcode
    begin
      # load file
      movie = FFMPEG::Movie.new(video.file.path)

      # determine new file path
      new_file_path = File.expand_path("../../public/uploads/#{video.id}/movie.webm", __FILE__)

      # perform transcoding
      movie.transcode new_file_path, OPTIONS, TRANSCODER_OPTIONS

      # mark video as performed
      video.update_attribute :performed, true
    rescue
      # mark failed if we got an exception
      video.update_attribute :failed, true
    end
  end
end
