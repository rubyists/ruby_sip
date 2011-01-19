require_relative "../lib/ruby_sip"
require "ruby_sip/listener"
EventMachine::run {
  EventMachine::open_datagram_socket "192.168.6.40", 5061, RubySip::Listener
  puts "Server Started"
}
