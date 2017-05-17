describe "client" do
  before(:each) do
    User.base_uri = "http://localhost:4567"
  end

  it "should get a user" do
    user = User.find_by_name("paul")
    user[:name].should  = "paul"
    user[:email].should = "paul@pauldix.net"
    user[:bio].should   = "rubyist"
  end
  
  it "should return nil for a user not found" do
    User.find_by_name("gosling").should be_nil
  end
  
  it "should create a user" do
    user = User.create({
      :name => "trotter",
      :email => "no spam",
      :password => "whatev"})
    user[:name].should  === "trotter"
    user[:email].should === "no spam"
    User.find_by_name("trotter").should == user
    
  end
  
end