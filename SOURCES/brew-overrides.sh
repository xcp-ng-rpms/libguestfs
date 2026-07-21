#!/bin/bash -

# This script is used when we build libguestfs from brew, as sometimes
# we require packages which are not available in the current version
# of RHEL.  Normally these updated packages would be released along
# with libguestfs in the next RHEL, although unfortunately sometimes
# that doesn't happen (eg. RHBZ#1199605).

set -x

pkgs="
  augeas-1.4.0-5.el7
  hivex-1.3.10-6.9.el7
  ocaml-4.05.0-6.el7
  ocaml-camlp4-4.05.0-0.4.gitfc12d8c7.el7
  ocaml-fileutils-0.4.4-9.el7
  ocaml-findlib-1.7.3-7.el7
  ocaml-gettext-0.3.7-1.el7
  ocaml-srpm-macros-5-2.el7
  supermin-5.1.19-1.el7
"

for pkg in $pkgs ; do
    brew tag-pkg rhel-7.5-temp-override $pkg
done

for pkg in $pkgs ; do
    brew wait-repo rhel-7.5-build --build=$pkg
done
