require 'sequel'
require 'Nokogiri'
require_relative '../data/xml_helper.rb'

class Forum < Sequel::Model
  def self.create_from_xml(xml)
    forum = Forum.create do |forum|
      forum.title = xml.xpath('Title').text
      forum.parent_key = xml.xpath('ParentKey').xpath('Key').text
      forum.key = xml.xpath('Key').xpath('Key').text
      forum.key_without_category = xml.xpath('Key').xpath('KeyWithoutCategoryKey').text
    end

    print forum.title + ": " + forum.key + "belongs to #{forum.parent_key}\n"
  end
end
