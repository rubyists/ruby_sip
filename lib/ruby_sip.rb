require "pathname"
require "eventmachine"
$LOAD_PATH.unshift(File.expand_path("../", __FILE__))
p $LOAD_PATH
# Allows for pathnames to be easily added to
class Pathname
  def /(other)
    join(other.to_s)
  end
end

# The Ruby Sip library, by TJ Vanderpoel
module RubySip
  ROOT = Pathname($LOAD_PATH.first).join("..").expand_path
  LIBROOT = ROOT/:lib
  MIGRATION_ROOT = ROOT/:migrations
  MODEL_ROOT = ROOT/:model
  SPEC_HELPER_PATH = ROOT/:spec
  autoload :VERSION, "ruby_sip/version"
end
