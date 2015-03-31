#
r_owner = node[:r_compiledfromsource][:owner]
r_group = node[:r_compiledfromsource][:group]

#
case node.platform
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
when "ubuntu"

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
(tar zxvf #{r_source_file} --strip=1)
(chown -R #{r_owner}:#{r_group} .)
(./configure --without-recommended-packages --enable-R-shlib --with-x=no --prefix=#{install_directory})
(./tools/rsync-recommended)
(./tools/link-recommended)
(make)
(bin/R CMD INSTALL src/library/Recommended/MASS.tgz)
(make check)
(make install)
(chown -R #{r_owner}:#{r_group} #{install_directory})
CODE
  cwd work_directory
  action :run
end
