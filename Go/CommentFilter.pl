 #!/usr/bin/perl
 #
 # CommentFilter.pl by Chris Goldsmith
 #
 # Usage CommentFilter.pl filein fileout arguments
 #
 # arguments can be -
 # -u username         - users with this username are not filtered
 # -pl                 - keep comments from the players of the game
 # -r minimum rank     - minimum rank for comments to keep
 #
 # Examples:
 #    CommentFilter.pl chrisg-bibble.sgf cg-bib-filtered1.sgf -pl
 #    Keeps all comments by chrisg and bibble in the file.
 #

 #    CommentFilter.pl chrisg-bibble.sgf cg-bib-filtered2.sgf -pl -u Datakuru
 #    Keeps all comments by chrisg, bibble and Datakuru in the file.
 #
 #    CommentFilter.pl chirsg-bibble.sgf cg-bib-filtered3.sgf -u Datakuru -r 10k
 #    Keeps all comments by Datakuru and anyone of rank 10k or greater in the file.
 #
 # Changes:
 # D. Gilder - replaced [A-Za-z0-9] with \w
 # D. Gilder - replaced s/\w+\s\[.+\\\]:\s.*//; with s/\w+\s\[.+\\\]:\s.*\n//;
 # D. Gilder - added code to handle -r argument
 #
 die "Please specify <fromfile> <tofile> and <users to keep>" unless
    ($#ARGV >= 1);
$False = (1==0);
$True  = (1==1);
 my %grade_rank = (
 "9p" => 48,
 "8p" => 47,
 "7p" => 46,
 "6p" => 45,
 "5p" => 44,
 "4p" => 43,
 "3p" => 42,
 "2p" => 41,
 "1p" => 40,
 "9d" => 39,
 "8d" => 38,
 "7d" => 37,
 "6d" => 36,
 "5d" => 35,
 "4d" => 34,
 "3d" => 33,
 "2d" => 32,
 "1d" => 31,
 "1k" => 30,
 "2k" => 29,
 "3k" => 28,
 "4k" => 27,
 "5k" => 26,
 "6k" => 25,
 "7k" => 24,
 "8k" => 23,
 "9k" => 22,
 "10k" => 21,
 "11k" => 20,
 "12k" => 19,
 "13k" => 18,
 "14k" => 17,
 "15k" => 16,
 "16k" => 15,
 "17k" => 14,
 "18k" => 13,
 "19k" => 12,
 "20k" => 11,
 "21k" => 10,
 "22k" => 9,
 "23k" => 8,
 "24k" => 7,
 "25k" => 6,
 "26k" => 5,
 "27k" => 4,
 "28k" => 3,
 "29k" => 2,
 "30k" => 1,
 "9d?" => 0,
 "8d?" => 0,
 "7d?" => 0,
 "6d?" => 0,
 "5d?" => 0,
 "4d?" => 0,
 "3d?" => 0,
 "2d?" => 0,
 "1d?" => 0,
 "1k?" => 0,
 "2k?" => 0,
 "3k?" => 0,
 "4k?" => 0,
 "5k?" => 0,
 "6k?" => 0,
 "7k?" => 0,
 "8k?" => 0,
 "9k?" => 0,
 "10k?" => 0,
 "11k?" => 0,
 "12k?" => 0,
 "13k?" => 0,
 "14k?" => 0,
 "15k?" => 0,
 "16k?" => 0,
 "17k?" => 0,
 "18k?" => 0,
 "19k?" => 0,
 "20k?" => 0,
 "21k?" => 0,
 "22k?" => 0,
 "23k?" => 0,
 "24k?" => 0,
 "25k?" => 0,
 "26k?" => 0,
 "27k?" => 0,
 "28k?" => 0,
 "29k?" => 0,
 "30k?" => 0,
 "-" => 0,
 "?" => 0,
    );
$FromFile = shift;
$ToFile = shift;
$KeepPlayers = $False;
@PlayersToKeep = ();
$MinimumRank = "?";
$UseMinimumRank = $False;

 while ( $ARGV = shift )
{
     if ( $ARGV eq "-u" )
     {
         $PlayersToKeep[$#PlayersToKeep+1] = shift or die
	     "-u specified without username";
     }
     elsif ( $ARGV eq "-r" )
     {
         $MinimumRank = shift or die "-r specified without rank";
         $UseMinimumRank = $True;
     }
     elsif ( $ARGV eq "-pl" )
     {
         $KeepPlayers = $True;
     }
}

open ( SGFFILE, "<$FromFile" ) or die "Unable to open file $FromFile";
open ( TOFILE, ">$ToFile" ) or die "Unable to open file $ToFile";

 while (<SGFFILE>)
{
     if ( $KeepPlayers )
     {
         if ( /PW\[(\w+)\]/ )
         {
             $PlayersToKeep[$#PlayersToKeep+1] = $1;
         }
         if ( /PB\[(\w+)\]/ )
         {
             $PlayersToKeep[$#PlayersToKeep+1] = $1;
         }
     }
     if ( /(\w+)\s\[(.+)\\\]:\s+(.*)/ )
     {
         $Name = $1;
         $Rank = $2;
  # $Comment = $3;
         $KeepComment = $False;
         foreach $User (@PlayersToKeep)
         {
             if ( $User eq $Name )
             {
                 $KeepComment = $True;
             }
         }
         if ( $UseMinimumRank )
         {
             if ( $grade_rank { $Rank } >= $grade_rank { $MinimumRank } )
             {
                 $KeepComment = $True;
             }
         }
         if ( not $KeepComment )
         {
             s/\w+\s\[.+\\\]:\s.*\n//;
         }
     }
     print TOFILE;
}
close SGFFILE;
close TOFILE;
