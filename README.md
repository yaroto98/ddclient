# ddclient
This is a Dynamic DNS client. It replaces the ddclient in the repositories.

This client will only work using the Namecheap free DDclient tool.

This client allows the ability to manage multiple domains and subdomains on one server. It also reduces the overhead of the current ddclient in the repositories. It does this by checking the ipaddress of the server, and the ipaddress of the domain. If they are different it will push the update to Namecheap. The documentation of ddclient in the repositories asks you to limit how often you run the ddclient so as not to overload these free services. You need not worry with this tool. You can easily run this every few minutes without overloading anything.


INSTALL:

Clone git repo:

	git clone https://github.com/yaroto98/ddclient /root/ddclient

add crontab (as root):

	crontab -e

	*/15 * * * * /root/ddclient/myddclient.sh > /dev/null 2>&1

