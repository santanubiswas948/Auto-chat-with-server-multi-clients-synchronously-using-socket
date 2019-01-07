#!/usr/bin/perl -w

use strict;
use IO::Socket;

my($handler, $client, $pid, %msg_dict);
%msg_dict=(
    "hi" => "Hello",
    "who_are_you" => "I am Server",
    "where_are_you_living" => "localhost",
    "what_are_you_doing" => "Processing Data and Storing data",
    
    "others" => "I am server"
); 
$| = 1;
$handler = IO::Socket::INET->new(
    LocalHost => 'localhost',
    LocalPort => 2300,
    Proto => 'tcp',
    Listen => 5,
    Reuse => 1
) or die "Error in Server Start: $!";
print "Server Started in PORT 2300\n";
    while($client = $handler->accept())
    {
        print "Error Occured: $!" unless defined($pid = fork());
        if($pid){}
        else
        {
            my $clienthost = $client->peerhost();
            my $clientport = $client->peerport();
            print "\n\nConnected from ",$clienthost," Port: ",$clientport,"\n";
            while(1)
            {
                #Read Data from Client-----
                my $data = <$client>;
                chomp($data) if defined($data);
                last unless defined($data);
                if($data =~ /^[A-Za-z0-9]/)
                {
                    print "Client: $data(Host:$clienthost Port:$clientport)\n";
                    $data = lc($data);
                    my @arr = split(" ",$data);
                    $data = join("_",@arr);
                    if(exists $msg_dict{$data})
                    {
                        my $data1 = $msg_dict{$data};
                        print $client "$data1\n";
                    }
                    else
                    {
                        my $data1 = $msg_dict{'others'};
                        print $client "$data1\n";
                    }
                }
            }
            print "Disconnected the host:$clienthost Port:$clientport\n\n";
            kill 'KILL';
        }
    }
   