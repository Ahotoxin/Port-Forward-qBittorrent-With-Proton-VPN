#!/bin/bash

port1=0

sleep 10

while true

do date

#natpmpc is Proton VPN's way of requesting for an open port. Ports are leased in 60s chunks so it runs continuously. If it is unable to get a port it will spit out an error and attempt to restart whichever protocol you're using
natpmpc -a 0 0 udp 60 && port2=$(natpmpc -a 0 0 tcp 60 | grep -E "port \<[0-9]{1,5}\>" | awk '{print $4}') || { echo -e "ERROR with natpmpc command \a" ; sudo systemctl restart [OpenVPN or Wireguard Config].service ; wait ; break ; }

#This part checks the port number assigned with the port already given to qBittorrent, only updating it if the port number changes, otherwise it will go back to leasing ports until the number changes
 if [ "$port1" != "$port2" ]; then
 	#qBittorrent's API for updating its port requires a cookie, but to obtain the cookie you must first authenticate using the WebUI username and password
	cookie=$(curl -si --header "Referer: http://localhost:8080" --data "username=admin&password=adminadmin" http://localhost:8080/api/v2/auth/login | grep "SID" | awk '{print $2}') && curl -s http://localhost:8080/api/v2/app/setPreferences -d 'json={"listen_port": "'$port2'"}' --cookie "$cookie"
	port1=$port2
 fi
 sleep 45
done
