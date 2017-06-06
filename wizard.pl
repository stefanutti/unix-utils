#!/usr/bin/perl -w
###
### Perl script that replaces placeholders in text files
###
### Placeholder format: #[Options]{Description[:Default Value][#filter[#filter]...]}
### Options: 
###   e: no echo
###   p: print the line before asking for the value
###   c: asks for confirmation (e.g.: passwords)
###
### Available filters:
###   tibemsadmin_mangle: Mangles password with "tibemsadmin -mangle"
###   tolower, toupper 
###   
### Examples:
###   #{Insert simple value:default value}
###   #{Insert simple value:default value#toupper}
###   #ep{Insert password}
###   #ep{Insert tibco password#tibemsadmin_mangle}


use strict;
use File::Copy;

sub readvalue();
sub trim($);
sub get_placeholder_values(\@);
sub make_substitutions(\@);
sub confirm($$);

### Placeholder filters
sub tibemsadmin_mangle($);
sub toupper($);
sub tolower($);

my $placeholder_regex = "#([epc]*){([^:#}]+)(:([^}#]+))?(#([^}]+))?}";
my $placeholder_filter_regex = "#?([^#]+)";
my (%values, %old_files, %new_files)=((),(),());

#Declared option handlers
sub handle_no_echo_opt();
sub handle_print_opt();
sub clean_no_echo_opt();

my %opt_active;
my %opt_handlers = (    
    'e' => \&handle_no_echo_opt,
    'p' => \&handle_print_opt,
);
my %opt_cleaners = (    
    'e' => \&clean_no_echo_opt,
);


## Read all files and get placeholder values
foreach my $file (@ARGV) {
  open(DAT, $file) or die("Could not open file! File: ".$file);
  my @raw_data=<DAT>;
  close(DAT);
  $old_files{$file}=\@raw_data;
  get_placeholder_values(@raw_data);
}  


## Make Substitutions and get new files
while (my ($file_name, $raw_data) = each(%old_files)){ 
  my $newfile = make_substitutions(@$raw_data);
  $file_name=~s/(.*)\..*/$1/;
  $new_files{$file_name}=$newfile; 
}

## Write new files
while (my ($newfile_name, $newfile) = each(%new_files)){
  open FH, ">$newfile_name" or die "can't open '$newfile_name' for writing: $!"; 
  print FH $_ foreach @$newfile;
  close FH; 
}

sub get_placeholder_values(\@) {
  my $raw_data = shift;
  my $sub;
  
  foreach my $string (@$raw_data) {
    while ($string =~ m/$placeholder_regex/go) {
      my ($opts, $name) = ($1, trim($2));

      unless (my $previous = $values{$name}) {
        #Handle Options
        foreach (split //,$opts) {
          $opt_active{$_}=1;
          $sub->($string) if $sub = $opt_handlers{$_};
        }
        
        #Prompt message
        my ($subst, $default);
				$default = trim($4) if $4;
			  my $msg = "Enter value for \"".$name."\"";
			  $msg .= " [$default]" if ($default); 
			  $msg .= ": ";

        #Ask for the value. Keeps asking if no default is present and no value is given from input
        do {
          print $msg;
          $subst = $default unless $subst = readvalue();
        } while (not $subst);
        
        $subst=confirm($subst,$msg) if $opt_active{'c'};

        #Save new string and remember the value
        $values{$name}=$subst;
        
        #clean options
        foreach (split //,$opts) {
          delete $opt_active{$_};
          $sub->() if $sub = $opt_cleaners{$_};
        }
      } 
    }
  }
}

sub make_substitutions(\@) {
  my $raw_data = shift;
  my @newfile = ();

  foreach my $string (@$raw_data) {
    my $newstring = $string;
    while ($string =~ m/$placeholder_regex/go) {
      my $name = trim($2);
      my $previous = $values{$name};
      
      #Call filter subroutines if present
      if (my $filters=$6) {
        while ($filters =~ m/$placeholder_filter_regex/g) {
          my $func = \&{trim($1)};
          $previous = &$func($previous);
        } 
      }

      $newstring =~ s/$&/$previous/;
    }
    push(@newfile,$newstring);
    
  }

  return \@newfile;
}


##### Option Handlers #####

sub handle_no_echo_opt() {
  system "stty -echo"
}

sub clean_no_echo_opt() {
  system "stty echo";
}

sub handle_print_opt() {
  print "--- Line to be modified:\n\t";
  print @_;
}

##### Filters #####

sub tibemsadmin_mangle($) {
  open(MANGLED,"tibemsadmin -mangle ".$_[0]."|") || die "Failed: $!\n";
  my $mangled;
  $mangled=$_ while <MANGLED>;
  chomp $mangled;
  close MANGLED;
  return $mangled;
}

sub toupper($) {
  return uc($_[0]);
}

sub tolower($) {
  return lc($_[0]);
}

#### Utils ####


sub trim($) {
  my $string = shift;
  $string =~ s/^\s+//;
  $string =~ s/\s+$//;
  return $string;
}

sub readvalue() {
  chomp(my $retval = <STDIN>);
  print "\n" if $opt_active{'e'};
  return $retval;
}

sub confirm($$) {
  my ($value,$default,$msg) = ($_[0],$_[0],$_[1]);
  
  print "Confirmation - ".$msg;
  my $confirm = readvalue();
  
  while(not ($confirm eq $value)) {
  	 print "--- Typed values don't match. Please retry\n";
     do {
       print $msg;
       $value = $default unless $value = readvalue();
     } while (not $value);
     
     print "Confirmation - ".$msg;
     $confirm = readvalue();
  }
  
  return $value;
}

