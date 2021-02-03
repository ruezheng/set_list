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
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to '/artists'
    else
      flash.now[:error] = 'Artist not created: Missing required information'
      render :new
    end
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
    artist.update(artist_params)
    redirect_to '/artists'
  end

  private
  def artist_params
    params.require(:artist).permit(:name)
  end
end
