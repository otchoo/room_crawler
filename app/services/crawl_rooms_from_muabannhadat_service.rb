class CrawlRoomsFromMuabannhadatService

  BASE_URL = "http://www.muabannhadat.vn/nha-dat-3490"
  ROOM_SELECTOR_REGEX = /\AMainContent_ctlList_ctlResults_repList_ctl00_\d+_divListingInformationTitle_\d+/
  ROOT_URL = "http://www.muabannhadat.vn"

  attr_reader :pages_count

  def initialize pages_count = 10
    @pages_count = pages_count
  end

  def perform
    agent = Mechanize.new
    (0...pages_count).each do |page_number|
      url = BASE_URL + "?p=#{page_number}"
      page = agent.get url
      page.links_with(class: "title-filter-link").each do|link|
        crawl_room ROOT_URL + link.uri.to_s
      end
    end
  end

  private
  def crawl_room room_url
    crawled_params = Crawlers::RoomFromMuabannhadat.new(room_url).crawled_params
    room = Room.find_or_initialize_by code: crawled_params[:code], provider_site_cd: crawled_params[:provider_site_cd]
    room.assign_attributes crawled_params
    room.save
  end
end
