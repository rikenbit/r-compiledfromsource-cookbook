#!/usr/bin/env bats

@test "R development version binary is found in PATH" {
  #run which R
  run ls /usr/local/R-devel/bin/R
  [ "$status" -eq 0 ]
}
# svn trunk version
#@test "check R development version" {
#  R CMD BATCH /home/vagrant/showversion.R
#  grep "R Under" /home/vagrant/showversion.Rout
#}
