require 'sequel'
require 'Nokogiri'
require_relative '../data/xml_helper.rb'
require 'sqlite3'

class BlogSetting < Sequel::Model
  def self.create_from_xml(xml)
    child = xml

    data = {
      "blog_url" => PluckXml.get_text(child, 'BlogUrl'),
      "title" => PluckXml.get_text(child, 'Title'),
      "tagline" => PluckXml.get_text(child, 'Tagline'),
      "key" => child.xpath('Key').xpath('Key').text,
      "owner_key" => child.xpath('Owner').xpath('Key').text,
      "owner_unique_id" => child.xpath('Owner').xpath('UniqueId').text
    }

    members = ""
    child.xpath("Members").xpath("String").each do |member|
      members = members + member.text + ","
    end
    # remove last comma
    members = members[0..-2]
    data["members"] = members

    begin
      BlogSetting.create do |blog_setting|
        data.each do |key, value|
          blog_setting.send("#{key}=", value)
        end
      end
    rescue Sequel::DatabaseError => e
      print "Duplicate Blog: #{data['title']}\n"
    end
  end
end
