require 'sequel'

# Creates the Schema for the sqlite database
# Stores it into the file ./frommers.sqlite3

DB = Sequel.connect('sqlite://frommers.sqlite3')
DB.run('PRAGMA foreign_key = ON')

begin
  DB.create_table :user_profiles do
    primary_key [:unique_id]
    String :image_url
    String :user_tier
    String :forum_membership_state
    String :skip_lists
    String :about_me
    String :sex
    String :date_of_birth
    String :location
    String :personal_privacy_mode
    String :custom_answers
    Bool   :is_blocked
    Bool   :is_email_notifications_enabled
    Bool   :disable_all_email_notifications
    String :content_download_user_display_name

    String :key
    String :unique_id
    String :is_anonymous

    String :content_blocking_state
    Bool   :immune_to_abuse_reports_state
    Date :last_updated
    Date :created_on
    String :email


    unique([:email, :key, :unique_id])
  end

  DB.create_table :blog_posts do
    primary_key :id
    Bool :needs_to_update_full_text
    Bool :skip_lists
    Bool :updating_comments

    String :unencoded_title
    String :body
    String :body_abstract

    # an array of Strings separated by ', '
    # ex: Italy, Rome, Florence
    String :tags
    String :tags_previous

    String :time_stamp
    String :is_published

    # parent_ are keys under the xml node <ParentKey>
    # parent_user are keys under <ParentKey><UserKey/>...
    # The parent_user keys seem to be useless because they appear to be hashed
    # for some reason... but keeping them here in case they are used later.
    String :parent_user_unique_id
    String :parent_user_key
    # Should be the key that this Blog Post belongs to
    String :parent_blog_key

    # last_edited_ are keys under the xml NOde <LastEditedBy>
    # unique_id for the user who last edited this post
    String :last_edited_unique_id
    # key for the user who last edited this post
    String :last_edited_key
    # time stamp when this post was last edited
    String :last_edited_time_stamp

    String :title
    String :last_comment_date

    # xml Node <Key><BlogKey><UserKey>
    # Duplicates of parent_user_unique_id and parent_user_key. Keeping them
    # just in case this turns out to be wrong...
    String :key_blogkey_userkey_unique_id
    String :key_blogkey_userkey_key
    # xml Node <Key>BlogKey><UserKey>
    # Duplicate of parent_blog_key
    String :key_blogkey_key

    # under xml Node <Key>
    String :key

    String :content_blocking_state
    String :immune_to_abuse_reports_state

    String :owner_unique_id
    String :owner_key

    Date :last_updated
    Date :created_on
  end

  DB.create_table :blog_settings do
    primary_key [:key]

    # Url of the blog on the Pluck Site
    String :blog_url

    String :title

    # Short description
    String :tagline

    # String of usernames with each member separated by a comma
    String :members

    # Should be the key of this blog. BlogPost refers to this through paren_blog_key
    String :key

    # Hashed or some unique ID generated, this is not the owner's username sadly...
    String :owner_key
    String :owner_unique_id

    unique([:blog_url, :key, :title])
  end

  DB.create_table :categories do
    primary_key [:key]
    String :title

    String :key
  end

  DB.create_table :forums do
    primary_key [:key]

    String :title

    # refers to categories
    String :parent_key

    String :key

    String :key_without_category
  end

  DB.create_table :discussions do
    primary_key :id
    String :owner_key
    String :owner_unique_id
    String :root_post_key
    String :key

    String :category_key
    String :body
    String :title
    String :short_title

    Bool :is_sticky
    Bool :is_closed
    Bool :is_poll

    Date :latest_time_stamp
    Date :content_created_on

    String :parent_key

    Date :last_updated
    Date :created_on

    String :content_blocking_state

    unique([:key])
  end

  DB.create_table :posts do
    String :title
    Bool :is_question
    Bool :is_discussion
    Bool :notify_owner_on_reply
    String :body

    String :last_edited_key
    String :last_edited_unique_id
    String :last_edited_time_stamp
    String :content_created_on

    # Refers to Discussion... I think
    String :parent_key

    String :forum_key
    String :category_key

    String :key

    String :owner_key
    String :owner_unique_id
    Date :last_updated
    Date :created_on

    String :content_blocking_state

  end
rescue
end
