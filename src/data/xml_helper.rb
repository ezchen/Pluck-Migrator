# Handles logic for parsing Pluck Xml documents
class PluckXml

  FORDAY = 'ForDay'
  CONTENTTYPE = 'ContentType'
  CURRENTPAGE = 'CurrentPage'
  PAGE = 'Page'
  ITEMSPERPAGE = 'ItemsPerPage'
  TOTALITEMSFORDAY = 'TotalItemsForDay'
  ITEMSINTHISBATCH = 'ItemsInThisBatch'
  NEXTPAGEURL = 'NextPageUrl'

  # Returns the ContentHeader element in the xml
  #
  # If it does not exist or it is in the incorrect format, will return an empty
  # array. However, this should never happen
  def self.get_content_header(xml)
    return xml.child.xpath('ContentHeader')
  end

  # Returns the value for one of the items defined in HEADERCONTENTITEMS
  #
  # If it does not exist, should return an empty string
  def self.get_content_header_item(xml, item)
    content_header = self.get_content_header(xml)
    return content_header.xpath(item).text
  end

  # Checks to see if the XML response has a NextPageUrl
  # returns true if there is a NextPage
  # returns false otherwise
  def self.more_pages(xml)
    next_page_url = xml.child.xpath('ContentHeader').xpath('NextPageUrl').text
    return next_page_url != ''
  end

  # Returns the ContentBody element in the xml
  #
  # If it does not exist or it is in the incorrect format, will return an empty
  # array. However, this should never happen
  def self.get_content_body(xml)
    return xml.child.xpath('ContentBody')
  end


end
