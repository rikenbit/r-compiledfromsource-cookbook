default[:r_compiledfromsource][:install_directory]      = "/usr/local/R-devel"
default[:r_compiledfromsource][:sourceurl]      = "http://cran.r-project.org/src/base-prerelease/R-latest.tar.gz"
default[:r_compiledfromsource][:owner]      = "vagrant"
default[:r_compiledfromsource][:group]      = "vagrant"
default[:r_compiledfromsource][:configure_options]      = "--without-recommended-packages --enable-R-shlib --with-x=no --prefix="+node[:r_compiledfromsource][:install_directory]
