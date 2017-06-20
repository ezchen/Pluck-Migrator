require_relative '../src/schema.rb'
require_relative '../src/models/user_profile.rb'
require_relative '../src/models/blog_post.rb'
require 'Nokogiri'
require 'test/unit'
require 'Sequel'

$xml_string = '''
<UserProfile>
  <ImageUrl>http://pluck.frommers.com/ver1.0/Content/images/no-user-image.gif</ImageUrl>
  <UserTier>Trusted</UserTier>
  <_forumMembershipState>Unspecified</_forumMembershipState>
  <SkipLists>False</SkipLists>
  <AboutMe/>
  <Sex/>
  <DateOfBirth>0001-01-01T00:00:00-05:00</DateOfBirth>
  <Location/>
  <PersonaPrivacyMode>Public</PersonaPrivacyMode>
  <CustomAnswers/>
  <ExtendedProfile/>
  <IsBlocked>False</IsBlocked>
  <IsEmailNotificationsEnabled>False</IsEmailNotificationsEnabled>
  <DisableAllEmailNotifications>False</DisableAllEmailNotifications>
  <ContentDownloadUserDisplayName>Adelinabumb</ContentDownloadUserDisplayName>
  <Key>
    <UserKey>
      <Key>KEY_CONSTANT</Key>
      <UniqueId>UNIQUE_ID_CONSTANT</UniqueId>
      <IsAnonymous>False</IsAnonymous>
      <DontParseKeySeed>False</DontParseKeySeed>
      <ObjectType>Models.Users.UserKey</ObjectType>
      <PartitionHash>
	<Byte>247</Byte>
	<Byte>227</Byte>
      </PartitionHash>
    </UserKey>
    <DontParseKeySeed>False</DontParseKeySeed>
    <Key>adelinabumb</Key>
    <ObjectType>Users.Keys.UserProfileKey</ObjectType>
    <PartitionHash>
      <Byte>247</Byte>
      <Byte>227</Byte>
    </PartitionHash>
  </Key>
  <ContentBlockingState>Unblocked</ContentBlockingState>
  <ImmuneToAbuseReportsState>NotImmune</ImmuneToAbuseReportsState>
  <LastUpdated>2017-01-23T15:58:23-05:00</LastUpdated>
  <CreatedOn>2017-01-23T15:58:23-05:00</CreatedOn>
  <SiteOfOriginKey>system</SiteOfOriginKey>
  <AuthorEmailAddress>EMAIL_CONSTANT</AuthorEmailAddress>
</UserProfile>'''

