#
# MIDDEN.SPEC --RPM build configuration for midden.
#
Summary: Midden, a heap of shell fragments.
Name: %{name}
Version: %{version}
Release: %{release}%{?dist}
License: MIT, Copyright (c) 2015 Tim Rose
URL: git@github.com:tim-rose/midden.git
Group: Development/Libraries
Buildarch: noarch
Packager: Timothy Rose <tim.rose@acm.org>
AutoReqProv: no

%description
Midden is a framework for modern shell programming.
It comprises a source-able bootstrap that defines
some shell functions, chiefly "require()", which allows
for the controlled inclusion of shell library code.

The midden library contains convenience routines for:

 * command-line options
 * configuration files
 * logging
 * and much more!
