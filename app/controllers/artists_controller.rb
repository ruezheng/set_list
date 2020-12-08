class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def new
  end

  def create
    Artist.create(artist_params)
    redirect_to '/artists'
  end

  private
  def artist_params
    params.permit(:name)
  end
end
