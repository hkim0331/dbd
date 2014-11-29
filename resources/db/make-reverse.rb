#!/usr/bin/env ruby
# programmed by hkimura, 2014-11-29

DEBUG = true

require 'sequel'

def usage
  print <<EOU
usage: #{$0} DB > rev.arpa
EOU
  exit
end

def debug(s)
  puts s if DEBUG
end

usage if ARGV[0].nil?
DS = Sequel.sqlite(ARGV.shift)[:tbl]
ret=[]
DS.where(Sequel.like(:ip, "150.69.84.%")).each do |e|
  print <<EOD
#{e[:ip].split(/\./)[3]} IN PTR #{e[:fqdn]}. ; #{e[:user]}
EOD
end
