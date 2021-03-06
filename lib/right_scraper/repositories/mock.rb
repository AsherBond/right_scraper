#--
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
#++
require File.expand_path(File.join(File.dirname(__FILE__), 'base'))

module RightScraper
  module Repositories
    # A "repository" that is just there for testing.  This class is not
    # loaded by default.
    class Mock < Base
      # Create a new mock repository.
      def initialize
        @repo_type = :mock
      end
      # (String) Type of the repository, here 'download'.
      attr_accessor :repo_type

      # (String) Optional, tag or branch of repository that should be downloaded
      attr_accessor :tag

      # (String) Optional, username
      attr_accessor :first_credential

      # (String) Optional, password
      attr_accessor :second_credential

      # Unique representation for this repo, should resolve to the same string
      # for repos that should be cloned in same directory
      #
      # === Returns
      # res(String):: Unique representation for this repo
      def to_s
        res = "mock #{url}:#{tag}"
      end

      # (Base class) Appropriate class for scraping this sort of
      # repository.
      def scraper
        @@scraper || raise("Scraper for mocks isn't defined yet")
      end

      # Set the correct sort of scraper to use for mock repositories.
      def self.scraper=(scraper)
        @@scraper = scraper
      end

      # Add this repository to the list of available types.
      @@types[:mock] = RightScraper::Repositories::Mock
    end
  end
end
