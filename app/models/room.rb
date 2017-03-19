require 'simple_enum/mongoid'

class Room
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid

  field :room_number, type: String
  field :area, type: String
  field :address, type: String
  field :direction, type: String
  field :number_of_bedrooms, type: String
  field :number_of_bathrooms, type: String
  field :project, type: String
  field :floor, type: String
  field :utilities, type: String
  field :environment, type: String
  field :description, type: String
  field :price_per_metre_square, type: String
  field :price, type: String
  field :images, type: Array
  field :city, type: String
  field :district, type: String
  field :code, type: String
  field :provider_url, type: String

  as_enum :provider_site, ["muabannhadat.vn", "nhadat24h.net"]

  validates :code, presence: true
end
