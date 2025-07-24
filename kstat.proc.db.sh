#!/usr/bin/bash
# Set systemctl to run on each compute node with 'kstat.proc.db.sh &'
# This will set the environment up and run kstat.proc.db which will 
#   continuously loop and incert data into the Postgres DB every minute.

module purge
module load Perl/5.36.1-GCCcore-12.3.0
module load PostgreSQL/16.1-GCCcore-12.3.0

export PERL5LIB=/opt/beocat/kstat/perl5/

HOST=`hostname`

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p $SCRIPT_DIR/node.logs
$SCRIPT_DIR/kstat.proc.db >> $SCRIPT_DIR/node.logs/kstat.$HOST.log 2>&1

