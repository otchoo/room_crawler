class Crawlers::RoomFromNhadat24h
  CRAWLED_ATTRIBUTES = %i"area direction description price images city district code"
  SITE_NAME = "nhadat24h.net"

  attr_reader :url

  def initialize url
    @url = url
  end

  def crawled_params
    CRAWLED_ATTRIBUTES.inject({}) do |params, attribute|
      params.merge attribute => send("crawled_#{attribute}")
    end.merge provider_url: crawled_page.uri.to_s, provider_site_cd: Room::provider_sites[SITE_NAME]
  end

  private
  def crawled_page
    @crawled_page ||= Mechanize.new.get url
  end

  def crawled_area
    @crawled_area ||= crawled_page.at("#ContentPlaceHolder2_lbDienTich").try :text
  end

  def crawled_direction
    @crawled_direction ||= crawled_page.at("#ContentPlaceHolder2_lbHuong").try :text
  end

  def crawled_description
    @crawled_description ||= crawled_page.at("#ContentPlaceHolder2_divContent").try :inner_html
  end

  def crawled_price
    @crawled_price ||= crawled_page.at("#ContentPlaceHolder2_lbGiaTien").try :text
  end

  def crawled_images
    @crawled_images ||= crawled_page.search("#ContentPlaceHolder2_viewImage1_divLi li a")
      .map{|element| element.attributes["href"].try :value}.compact
  end

  def crawled_city
    @crawled_city ||= crawled_page.at("#ContentPlaceHolder2_lbTinhThanh a").try(:text) ||
      crawled_page.at("#ContentPlaceHolder2_lbTinhThanh").try(:text)
  end

  def crawled_district
    @crawled_district ||= crawled_page.at("#ContentPlaceHolder2_lbDiaChi a").try(:text) ||
      crawled_page.at("#ContentPlaceHolder2_lbDiaChi").try(:text)
  end

  def crawled_code
    @crawled_code ||= url[/\d+\z/]
  end
end
