class Story
  include Mongoid::Document
  field :url, type: String
  field :scrape_data, type: Hash
  field :status, type: String
end
