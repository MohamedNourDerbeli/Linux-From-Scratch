#!/bin/bash

# Change into the LFS/sources directory
cd $LFS/sources

# Print a message to indicate that Perl is being extracted
echo "Extracting Perl"

# Extract the Perl tarball using tar with verbose and Jneustadt flags
tar -xvf perl-5.38.2.tar.xz

# Change into the extracted Perl directory
cd $LFS/sources/perl-5.38.2

# Run the Perl Configure script with the following options:
# -des: enable dynamic loading of extensions
# -Dprefix=/usr: set the installation prefix to /usr
# -Dvendorprefix=/usr: set the vendor installation prefix to /usr
# -Duseshrplib: use a shared libperl
# -Dprivlib=/usr/lib/perl5/5.38/core_perl: set the private library directory
# -Darchlib=/usr/lib/perl5/5.38/core_perl: set the architecture-dependent library directory
# -Dsitelib=/usr/lib/perl5/5.38/site_perl: set the site library directory
# -Dsitearch=/usr/lib/perl5/5.38/site_perl: set the site architecture-dependent library directory
# -Dvendorlib=/usr/lib/perl5/5.38/vendor_perl: set the vendor library directory
# -Dvendorarch=/usr/lib/perl5/5.38/vendor_perl: set the vendor architecture-dependent library directory
sh Configure -des                                        \
             -Dprefix=/usr                               \
             -Dvendorprefix=/usr                         \
             -Duseshrplib                                \
             -Dprivlib=/usr/lib/perl5/5.38/core_perl     \
             -Darchlib=/usr/lib/perl5/5.38/core_perl     \
             -Dsitelib=/usr/lib/perl5/5.38/site_perl     \
             -Dsitearch=/usr/lib/perl5/5.38/site_perl    \
             -Dvendorlib=/usr/lib/perl5/5.38/vendor_perl \
             -Dvendorarch=/usr/lib/perl5/5.38/vendor_perl

# Compile Perl
make

# Install Perl
make install

# Change back into the LFS/sources directory
cd $LFS/sources

# Remove the extracted Perl directory
rm -rf perl-5.38.2
