require "pathname"
begin
  require "bacon"
rescue LoadError
  require "rubygems"
  require "bacon"
end

begin
  if (local_path = Pathname.new(__FILE__).dirname.join("..", "lib", "ruby_sip.rb")).file?
    require local_path
  else
    require "ruby_sip"
  end
rescue LoadError
  require "rubygems"
  require "ruby_sip"
end

Bacon.summary_on_exit

describe "Spec Helper" do
  it "Should bring our library namespace in" do
    RubySip.should == RubySip
  end
end


