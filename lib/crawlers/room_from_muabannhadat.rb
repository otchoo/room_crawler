class Crawlers::RoomFromMuabannhadat
  CRAWLED_ATTRIBUTES = %i"area address direction number_of_bedrooms number_of_bathrooms project
    floor utilities environment description price images city district code"
  SITE_NAME = "muabannhadat.vn"

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
    @crawled_area ||= crawled_page.at("#MainContent_ctlDetailBox_lblSurface").try :text
  end

  def crawled_address
    @crawled_address ||= [crawled_street, crawled_ward].select{|element| element.present?}.join ", "
  end

  def crawled_street
    @crawled_street ||= crawled_page.at("#MainContent_ctlDetailBox_lblStreet").try :text
  end

  def crawled_ward
    @crawled_ward ||= crawled_page.at("#MainContent_ctlDetailBox_lblWard a").try(:text) ||
      crawled_page.at("#MainContent_ctlDetailBox_lblWard").try(:text)
  end

  def crawled_direction
    @crawled_direction ||= crawled_page.at("#MainContent_ctlDetailBox_lblFengShuiDirection").try :text
  end

  def crawled_number_of_bedrooms
    @crawled_number_of_bedrooms ||= crawled_page.at("#MainContent_ctlDetailBox_lblBedRoom").try :text
  end

  def crawled_number_of_bathrooms
    @crawled_number_of_bathrooms ||= crawled_page.at("#MainContent_ctlDetailBox_lblBathRoom").try :text
  end

  def crawled_project
    @crawled_project ||= crawled_page.at("#MainContent_ctlDetailBox_lblProject a").try :text
  end

  def crawled_floor
    @crawled_floor ||= crawled_page.at("#MainContent_ctlDetailBox_lblFloor").try :text
  end

  def crawled_utilities
    @crawled_utilities ||= if original_utilities = crawled_page.at("#MainContent_ctlDetailBox_lblUtility").try(:inner_html)
      original_utilities.split("<br>").map{|utility| utility.strip}.join ", "
    end
  end

  def crawled_environment
    @crawled_environment ||= if original_env = crawled_page.at("#MainContent_ctlDetailBox_lblEnvironment").try(:inner_html)
      original_env.split("<br>").map{|env| env.strip}.join ", "
    end
  end

  def crawled_description
    @crawled_description ||= crawled_page.at("#Description").try :inner_html
  end

  def crawled_price
    @crawled_price ||= crawled_page.at("#MainContent_ctlDetailBox_lblPrice").try :text
  end

  def crawled_images
    @crawled_images ||= crawled_page.search(".flexslider li a")
      .map{|element| element.attributes["href"].try :value}.compact
  end

  def crawled_city
    @crawled_city ||= crawled_page.at("#MainContent_ctlDetailBox_lblCity a").try(:text) ||
      crawled_page.at("#MainContent_ctlDetailBox_lblCity").try(:text)
  end

  def crawled_district
    @crawled_district ||= crawled_page.at("#MainContent_ctlDetailBox_lblDistrict a").try(:text) ||
      crawled_page.at("#MainContent_ctlDetailBox_lblDistrict").try(:text)
  end

  def crawled_code
    @crawled_code ||= crawled_page.at("#MainContent_ctlDetailBox_lblId").try :text
  end
end
