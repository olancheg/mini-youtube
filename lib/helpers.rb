# coding: utf-8

module Helpers
  def flashes
    flash.send(:values)
  end

  def video_player(video)
    <<-HTML
    <video src="/uploads/#{video.id}/movie.webm" controls>
      This is fallback content to display if the browser
      does not support the video element.
    </video>
    HTML
  end

  def link_to_video_delete(id)
    <<-HTML
    <form method="post" action="/video/#{id}" class="delete">
      <input type="hidden" name="_method" value="delete" />
      <a href='#' onclick='if (confirm("Вы уверены?")){ $("form.delete").submit(); return false; }'>Удалить</a>
    </form>
    HTML
  end
end
