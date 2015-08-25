#/bin/bash
haschanged() {
        isdiff=0
#       echo $hostlist
        hostlist=$1
        domain="$2"
        ipaddressnew=`dig +short myip.opendns.com @resolver1.opendns.com`
        for host in ${hostlist[@]}
        do
                if [ $host == "@" ]; then
                        ipaddresscurrent=`nslookup $domain | grep Address | grep -v "#" | cut -f2 -d" "`
                else
                        ipaddresscurrent=`nslookup $host.$domain | grep Address | grep -v "#" | cut -f2 -d" "`
                fi
                if [ "$ipaddresscurrent" != "$ipaddressnew" ]; then
                        isdiff=1
                fi

        done
        return $isdiff
}
update() {
        hostlist=$1
        domain="$2"
        password="$3"
        for host in ${hostlist[@]}
        do
                response=`curl http://dynamicdns.park-your-domain.com/update?host="$host"\&domain="$domain"\&password="$password"`
                echo
                errorcount=`echo "\"$response\"" | perl -pe "s/.*\<ErrCount\>(\d+)\<\/ErrCount\>.*/\\$1/gi"`
                if [ $errorcount -gt 0 ]; then
                        echo $response >> /var/log/ddclient.err
                fi
        done

}
isdiff='0'

######################
#Copy and paste this code as many times as you need. Change the values in the hostlist for the a records you wish to update, the domain to your domain, and the password as given out by namecheap
hostlist=("@" "www" "beta")
domain="example.com"
password="########################"
haschanged $hostlist "$domain"
if [ $isdiff -gt 0 ]; then
        update $hostlist "$domain" "$password"
fi
###############################

#####Example of another block.
#hostlist=("@" "www")
#domain="mysite.com"
#password="####################"
#haschanged $hostlist "$domain"
#if [ $isdiff -gt 0 ]; then
#        update $hostlist "$domain" "$password"
#fi
##################

#######Another site, you can put in as many as you want
#Delete the blocks you don't need, uncomment the ones you want to use, or copy paste in as many as you'd like.
#hostlist=("@" "www" "blog" "sql" "cloud")
#domain="yetanothersite.com"
#password="###################"
#haschanged $hostlist "$domain"
#if [ $isdiff -gt 0 ]; then
#        update $hostlist "$domain" "$password"
#fi

