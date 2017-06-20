require 'sequel'
require 'Nokogiri'
require_relative '../data/xml_helper.rb'

class Discussion < Sequel::Model

  def self.create_from_xml(xml)
    child = xml

    data = {
      "owner_unique_id" => child.xpath('Owner').xpath('UniqueId').text,
      "owner_key" => child.xpath('Owner').xpath('Key').text,
      "root_post_key" => child.xpath('RootPostKey').xpath('Key').text,
      "key" => child.xpath('RootPostKey').xpath('DiscussionKey').xpath('Key').text,
      "category_key" => child.xpath('RootPostKey').xpath('DiscussionKey').xpath('CategoryKey').xpath('Key').text,
      "body" => child.xpath('Body').text,
      "title" => child.xpath('Title').text,
      "short_title" => child.xpath('ShortTitle').text,

      "is_sticky" => child.xpath('IsSticky').text,
      "is_closed" => child.xpath('IsClosed').text,
      "is_poll" => child.xpath('IsPoll').text,

      "latest_time_stamp" => child.xpath('LatestTimeStamp').text,
      "content_created_on" => child.xpath('ContentCreatedOn').text,
      "parent_key" => child.xpath('ParentKey').xpath('Key').text,

      "last_updated" => child.xpath('LastUpdated').text,
      "created_on" => child.xpath('CreatedOn').text
    }

    discussion = Discussion.create do |disc|
      data.each do |key, value|
        disc.send("#{key}=", value)
      end
    end

  end
end
