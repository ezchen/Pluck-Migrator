require 'sequel'
require 'nokogiri'
require_relative '../data/xml_helper.rb'

class Post < Sequel::Model
  def self.create_from_xml(xml)
    data = {
      "title" => PluckXml.get_text(xml, 'Title'),
      "is_question" => PluckXml.get_text(xml, 'IsQuestion'),
      "is_discussion" => PluckXml.get_text(xml, 'IsDiscussion'),
      "notify_owner_on_reply" => PluckXml.get_text(xml, 'NotifyOwnerOnReply'),
      "body" => PluckXml.get_text(xml, 'Body'),

      "last_edited_key" => xml.xpath('LastEditedBy').xpath('Key').text,
      "last_edited_unique_id" => xml.xpath('LastEditedBy').xpath('UniqueId').text,
      "last_edited_time_stamp" => xml.xpath('LastEditTimeStamp').text,
      "content_created_on" => xml.xpath('ContentCreatedOn').text,

      "parent_key" => xml.xpath('ParentKey').xpath('Key').text,

      "forum_key" => xml.xpath('ParentKey').xpath('ForumKey').xpath('Key').text,
      "category_key" => xml.xpath('ParentKey').xpath('ForumKey').xpath('CategoryKey').xpath('Key').text,

      "key" => xml.xpath('Key').xpath('Key').text,

      "owner_key" => xml.xpath('Owner').xpath('Key').text,
      "owner_unique_id" => xml.xpath('Owner').xpath('UniqueId').text,

      "last_updated" => xml.xpath('LastUpdated').text,
      "created_on" => xml.xpath("CreatedOn").text,

      "content_blocking_state" => PluckXml.get_text(xml, 'ContentBlockingState')
    }

    post = Post.create do |post|
      data.each do |key, value|
        post.send("#{key}=", value)
      end
    end
  end
end
