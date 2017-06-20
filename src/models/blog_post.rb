require 'sequel'
require 'Nokogiri'
require_relative '../data/xml_helper.rb'

class BlogPost < Sequel::Model

  def self.create_from_xml(xml)
    child = xml
    blogkey_userkey = child.xpath('Key').xpath('BlogKey').xpath('UserKey')

    data = {
      "needs_to_update_full_text" => PluckXml.get_text(child, 'NeedsToUpdateFullText'),
      "skip_lists" => PluckXml.get_text(child, 'SkipLists'),
      "updating_comments" => PluckXml.get_text(child, 'UpdatingComments'),
      "unencoded_title" => PluckXml.get_text(child, 'UnencodedTitle'),
      "body" => PluckXml.get_text(child, 'Body'),
      "body_abstract" => PluckXml.get_text(child, 'BodyAbstract'),
      "tags" => PluckXml.get_text(child, 'Tags'),
      "tags_previous" => PluckXml.get_text(child, 'TagsPrevious'),
      "time_stamp" => PluckXml.get_text(child, 'TimeStamp'),
      "is_published" => PluckXml.get_text(child, 'IsPublished'),
      "parent_user_unique_id" => child.xpath('ParentKey').xpath('UserKey').xpath('UniqueId').text,
      "parent_user_key" => child.xpath('ParentKey').xpath('UserKey').xpath('Key').text,
      "parent_blog_key" => child.xpath('ParentKey').xpath('Key').text,
      "last_edited_unique_id" => child.xpath('LastEditedBy').xpath('UniqueId').text,
      "last_edited_key" => child.xpath('LastEditedBy').xpath('Key').text,
      "last_edited_time_stamp" => PluckXml.get_text(child, 'LastEditTimeStamp'),
      "title" => PluckXml.get_text(child, 'Title'),
      "last_comment_date" => PluckXml.get_text(child, 'LastCommentDate'),
      "key_blogkey_userkey_unique_id" => blogkey_userkey.xpath('UniqueId').text,
      "key_blogkey_userkey_key" => blogkey_userkey.xpath('Key').text,
      "key_blogkey_key" => child.xpath('Key').xpath('BlogKey').xpath('Key').text,
      "key" => child.xpath('Key').xpath('Key').text,
      "content_blocking_state" => PluckXml.get_text(child, 'ContentBlockingState'),
      "immune_to_abuse_reports_state" => PluckXml.get_text(child, 'ImmuneToAbuseReportsState'),
      "owner_unique_id" => child.xpath('Owner').xpath('UniqueId').text,
      "owner_key" => child.xpath('Owner').xpath('Key').text,
      "last_updated" => PluckXml.get_text(child, 'LastUpdated'),
      "created_on" => PluckXml.get_text(child, 'CreatedOn'),
    }

=begin
Uncomment this if the download seems to be missing some values. As of 6/15/17 only body_abstract, tags, and tags_previous
were missing

    missing = false
    data.each do |key, value|
      if value == nil || value.length == 0 && key != "body_abstract" && key != "tags" && key != "tags_previous"
        missing = true
        print "missing #{key}: #{value}\n"
      end
    end

    if missing
      print child
      print "\n"
    end
=end

    blog_post = BlogPost.create do |bp|
      data.each do |key, value|
        bp.send("#{key}=", value)
      end
    end

    return blog_post
  end
end
