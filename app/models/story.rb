class Story
  include Mongoid::Document
  field :url, type: String
  field :status, type: String
  field :ogt_type, type: String
  field :title, type: String
  field :images, type: Array, default: []
  field :updated_time, type: DateTime, default: Time.now
end
