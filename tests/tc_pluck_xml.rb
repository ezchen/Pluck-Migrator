require_relative '../src/data/xml_helper'
require 'Nokogiri'
require 'test/unit'

$correct_xml = Nokogiri::XML('''
<ContentEnvelope>
  <ContentHeader>
    <ForDay>2017-01-11</ForDay>
    <ContentType>Post</ContentType>
    <CurrentPage>0</CurrentPage>
    <ItemsPerPage>10</ItemsPerPage>
    <TotalItemsForDay>11</TotalItemsForDay>
    <ItemsInThisBatch>10</ItemsInThisBatch>
    <NextPageUrl>http://pluck.frommers.com/ver1.0/ContentDownload/Post/2017-01-11/10/1?accessKey=example_key</NextPageUrl>
  </ContentHeader>
</ContentEnvelope>
''')

$incorrect_xml = Nokogiri::XML('''
    <NextPageUrl>
      http://pluck.frommers.com/ver1.0/ContentDownload/Post/2017-01-11/10/1?accessKey=example_key
    </NextPageUrl>
 ''')

class TestPluckXmlHelper < Test::Unit::TestCase

  def test_get_header_content
    assert_not_equal(0, PluckXml.get_content_header($correct_xml).length)
    assert_equal(0, PluckXml.get_content_header($incorrect_xml).length)
  end

  def test_get_header_content_items
    for_day = PluckXml.get_content_header_item($correct_xml, PluckXml::FORDAY)
    item_type = PluckXml.get_content_header_item($correct_xml, PluckXml::CONTENTTYPE)
    current_page = PluckXml.get_content_header_item($correct_xml, PluckXml::CURRENTPAGE)
    page = PluckXml.get_content_header_item($correct_xml, PluckXml::PAGE)
    items_per_page = PluckXml.get_content_header_item($correct_xml, PluckXml::ITEMSPERPAGE)
    total_items = PluckXml.get_content_header_item($correct_xml, PluckXml::TOTALITEMSFORDAY)
    items_this_page = PluckXml.get_content_header_item($correct_xml, PluckXml::ITEMSINTHISBATCH)
    next_page_url = PluckXml.get_content_header_item($correct_xml, PluckXml::NEXTPAGEURL)

    assert_equal(for_day, '2017-01-11')
    assert_equal(item_type, 'Post')
    assert_equal(current_page, '0')
    assert_equal(items_per_page, '10')
    assert_equal(total_items, '11')
    assert_equal(items_this_page, '10')
    assert_equal(next_page_url, 'http://pluck.frommers.com/ver1.0/ContentDownload/Post/2017-01-11/10/1?accessKey=example_key')

    # When the content does not exist, should return an empty string
    empty_check = PluckXml.get_content_header_item($incorrect_xml, PluckXml::FORDAY)
    assert_equal('', empty_check)
  end
end
