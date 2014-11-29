#!/usr/bin/env ruby
# programmed by hkimura, 2014-11-29

DEBUG = false

require 'sequel'

def usage
  print <<EOU
usage: #{$0} DB zone1 zone2 ...
EOU
  exit
end

def debug(s)
  puts s if DEBUG
end

def init_forward(ds, file)
  today = Time.now.strftime("%Y-%m-%d")
  domain = file.sub(/.zone$/,'')
  debug domain
  File.foreach(file) do |line|
    next if line =~ /^;/
    next unless line =~ /IN\s+A/
    name,dum1,dum2,ip,user = line.split(/\s+/,5)
    fqdn = "#{name}.#{domain}"
    if user.empty?
      user = "no user"
    else
      user = user.sub(/^;/,'').strip.sub(/mns\.kyutech\.ac\.jp/,'')
    end
    found = ds.where(ip: ip).first
    next if found
    debug "#{ip} #{fqdn} #{user}"
    unless DEBUG
      ds.insert(ip: ip,
                fqdn: fqdn,
                user: user,
                rev: 0,
                updated_at: today,
                created_at: today)
    end
  end
end

usage if ARGV[0].nil? or ARGV[1].nil?
DS = Sequel.sqlite(ARGV.shift)[:tbl]

while (arg=ARGV.shift)
  init_forward(DS, arg)
end

