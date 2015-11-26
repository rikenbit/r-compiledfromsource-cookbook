require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::JUnitReporter.new(reports_dir="/tmp/result/junit")]

describe 'check R version' do

  it "check R version" do
    system('echo "q()" > /tmp/showversion.R')
    system('/usr/local/R-devel/bin/R CMD BATCH /tmp/showversion.R')
    assert system('grep "R Under development (unstable)" showversion.Rout'), 'R version is not expected version. devel version is updated'
  end
end
