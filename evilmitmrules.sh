sysctl -w net.ipv4.ip_forward=1
#these do the same thing
echo '1' > /proc/sys/net/ipv4/ip_forward
echo May not need this next step
echo 0 | tee /proc/sys/net/ipv4/conf/*/send_redirects
/etc/init.d/dnsmasq stop
/etc/init.d/dnsmasq start
#iptables -t nat -F
iptables -F
echo before
iptables -L

iptables -t nat -A PREROUTING -i em1 -p tcp --dport 80 -j REDIRECT --to-port 8080
iptables -t nat -A PREROUTING -i em1 -p tcp --dport 443 -j REDIRECT --to-port 8080

iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE

iptables -A FORWARD -i wlan1 -o em1 -m state --state RELATED,ESTABLISHED -j ACCEPT 
iptables -A FORWARD -i em1 -o wlan1 -j ACCEPT 
echo after
iptables -L
echo mitmproxy -T --host   to watch https traffic
echo  http://mitm.it to quickly install certs. 

  