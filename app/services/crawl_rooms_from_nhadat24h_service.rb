class CrawlRoomsFromNhadat24hService

  BASE_URL = "http://nhadat24h.net/ban-bat-dong-san-viet-nam-nha-dat-viet-nam-s686599"
  ROOT_URL = "http://nhadat24h.net"
  DEFAULT_PAGES_NUMBER = 10

  attr_reader :pages_number

  def initialize pages_number = DEFAULT_PAGES_NUMBER
    @pages_number = pages_number
  end

  def perform
    agent = Mechanize.new
    (1..pages_number).each do |page_number|
      url = BASE_URL + "/#{page_number}"
      page = agent.get url
      page.search("#ContentPlaceHolder2_KetQuaTimKiem1_Pn1 [class^=a-title]").each do |link|
        crawl_room ROOT_URL + link.attributes["href"].try(:value)
      end
    end
  end

  private
  def crawl_room room_url
    crawled_params = Crawlers::RoomFromNhadat24h.new(room_url).crawled_params
    room = Room.find_or_initialize_by code: crawled_params[:code], provider_site_cd: crawled_params[:provider_site_cd]
    room.assign_attributes crawled_params
    room.save
  end
end
