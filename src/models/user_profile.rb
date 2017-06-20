require 'sequel'
require 'Nokogiri'
require_relative '../data/xml_helper.rb'

class UserProfile < Sequel::Model

  def self.create_from_xml(xml)
    child = xml

    data = {
      "image_url" => PluckXml.get_text(child, 'ImageUrl'),
      "user_tier" => PluckXml.get_text(child, 'UserTier'),
      "forum_membership_state" => PluckXml.get_text(child, '_forumMembershipState'),
      "skip_lists" => PluckXml.get_text(child, 'SkipLists'),
      "about_me" => PluckXml.get_text(child, 'AboutMe'),
      "sex" => PluckXml.get_text(child, 'sex'),
      "date_of_birth" => PluckXml.get_text(child, 'DateOfBirth'),
      "location" => PluckXml.get_text(child, 'Location'),
      "personal_privacy_mode" => PluckXml.get_text(child, 'PersonaPrivacyMode'),
      "custom_answers" => PluckXml.get_text(child, 'CustomAnswers'),
      "is_blocked" => PluckXml.get_text(child, 'IsBlocked'),
      "is_email_notifications_enabled" => PluckXml.get_text(child, 'IsEmailNotificationsEnabled'),
      "disable_all_email_notifications" => PluckXml.get_text(child, 'DisableAllEmailNotifications'),
      "content_download_user_display_name" => PluckXml.get_text(child, 'ContentDownloadUserDisplayName'),

      "key" => child.xpath('Key').xpath('UserKey').xpath('Key').text,
      "unique_id" => child.xpath('Key').xpath('UserKey').xpath('UniqueId').text,
      "is_anonymous" => child.xpath('Key').xpath('UserKey').xpath('IsAnonymous').text,

      "content_blocking_state" => PluckXml.get_text(child, 'ContentBlockingState'),
      "immune_to_abuse_reports_state" => PluckXml.get_text(child, 'ImmuneToAbuseReports'),
      "last_updated" => PluckXml.get_text(child, 'LastUpdated'),
      "created_on" => PluckXml.get_text(child, 'CreatedOn'),
      "email" => PluckXml.get_text(child, 'AuthorEmailAddress')
    }

    begin
      user_profile = UserProfile.create do |up|
        data.each do |key, value|
          up.send("#{key}=", value)
        end
      end
    rescue
      print "duplicate profile #{data['email']}\n"
    end


    return user_profile
  end
end
