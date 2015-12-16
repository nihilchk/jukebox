require 'net/http'
require 'json'

class SearchQueryController < ApplicationController
  def search_youtube_videos
    results = get_search_query_response(CGI.escape(params[:q]))
    render :json => results
  end

  private 
  def get_search_query_response query
    uri = URI.parse("https://www.youtube.com/results?search_query=#{query}&spf=navigate")
    response = JSON.parse(Net::HTTP.get(uri))
    body_part = response.last["body"]
    search_results = body_part["content"].scan(/\<h3.*?\<a href.*?\<\/h3\>/)
    search_results.collect {|a| { name: a.match(/title=".*?"/)[0].gsub("title=","").gsub("\"",""), url: a.match(/href="\/.*?"/)[0].gsub("href=","").gsub("\"","") }}
  end
end
