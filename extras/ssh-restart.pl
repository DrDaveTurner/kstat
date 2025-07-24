#!/usr/bin/env perl
# Script to run ssh command to each host on Beocat
# USAGE:  ssh-restart.pl
# This will kill kstat.proc.db and kstat.proc.db.sh to allow auto restart

use 5.6.0;

   # Start by getting a list of all the host names on Beocat

$hostlist[0] = "hero35";
$hostlist[1] = "hero36";

if( ! @hostlist ) {
   foreach $line (`kstat --nocolor -h` ) {

      #next if lc($line) =~ "warlock";

      if( lc($line) =~ "load" and $line !~ "Down" ) {

         $host = ( split( ' ', $line) )[0];
         chomp( $host );
         push @hostlist, lc($host);
      }
   }
}

printf "Hostlist @hostlist\n\n";

#exit();

#sleep(20);

foreach $host ( @hostlist ) {   

   printf "$host: ";

   $result = `ssh $host 'pkill -f kstat.proc.db 2>&1'`;
   #if( $result =~ "no.process.found" ) {
      #$result2 = `ssh $host "sh -c 'nohup cd /homes/daveturner/bin; kstat.proc.db.sh > /dev/null 2>&1 &'"`;
      #printf "kstat.proc.db.sh started anew";
   #} else {
      printf "kstat.proc.db.sh and kstat.proc.db  killed to restart";
   #}

   printf " - done\n";
}
