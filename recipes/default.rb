#
r_owner = node[:r_compiledfromsource][:owner]
r_group = node[:r_compiledfromsource][:group]

#
case node[:platform]
when "centos"
  package "texlive"
  package "readline-devel"
  package "readline-devel"
  package "gcc-gfortran"
  package "rsync"
  package "zlib-devel"
  package "bzip2-devel"
  package "xz-devel"
  package "pcre-devel"
  package "libcurl-devel"
when "ubuntu"
  package "gfortran"
  # for R-devel 2015-07-16
  package "libbz2-dev"
  package "libpcre3-dev"
  package "liblzma-dev"
  package "libcurl3-gnutls-dev"
end

# install
work_directory = "#{Chef::Config[:file_cache_path]}/r-work/"
install_directory = node[:r_compiledfromsource][:install_directory]

directory work_directory do
  owner r_owner
  group r_group
  recursive true
  mode "0755"
  action :create
end

r_source_file = "R-latest.tar.gz"
r_configure_options = node[:r_compiledfromsource][:configure_options]

remote_file work_directory+r_source_file do
  source node[:r_compiledfromsource][:sourceurl]
end

execute "R patched source compile and install" do
  command <<-CODE
set -e
(tar zxf #{r_source_file} --strip=1)
(chown -R #{r_owner}:#{r_group} .)
(./configure #{r_configure_options})
(./tools/rsync-recommended)
(./tools/link-recommended)
(make)
(bin/R CMD INSTALL src/library/Recommended/MASS.tgz)
(bin/R CMD INSTALL src/library/Recommended/lattice.tgz)
(bin/R CMD INSTALL src/library/Recommended/Matrix.tgz)
(make check)
(make install)
(chown -R #{r_owner}:#{r_group} #{install_directory})
CODE
  cwd work_directory
  action :run
end
