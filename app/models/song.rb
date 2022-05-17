class Song < ApplicationRecord
  belongs_to :artist

  def song_count
    songs.count
  end
end
