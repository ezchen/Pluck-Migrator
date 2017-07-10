require 'set'
require "thor"
require_relative "./src/app.rb"
require_relative "./src/models/blog_post.rb"
require_relative "./src/models/blog_setting.rb"

class CLI < Thor
  desc "download CONTENTTYPE", "downloads CONTENTTYPE (All, UserProfile, BlogPost, BlogSettings, Discussions)"
  def download(content_type)
    if content_type == "All"
      download_all()
    end
    if content_type == "UserProfile"
      download_user_profiles
    end
    if content_type == "BlogPost"
      download_blog_posts
    end
    if content_type == "BlogSettings"
      download_blog_settings
    end
    if content_type == "Discussions"
      download_discussions
    end
    if content_type == "Category"
      download_categories
    end
    if content_type == "Forum"
      download_forums
    end
    if content_type == "Post"
      download_posts
    end
    if content_type == "Photo"
      download_photos
    end
  end

  desc "print CONTENTTYPE", "prints CONTENTTYPE"
  def print(content_type)
    print_resource(true, content_type)
  end

  desc "getblogs", "gets number of blogs and prints out last edited time stamps"
  def getblogs()
    s = Set.new
    a = []
    BlogPost.all.each do |blog_post|
      if s.add?(blog_post.parent_blog_key) != nil
        a.push("#{blog_post.last_edited_time_stamp}: #{blog_post.title}")
      end
    end
    print s.length
    a = a.sort

    a.each do |string|
      print string + "\n"
    end
    print a.length

  end

  desc "getemptyownerkeyposts", "gets number of posts with no owner_key"
  def getemptyownerkeyposts()
    count = 0

    Post.all.each do |post|
    end

    print count
  end
end

CLI.start(ARGV)
