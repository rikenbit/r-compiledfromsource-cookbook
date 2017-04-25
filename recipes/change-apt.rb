# update /etc/apt/sources.list at compile time
case node[:platform]
when "ubuntu"
  e = execute "sed -i 's/us.archive.ubuntu.com/ftp.jaist.ac.jp/' /etc/apt/sources.list ; apt-get update" do
    action :nothing
  end

  e.run_action(:run)

  # Add libpcre3 8.35 repository
  # Because ubuntu 14.04 libpcre3-dev version is old to compile latest R-devel.tar.gz
  # http://r.789695.n4.nabble.com/R-devel-no-longer-supports-Ubuntu-14-04-LTS-insufficient-PCRE-version-td4714849.html
  if node["platform_version"].to_f == 14.04
    f = execute "apt-get update; apt-get install -y software-properties-common ; sudo add-apt-repository -y ppa:edd/misc  ; apt-get update" do
      action :nothing
    end

    f.run_action(:run)
  end
end
