require 'Nokogiri'
require 'http'
require_relative 'xml_helper'
require 'thread'
require_relative '../config/config.rb'

# handles logic for retrieving the xml data from Pluck
class Api

  # Helper method that generates the Pluck Route
  #
  # base_url: http://example.com
  # route: this/example/1000/0
  # key: Ex3AmpLe-02912-BCDa
  def self.create_route(base_url, route, key)
    return "#{base_url}/#{route}?accessKey=#{key}"
  end

  # calls an http request for one page of the Pluck content
  # returns an xml object
  def self.get_content(base_url, route, key)
    url = Api.create_route(base_url, route, key)
    resp = HTTP.get(url).to_s
    xml_resp = Nokogiri::XML(resp)
    return xml_resp
  end

  # Calling a content download on pluck only allows 1000 items at a time.
  # This method retrieves all of the items from all pages and pushes into the
  # data structure provided
  def self.get_all_content_for_all_pages(items, base_url, content_type, key, date='')
    more_pages = true
    items_per_page = 1000
    page = 0

    while more_pages do
      if date != ''
        current_route = "ver1.0/ContentDownload/#{content_type}/#{date}/#{items_per_page}/#{page}"
      else
        current_route = "ver1.0/ContentDownload/#{content_type}/#{items_per_page}/#{page}"
      end

      xml_resp = self.get_content(base_url, current_route, key)
      more_pages = PluckXml.more_pages(xml_resp)
      page = page + 1

      PluckXml.get_content_body(xml_resp).xpath("//#{content_type}").each do

        |content_item|

        items << content_item
      end

    end
  end

  # Retrieves all items associated with the date provided
  #
  # Each item is in the XML format specified in the Pluck Content Download
  # document
  def self.get_all_content_items_for_day(items, base_url, content_type, date, key)
    self.get_all_content_for_all_pages(items, base_url, content_type, key, date)
  end

  # Retrieves all items. Only call this method on resources that Pluck
  # has defined does not need a date
  #
  # Each item is in the XML format specified in the Pluck Content Download
  # Document
  def self.get_all_content_items_no_dates(items, base_url, content_type, key)
    self.get_all_content_for_all_pages(items, base_url, content_type, key)
  end

  # Gets all of the ContentBody items from the start_date to present
  # Returns a Queue of items
  #
  # Each item is in the XML format specified in the Pluck Content Download
  # Document
  def self.get_all_content_items(base_url, content_type, key, start_year, start_month, start_day)

    items = Queue.new

    threads = []
    thread_count = 0

    # Iterate through all days starting at the date specified up to present
    # Download content items for each day and push into an array
    Date.new(start_year, start_month, start_day).upto(Date.today) do |date|
      year = format('%02d', date.year)
      month = format('%02d', date.month)
      day = format('%02d', date.day)
      date_string = "#{year}-#{month}-#{day}"

      # Use threading to speed up http requests
      thr = Thread.new do
        self.get_all_content_items_for_day(items, base_url, content_type, date_string, key)
        print "Done with #{date_string}. Number of items: #{items.length}\n"
      end

      threads.push(thr)

      # Join every 100 threads
      thread_count = thread_count + 1
      if thread_count >= 100
        threads.each do |thread|
          thread.join
        end
        thread_count = 0
      end
    end

    threads.each do |thread|
      thread.join
    end

    return items
  end
end