$blog_post_xml = '''<BlogPost>
      <NeedsToUpdateFullText>True</NeedsToUpdateFullText>
      <SkipLists>False</SkipLists>
      <UpdatingComments>False</UpdatingComments>
      <UnencodedTitle>Italian State-Run Museums Now Free to Everyone Under the Age of 18</UnencodedTitle>
      <Body>body</Body>
      <BodyAbstract/>
      <Tags>Italy, Rome, Florence, Venice, Museums, Art, Culture, Uffizi, Palermo, Bologna, Pisa, Siena</Tags>
      <TagsPrevious>Italy, Rome, Florence, Venice, Museums, Art, Culture, Uffizi, Palermo, Bologna, Pisa, Siena</TagsPrevious>
      <TimeStamp>2013-06-04T21:58:00-04:00</TimeStamp>
      <IsPublished>True</IsPublished>
      <ParentKey>
        <UserKey>
          <UniqueId>697c8767-df38-4150-a3f3-487b66dac850</UniqueId>
          <IsAnonymous>False</IsAnonymous>
          <DontParseKeySeed>False</DontParseKeySeed>
          <Key>697c8767-df38-4150-a3f3-487b66dac850</Key>
          <ObjectType>Models.Users.UserKey</ObjectType>
          <PartitionHash>
            <Byte>196</Byte>
            <Byte>196</Byte>
          </PartitionHash>
        </UserKey>
        <DontParseKeySeed>False</DontParseKeySeed>
        <Key>Blog:697c8767-df38-4150-a3f3-487b66dac850</Key>
        <ObjectType>Models.Blogs.BlogKey</ObjectType>
        <PartitionHash>
          <Byte>224</Byte>
          <Byte>251</Byte>
        </PartitionHash>
      </ParentKey>
      <LastEditedBy>
        <UniqueId>pauline frommer</UniqueId>
        <IsAnonymous>False</IsAnonymous>
        <DontParseKeySeed>False</DontParseKeySeed>
        <Key>pauline frommer</Key>
        <ObjectType>Models.Users.UserKey</ObjectType>
        <PartitionHash>
          <Byte>115</Byte>
          <Byte>15</Byte>
        </PartitionHash>
      </LastEditedBy>
      <LastEditTimeStamp>2013-06-04T21:58:00-04:00</LastEditTimeStamp>
      <Title>Italian State-Run Museums Now Free to Everyone Under the Age of 18</Title>
      <LastCommentDate>0001-01-01T00:00:00-05:00</LastCommentDate>
      <Key>
        <BlogKey>
          <UserKey>
            <UniqueId>697c8767-df38-4150-a3f3-487b66dac850</UniqueId>
            <IsAnonymous>False</IsAnonymous>
            <DontParseKeySeed>False</DontParseKeySeed>
            <Key>697c8767-df38-4150-a3f3-487b66dac850</Key>
            <ObjectType>Models.Users.UserKey</ObjectType>
            <PartitionHash>
              <Byte>196</Byte>
              <Byte>196</Byte>
            </PartitionHash>
          </UserKey>
          <DontParseKeySeed>False</DontParseKeySeed>
          <Key>Blog:697c8767-df38-4150-a3f3-487b66dac850</Key>
          <ObjectType>Models.Blogs.BlogKey</ObjectType>
          <PartitionHash>
            <Byte>224</Byte>
            <Byte>251</Byte>
          </PartitionHash>
        </BlogKey>
        <DontParseKeySeed>False</DontParseKeySeed>
        <Key>Blog:697c8767-df38-4150-a3f3-487b66dac850Post:6186f872-2e1b-41d3-8450-616a1e5ec443</Key>
        <ObjectType>Models.Blogs.BlogPostKey</ObjectType>
        <PartitionHash>
          <Byte>242</Byte>
          <Byte>8</Byte>
        </PartitionHash>
      </Key>
      <ContentBlockingState>Unblocked</ContentBlockingState>
      <ImmuneToAbuseReportsState>NotImmune</ImmuneToAbuseReportsState>
      <Owner>
        <UniqueId>pauline frommer</UniqueId>
        <IsAnonymous>False</IsAnonymous>
        <DontParseKeySeed>False</DontParseKeySeed>
        <Key>pauline frommer</Key>
        <ObjectType>Models.Users.UserKey</ObjectType>
        <PartitionHash>
          <Byte>115</Byte>
          <Byte>15</Byte>
        </PartitionHash>
      </Owner>
      <LastUpdated>2017-01-09T16:38:27-05:00</LastUpdated>
      <CreatedOn>2013-06-04T21:58:03-04:00</CreatedOn>
      <SiteOfOriginKey>system</SiteOfOriginKey>
    </BlogPost>'''

class TestUserProfileModel < Test::Unit::TestCase
  def create_user_xml(user_num)
    new_string = $xml_string.dup
    new_string.sub! 'KEY_CONSTANT', "KEY_#{user_num}"
    new_string.sub! 'UNIQUE_ID_CONSTANT', "UNIQUE_ID_#{user_num}"
    new_string.sub! 'EMAIL_CONSTANT', "email#{user_num}@gmail.com"
    return new_string
  end

  def test_create_from_xml
    xml = Nokogiri::XML(create_user_xml(1))
    up = UserProfile.create_from_xml(xml.child)

    # Should fail when key, unique_id, or email are not unique
    assert_raise do
      up = UserProfile.create_from_xml(xml.child)
    end
  end
end

class TestBlogPostModel < Test::Unit::TestCase
  def create_blog_post_xml(blog_post_num)
    return $blog_post_xml.dup
  end

  def test_create_from_xml
    xml = Nokogiri::XML(create_blog_post_xml(1))
    BlogPost.create_from_xml(xml.child)
  end
end
