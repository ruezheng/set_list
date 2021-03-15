class ArtistsController < ApplicationController
  def index
    if params[:sort]
      @artists = Artist.order(name: params[:sort])
    else
      @artists = Artist.all
    end
  end

  def new
    @artist = Artist.new
  end

  def create
    Artist.create(artist_params)
    redirect_to '/artists'
  end

  def destroy
    Artist.destroy(params[:id])
    redirect_to '/artists'
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    artist = Artist.find(params[:id])
    artist.update(name: params[:name])
    redirect_to '/artists'
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
