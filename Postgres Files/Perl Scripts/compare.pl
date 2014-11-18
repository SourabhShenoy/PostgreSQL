#!/usr/bin/perl -w
use strict;
use Benchmark qw( cmpthese );
use DBI;
 
my @existing_strings = (
    'PDVfHsH 2zm 3Lls ncdh Xf006',
    'VfR5L HIVWFt P2H5 yWxC6',
    'hyh ru6z19',
    'nJkC pU4V7 l4f 1ewgmxd 6BN',
    '6Mmn D1NeP IMOT2j',
    '53xWE6g fop0OM moBi zOP',
    '2EgFHwr AwpD9tt 5GY zewDok OLIE',
    '4YAQAF B87GBC7 GtIPEBC lgML awGO',
    'uxJKdN dQela AKC OIyqiTL X1qovd',
    'uzEFodF oFdH b9zHQ HWYQp1p',
);
 
my @nonexisting_strings = (
    '3zwy PJe 314P',
    'pqo6d n6j 5t1V',
    'XEyoX ciKRh01d iJrSS',
    'pa3r29P V16Gv1gy ayEv',
    'TB0f9 5TE wbP1GI',
    'T0btpG aK6R1hF x1mXlo',
    '2T2 xdMf6k1b WUuZi',
    'dPV xipP4 az1F',
    't3IC Qjbtx5V H186',
    'XLyiZa6 Wj1 XK1Kz',
);
 
my $dbh = DBI->connect(
    'dbi:Pg:dbname=test;host=127.0.0.1;port=5432', "sourabh", "", 
    {
        'AutoCommit' => 1,
        'RaiseError' => 1,
        'PrintError' => 1,
    }
);
 
print "Testing existing keys:\n";
cmpthese(
    50000,
    {
        'existing_hash'            => sub { fetch_from( 'hash_test_table',         \@existing_strings ); },
        'existing_btree'           => sub { fetch_from( 'btree_test_table',        \@existing_strings ); },
        'existing_unique_btree'    => sub { fetch_from( 'u_btree_test_table', \@existing_strings ); },
    }
);
 
print "\nTesting nonexisting keys:\n";
cmpthese(
    50000,
    {
        'nonexisting_hash'         => sub { fetch_from( 'hash_test_table',         \@nonexisting_strings ); },
        'nonexisting_btree'        => sub { fetch_from( 'btree_test_table',        \@nonexisting_strings ); },
        'nonexisting_unique_btree' => sub { fetch_from( 'u_btree_test_table', \@nonexisting_strings ); },
    }
);
 
exit;
 
sub fetch_from {
    my ( $table, $values ) = @_;
    my $sql = 'SELECT * FROM ' . $table . ' WHERE random_string = ANY( ? )';
    my $rows = $dbh->selectall_arrayref( $sql, undef, $values );
    return;
}
