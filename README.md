# Pluck-Migrator

Ruby Scripts used to turn Pluck CMS into a sqlite3 relational database.

Why?

The Pluck Content Download API is a nightmare. It separates content into days and then further separates content into pages. As a result, you may have to call thousands of http requests just to get all the data for one resource.

In addition to this issue, the content is in XML form and often refers to other content types through various keys. This CLI stores everything into a sqlite database so that these references are actually in a useful format.

## Setup
Create secret_config.rb in the folder ~/src/config/ and include the following based on your Pluck setup.

$access_key = "YOUR_ACCESS_KEY"

$PLUCK_URL = "http://pluck.example.com"

## The CLI Interface
* download [ContentType]
  * All
  * UserProfile
  * BlogPost
  * BlogSettings
  * Discussions
  * Category
  * Forum
  * Post
  * Photo
