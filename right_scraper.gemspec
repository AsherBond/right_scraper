# -*-ruby-*-
# Copyright: Copyright (c) 2010-2011 RightScale, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# 'Software'), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'rubygems'

Gem::Specification.new do |spec|
  spec.name      = 'right_scraper'
  spec.version   = '3.0.2'
  spec.authors   = ['Graham Hughes', 'Raphael Simon']
  spec.email     = 'raphael@rightscale.com'
  spec.homepage  = 'https://github.com/rightscale/right_scraper'
  spec.platform  = Gem::Platform::RUBY
  spec.summary   = 'Download and update remote repositories'
  spec.has_rdoc = true
  spec.rdoc_options = ["--main", "README.rdoc", "--title", "RightScraper"]
  spec.extra_rdoc_files = ["README.rdoc"]
  spec.required_ruby_version = '>= 1.8.7'
  spec.rubyforge_project = %q{right_scraper}
  spec.require_path = 'lib'

  spec.add_dependency('json', '>= 1.4.5')
  spec.add_dependency('git', '>= 1.2.5')
  spec.add_dependency('libarchive', '>= 0.1.1')
  spec.add_dependency('right_aws', '>= 2.0')
  spec.add_dependency('process_watcher', '~> 0.3')

  spec.requirements << 'libarchive, 2.8.4'
  spec.requirements << 'curl command line client'
  spec.requirements << 'Subversion command line client'

  spec.add_development_dependency('rspec')
  spec.add_development_dependency('flexmock')
  spec.add_development_dependency('rtags')

  spec.description = <<-EOF
  RightScraper provides a simple interface to download and keep local copies of remote
  repositories up-to-date using the following protocols:
    * git: RightScraper will clone then pull repos from git
    * SVN: RightScraper will checkout then update SVN repositories
    * tarballs: RightScraper will download, optionally uncompress and expand a given tar file
  On top of retrieving remote repositories, right_scraper also include "scrapers" that
  will analyze the repository content and instantiate "resources" as a result. Currently
  supported resources are Chef cookbooks and RightScale workflow definitions.
EOF

  candidates = Dir.glob("{lib,spec}/**/*") +
               ["LICENSE", "README.rdoc", "Rakefile", "right_scraper.gemspec", "Gemfile", "right_scraper.rconf"]
  spec.files = candidates.sort
end
