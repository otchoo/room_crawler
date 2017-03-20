class RoomsController < ApplicationController
  def index
    @rooms = Room.all.page(params[:page]).per Settings.rooms.page_size
  end

  def show
    @room = Room.find params[:id]
  end
end
