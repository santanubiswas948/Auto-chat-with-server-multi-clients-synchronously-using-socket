#!/usr/bin/perl -w

use strict;
use IO::Socket;
$| = 1;
my($handler, $pid, $line);
my($server_host, $server_port, $proto) = ("localhost", 2300, 'tcp');
$handler = IO::Socket::INET->new(
    PeerHost => $server_host,
    PeerPort => $server_port,
    Proto => $proto
    ) or die "Can't connect to server $!";
#Start communication to server=====
print "You: ";
while(my $msg =<STDIN>)
{
    if($msg =~ /exit/){last;}
    #Write data to server===============
    print $handler $msg."\n";
    sleep(1);
    #read From Server=========
    my $data = <$handler>;
    print "Server: ".$data;
    print "You: ";
}