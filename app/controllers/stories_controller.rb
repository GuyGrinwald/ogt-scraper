require 'uri'

class StoriesController < ApplicationController
	def create
		# This might needs refactoring - not sure if ogt is affectewd by different url params - if not then remove params from url and only check for that
		url_param = create_story_params
		uri = URI(url_param[:url])
		canonical_url = uri.host.nil? ? uri.path : uri.host
		Rails.logger.debug "Recieved URL: #{canonical_url}"

		@story = Story.scoped.where(url: canonical_url).first
		if (@story.nil?)
			@story = Story.new(url: canonical_url, status: :pending, scrape_data: {})
			
			if !@story.save
				Rails.logger.error "Error saving customer payment to the DB"
			end
		end

		Rails.logger.debug "Story: #{@story.to_json}"

		respond_to do |format|
			format.json 
			render :partial => "stories/create.json"
		end
	end

	def show
	end

	private

	def create_story_params
  		params.permit(:url)
	end

	def show_story_params
  		params.permit(:id)
	end
end
