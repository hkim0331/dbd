#!/usr/bin/env ruby
# programmed by hkimura, 2014-11-29

DEBUG = true

require 'sequel'

def usage
  print <<EOU
usage: #{$0} DB > dom.zome
EOU
  exit
end

def debug(s)
  puts s if DEBUG
end

usage if ARGV[0].nil?
DS = Sequel.sqlite(ARGV.shift)[:tbl]
ret=[]
DS.where(Sequel.like(:fqdn, "%mns.kyutech.ac.jp")).each do |e|
  print <<EOD
#{e[:fqdn].split(/\./)[0]} IN A #{e[:ip]}. ; #{e[:user]}
EOD
end
