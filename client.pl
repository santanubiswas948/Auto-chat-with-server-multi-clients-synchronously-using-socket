#!/usr/bin/perl -w

use strict;
use Socket;
my($host, $port )=("localhost", 2300);

socket(SOCKET, PF_INET, SOCK_STREAM, (getprotobyname('tcp'))[2]) or die "Client Socket is not created: $!";
connect(SOCKET, pack_sockaddr_in($port, inet_aton($host))) or die "Can't connect with server";
autoflush SOCKET 1;
my $line;
while($line = <STDIN>)
{
    # chomp($line);
    if(lc($line) =~ /exit/)
    {
        print "Exit";
        last;
    }
    #Write Data to server==========
    print SOCKET "Client: $line";
    
    #Read Data from Server============
    my $data = <SOCKET>;
    print $data if defined($data);
}