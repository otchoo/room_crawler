class CrawlRoomsFromMuabannhadatService

  BASE_URL = "http://www.muabannhadat.vn/nha-dat-3490"
  ROOT_URL = "http://www.muabannhadat.vn"
  DEFAULT_PAGES_NUMBER = 10

  attr_reader :pages_number

  def initialize pages_number = DEFAULT_PAGES_NUMBER
    @pages_number = pages_number
  end

  def perform
    crawled_rooms = 0
    logger = Logger.new "#{Rails.root}/log/crawling_#{Rails.env}.log"
    logger.info "Crawling rooms on #{pages_number} pages from '#{ROOT_URL}'"
    agent = Mechanize.new
    (0...pages_number).each do |page_number|
      url = BASE_URL + "?p=#{page_number}"
      begin
        logger.info "---Crawling page #{url} for get list rooms"
        page = agent.get url
        logger.info "---Crawled page #{url}"
        page.links_with(class: "title-filter-link").each do |link|
          room_url = ROOT_URL + link.uri.to_s
          begin
            logger.info "------Crawling room detail from #{room_url}"
            if crawl_room(room_url)
              logger.info "------Crawled room detail from #{room_url}"
              crawled_rooms += 1
            else
              logger.error "------Fail to crawl room detail from #{room_url}"
            end
          rescue => e
            logger.error e.message
            e.backtrace.each {|line| logger.error line}
          end
        end
      rescue => e
        logger.error e.message
        e.backtrace.each {|line| logger.error line}
      end
    end
    logger.info "Crawled #{crawled_rooms} room(s) on #{pages_number} pages from '#{ROOT_URL}'\n\n"
    logger.close
  end

  private
  def crawl_room room_url
    crawled_params = Crawlers::RoomFromMuabannhadat.new(room_url).crawled_params
    room = Room.find_or_initialize_by code: crawled_params[:code], provider_site_cd: crawled_params[:provider_site_cd]
    room.assign_attributes crawled_params
    room.save
  end
end
