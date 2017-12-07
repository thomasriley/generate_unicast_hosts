#!/usr/bin/env ruby
require 'net/dns'
require 'optparse'

$stdout.sync = true

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: generate_unicast_hosts.rb [options]'

  opts.on('-h', '--hostname HOSTNAME', 'Hostname to parse') do |opt|
    options[:hostname] = opt
  end

  opts.on('-p', '--path PATH', 'Path to write unicast file') do |opt|
    options[:path] = opt
  end
end.parse!

File.delete(options[:path])

packet = Net::DNS::Resolver.start(options[:hostname])
packet.each_address do |ip|
  puts "Found IP: #{ip}"
  File.open(options[:path], 'a') { |file| file.write("#{ip}\n") }
end
