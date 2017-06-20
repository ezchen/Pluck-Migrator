require 'require_all'
require_rel './schema.rb'
require_rel './config/config.rb'
require_rel './models'
require_rel './data/'

def get_all_content_items(content_type)
  return Api.get_all_content_items($PLUCK_URL, content_type, $access_key, $START_YEAR, $START_MONTH, $START_DAY)
end

def get_all_content_no_date(content_type)
  items = []
  Api.get_all_content_items_no_dates(items, $PLUCK_URL, content_type, $access_key)
  return items
end

def download_user_profiles
  user_profiles = get_all_content_items('UserProfile')

  user_profiles.size.times.map {
    profile = user_profiles.pop
    UserProfile.create_from_xml(profile)
  }
end

def download_blog_posts
  blog_posts = get_all_content_items('BlogPost')

  blog_posts.size.times.map {
    blog_post = blog_posts.pop
    BlogPost.create_from_xml(blog_post)
  }
end

def download_blog_settings
  blog_settings = get_all_content_items('BlogSettings')

  blog_settings.size.times.map {
    blog_setting = blog_settings.pop
    BlogSetting.create_from_xml(blog_setting)
  }
end

def download_discussions
  discussions = get_all_content_items('Discussion')

  discussions.size.times.map {
    discussion = discussions.pop
    Discussion.create_from_xml(discussion)
  }
end

def download_categories
  categories = get_all_content_no_date('Category')

  categories.size.times.map {
    category = categories.pop
    Category.create_from_xml(category)
  }
end

def download_forums
  forums = get_all_content_no_date('Forum')

  forums.size.times.map {
    forum = forums.pop
    Forum.create_from_xml(forum)
  }
end

def download_posts
  posts = get_all_content_items('Post')

  posts.size.times.map {
    post = posts.pop
    Post.create_from_xml(post)
  }
end

def download_photos
  photos = get_all_content_items('Photo')

  photos.size.times.map {
    photo = photos.pop
    print photo
  }
end

def print_resource(is_dated, content_type)
  items = []

  if is_dated
    items = get_all_content_items(content_type)
  else
    items = get_all_content_no_date(content_type)
  end

  items.size.times.map {
    item = items.pop
    print item
  }
end

def download_all
  print "Starting user profiles"
  download_user_profiles()
  print "Starting blog posts"
  download_blog_posts()
  print "Starting blog settings"
  download_blog_settings()
  print "Starting discussions"
  download_discussions()
  print "Starting categories"
  download_categories()
  print "Starting forums"
  download_forums()
  print "Starting posts"
  download_posts()
end
