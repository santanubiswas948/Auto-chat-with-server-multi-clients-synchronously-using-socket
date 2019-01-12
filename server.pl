#!usr/bin/perl -w

use strict;
use Socket;

my($host, $port, $client_addr, $CLIENT_SOCKET);

($host, $port) = ("localhost", 2300);
socket(SOCKET, PF_INET, SOCK_STREAM, (getprotobyname('tcp'))[2]) or die "Server Socket is not created $!";
bind(SOCKET, pack_sockaddr_in($port, inet_aton($host))) or die "Bind not possible $!";
listen(SOCKET, 5);
print "Server is started in port:2300\n";
autoflush SOCKET 1;
while($client_addr = accept($CLIENT_SOCKET, SOCKET))
{
    autoflush $CLIENT_SOCKET 1;
    my $client_host = gethostbyaddr($client_addr, AF_INET);
    print "\n\nServer is connected with host:", $client_host, "\n";
    while(1)
    {
        # Read Data from client=============
        my $data = <$CLIENT_SOCKET>;
        print $data if defined($data);
        if(defined($data))
        {
            #Write Data to client server================
            print $CLIENT_SOCKET "SERVER: Data from Server\n";
        }
        else
        {
             print "Disconnected from Server host:$client_host\n";
             close $CLIENT_SOCKET;
             last;
        }
    }
}