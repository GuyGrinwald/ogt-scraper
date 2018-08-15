require 'opengraph_parser'

class FetchOgtJob < ApplicationJob
  queue_as :urgent

  def perform(*args)
  	url = args[0]
  	
  	Rails.logger.info "Fetching ogt for url: #{url}"
    og = OpenGraph.new "http://#{url}"

	@story = Story.scoped.where(url: url).first

	if og
		if @story
			@story.ogt_type = og.type
			@story.title = og.title
			@story.images = og.metadata[:image]
			@story.updated_time = Time.now
			@story.status = 'done'
			Rails.logger.info "Fetching completed for url: #{url}"
		end
	else
		Rails.logger.error "Could not fetch ogt for url: #{url}"
		@story.status = 'error'
	end

	@story.save
  end
end
