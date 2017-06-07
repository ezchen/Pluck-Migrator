require 'require_all'
require_rel './secret_config'

$RESOURCES = [
  "UserProfile",
  "BlogPost",
  "BlogSettings",
  "Category",
  "Forum",
  "Discussion",
  "Post",
  "Photo",
  "Video",
  "Gallery",
  "GallerySubmission",
  "VideoSubmission",
  "ExternalResource",
  "Rating",
  "Review",
  "Comment",
  "Recommendation"
]

$BUCKETED_RESOURCES = [
]

$NON_BUCKETED_RESOURCES = [
]

$ITEMS_PER_PAGE = 1000
