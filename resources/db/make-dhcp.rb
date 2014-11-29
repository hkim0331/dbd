#!/usr/bin/env ruby
# programmed by hkimura, 2014-11-29

DEBUG = true

require 'sequel'

def usage
  print <<EOU
usage: #{$0} DB > dhcpd.conf ...
EOU
  exit
end

def debug(s)
  puts s if DEBUG
end

usage if ARGV[0].nil?
DS = Sequel.sqlite(ARGV.shift)[:tbl]
DS.where(Sequel.like(:mac, '%')).each do |e|
  puts <<EOD
host #{e[:fqdn].split(/\./).first} {
    hardware ethernet #{e[:mac]};
    fixed-address #{e[:ip]};
}

EOD
end
