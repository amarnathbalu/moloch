use Test::More tests => 24;
use Cwd;
use URI::Escape;
use MolochTest;
use strict;

my $pwd = getcwd() . "/pcap";

# stats.json
    my $stats = viewerGet("/stats.json");
    is (@{$stats->{aaData}}, 1, "stats.json aaData set ");
    is ($stats->{iTotalRecords}, 1, "stats.json iTotalRecords");
    is ($stats->{aaData}->[0]->{id}, "test", "stats.json name");
    foreach my $i ("diskQueue", "deltaDroppedPerSec") {
        is ($stats->{aaData}->[0]->{$i}, 0, "stats.json $i 0");
    }

    foreach my $i ("monitoring", "diskQueue", "deltaDropped", "deltaDroppedPerSec") {
        is ($stats->{aaData}->[0]->{$i}, 0, "stats.json $i == 0");
    }

    foreach my $i ("deltaMS", "totalPackets", "deltaSessions", "deltaPackets", "deltaBytes", "memory", "cpu", "currentTime", "totalK", "totalSessions", "freeSpaceM", "deltaSessionsPerSec", "deltaBytesPerSec", "deltaPacketsPerSec") {
        cmp_ok ($stats->{aaData}->[0]->{$i}, '>', 0, "stats.json $i > 0");
    }

# dstats.json
    my $dstats = viewerGet("/dstats.json?nodeName=test&start=1399680425&stop=1399680460&step=5&interval=5&name=deltaPackets");
    is (@{$dstats}, 7, "dstats.json array size");
