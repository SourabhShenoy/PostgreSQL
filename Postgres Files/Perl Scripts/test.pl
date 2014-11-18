#!/usr/bin/perl

use DBI;
use strict;

my $driver   = "Pg"; 
my $database = "test";
my $dsn = "DBI:$driver:dbname=$database;host=127.0.0.1;port=5432";
my $userid = "sourabh";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
                      or die $DBI::errstr;

print "Opened database successfully\n";
