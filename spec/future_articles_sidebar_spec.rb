require File.dirname(__FILE__) + '/spec_helper'

describe FutureArticlesSidebar do
  before(:each) do
    @sidebar = FutureArticlesSidebar.new
  end

  it 'should be available as sidebar' do
    Sidebar.available_sidebars.should include(FutureArticlesSidebar)
  end

  it 'should only show future articles' do
      Article.new(:title => 'Future', :published_at => Time.now + 1.day).publish!
      Article.new(:title => 'Past', :published_at => Time.now - 1.day).publish!

      @sidebar.articles.find{|article| article.title == 'Future'}.should_not be_nil
      @sidebar.articles.find{|article| article.title == 'Past'}.should be_nil
  end

  it 'should only show published articles' do
      Article.new(:title => 'Published', :published_at => Time.now + 1.day).publish!
      Article.new(:title => 'Not Published', :published_at => Time.now + 1.day).save

      @sidebar.articles.find{|article| article.title == 'Published'}.should_not be_nil
      @sidebar.articles.find{|article| article.title == 'Not Published'}.should be_nil
  end

  it 'should only show the selected number of articles' do
      Article.new(:title => '1', :published_at => Time.now + 1.day).publish!
      Article.new(:title => '2', :published_at => Time.now + 1.day).publish!
      Article.new(:title => '3', :published_at => Time.now + 1.day).publish!

      @sidebar.count = 2

      @sidebar.articles.should have(2).items
  end
end
