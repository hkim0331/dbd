#!/usr/bin/env ruby
# programmed by hkimura, 2014-11-29

DEBUG = false

require 'sequel'

def usage
  print <<EOU
usage: #{$0} DB dhcpd.conf ...
EOU
  exit
end

def debug(s)
  puts s if DEBUG
end

def init_mac(ds, file)
  today = Time.now.strftime("%Y-%m-%d")
  ethernet = nil
  address = nil
  File.foreach(file) do |line|
    next if line =~ /^\s*#/
    if line =~ /hardware ethernet\s+(.*);/
      ethernet = $1
    elsif line =~ /fixed-address\s+(.*);/
      address = $1
      e = ds.where(ip: address).first
      if e
        if DEBUG
          debug "update #{e[:id]} #{address} with #{ethernet}"
        else
          ds.where(id: e[:id]).update(mac: ethernet)
        end
      else
        raise "can not find ip: #{ip}"
      end
    end
  end
end

usage if ARGV[0].nil? or ARGV[1].nil?
DS = Sequel.sqlite(ARGV.shift)[:tbl]

while (arg = ARGV.shift)
  init_mac(DS, arg)
end

