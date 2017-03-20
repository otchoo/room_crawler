class CrawlRoomsFromMuabannhadatService

  BASE_URL = "http://www.muabannhadat.vn/nha-dat-3490"
  ROOT_URL = "http://www.muabannhadat.vn"
  DEFAULT_PAGES_NUMBER = 10

  attr_reader :pages_number

  def initialize pages_number = DEFAULT_PAGES_NUMBER
    @pages_number = pages_number
  end

  def perform
    agent = Mechanize.new
    (0...pages_number).each do |page_number|
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
