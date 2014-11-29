DB = dbd.sqlite3

all: create init

create:
	sqlite3 ${DB} < create.sql

init: init-reverse init-forward init-mac

init-reverse: 84.69.150.in-addr.arpa
	ruby init-reverse.rb ${DB} $<

init-forward: mns.kyutech.ac.jp.zone ise.kyutech.ac.jp.zone
	ruby init-forward.rb ${DB} $<

init-mac: dhcpd.conf
	ruby init-mac.rb ${DB} $<

dhcp:
	ruby make-dhcp.rb ${DB}

reverse:
	ruby make-reverse.rb ${DB} | sort -n

forward:
	ruby make-forward.rb ${DB} | sort
