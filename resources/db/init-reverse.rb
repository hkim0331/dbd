#!/usr/bin/env ruby
# programmed by hkimura, 2014-11-29

DEBUG = false

require 'sequel'

def usage
  print <<EOU
usage: #{$0} DB rev1 rev2 ...
EOU
  exit
end

def debug(s)
  puts s if DEBUG
end

def init_reverse(ds, file)
  today = Time.now.strftime("%Y-%m-%d")
  File.foreach(file) do |line|
    next if line =~ /^;/
    next unless line =~ /IN\s+PTR/
    addr,dum1,dum2,fqdn,user = line.split(/\s+/,5)
    ip = "150.69.84.#{addr}"
    fqdn = fqdn.sub(/\.$/,'')
    if user.empty?
      user = "no user"
    else
      user = user.sub(/^;/,'').strip.sub(/mns\.kyutech\.ac\.jp/,'')
    end
    debug "#{ip} #{fqdn} #{user}"
    unless DEBUG
      ds.insert(ip: ip,
                fqdn: fqdn,
                user: user,
                rev: 1,
                updated_at: today,
                created_at: today)
    end
  end
end

usage if ARGV[0].nil? or ARGV[1].nil?
DS = Sequel.sqlite(ARGV.shift)[:tbl]

while (arg=ARGV.shift)
  init_reverse(DS, arg)
end

