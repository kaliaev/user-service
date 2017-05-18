require 'active_record'
require 'rspec'
require 'rack/test'
require_relative '../client.rb'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.expect_with(:rspec) { |c| c.syntax = :should }
end

describe "client" do
  before(:all) do
    User.base_uri = "http://localhost:4567"
    
    User.destroy("paul")
    User.destroy("trotter")

    User.create(
      :name => "paul",
      :email => "paul@pauldix.net",
      :password => "strongpass",
      :bio => "rubyist")
    User.create(
      :name => "bryan",
      :email => "bryan@spamtown.usa",
      :password => "strongpass",
      :bio => "rubyist")
  end

  it "should get a user" do
    user = User.find_by_name("paul")
    user[:name].should eql?("paul")
    user[:email].should eql?("paul@pauldix.net")
    user[:bio].should eql?("rubyist")
  end
  
  it "should return nil for a user not found" do
    User.find_by_name("gosling").should be_nil
  end
  
  it "should create a user" do
    user = User.create({
      :name => "trotter",
      :email => "no spam",
      :password => "whatev"})
    user[:name].should eql?("trotter")
    user[:email].should eql?("no spam")
    User.find_by_name("trotter").should eq(user)
    
  end
  
  it "should update a user" do
    user = User.update("paul", {:bio => "rubyist and author"})
    user["name"].should  eql?("paul")
    user["bio"].should eql?("rubyist and author")
    User.find_by_name("paul").should equal?(user)           #Object comparison
  end
  
  it "should destroy a user" do
    User.destroy("bryan").should be_truthy
    User.find_by_name("bryan").should be_nil
  end
  
  it "should verify login credentials" do
    user = User.login("paul", "strongpass")
    user["name"].should eql?("paul")
  end
  
  it "should return nil with invalid credentials" do
    User.login("paul", "wrongpassword").should be_nil
  end
end

















