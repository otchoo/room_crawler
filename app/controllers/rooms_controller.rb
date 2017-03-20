class RoomsController < ApplicationController
  def index
    @search = Room.ransack params[:q]
    selector = RansackMongo::Query.parse(params[:q])
    selector["provider_site_cd"] = selector["provider_site_cd"].to_i if selector.present?
    @rooms = Room.where(selector).order(code: :asc).page(params[:page]).per Settings.rooms.page_size
  end

  def show
    @room = Room.find params[:id]
  end
end
