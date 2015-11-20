# update /etc/apt/sources.list at compile time
case node.platform
when "ubuntu"
  e = execute "sed -i 's/us.archive.ubuntu.com/ftp.jaist.ac.jp/' /etc/apt/sources.list ; apt-get update" do
    action :nothing
  end

  e.run_action(:run)
end
