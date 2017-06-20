require 'sequel'
require 'Nokogiri'
require_relative '../data/xml_helper.rb'

class Category < Sequel::Model
  def self.create_from_xml(xml)
    data = {
      "title" => PluckXml.get_text(xml, 'Title'),
      "key" => xml.xpath('Key').xpath('Key').text
    }

    category = Category.create do |category|
      category.title = PluckXml.get_text(xml, 'Title')
      category.key = xml.xpath('Key').xpath('Key').text
    end

    print category.title + ": " + category.key
  end
end
