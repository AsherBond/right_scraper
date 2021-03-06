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

module RightScraper
  module Repositories
    # A repository that is just an archive file hanging off a
    # web server somewhere.  This version uses a command line curl to
    # download the archive, and command line tar to extract it.
    class Download < Base
      # (String) Type of the repository, here 'download'.
      def repo_type
        :download
      end

      # (String) Optional, username
      attr_accessor :first_credential

      # (String) Optional, password
      attr_accessor :second_credential

      # (String) Optional, SHA of contents
      attr_accessor :tag
      alias_method :revision, :tag

      # Unique representation for this repo, should resolve to the same string
      # for repos that should be cloned in same directory
      #
      # === Returns
      # res(String):: Unique representation for this repo
      def to_s
        res = "download #{url}"
      end

      # Convert this repository to a URL in the style of resource URLs.
      #
      # === Returns
      # URI:: URL representing this repository
      def to_url
        add_users_to(url, first_credential, second_credential)
      end

      # Return a unique identifier for this revision in this repository.
      #
      # === Returns
      # String:: opaque unique ID for this revision in this repository
      def checkout_hash
        digest("#{PROTOCOL_VERSION}\000#{repo_type}\000#{url}\000#{tag}")
      end

      # Instantiate retriever for this kind of repository
      #
      # === Options
      # <tt>:max_bytes</tt>:: Maximum number of bytes to read
      # <tt>:max_seconds</tt>:: Maximum number of seconds to spend reading
      # <tt>:basedir</tt>:: Destination directory, use temp dir if not specified
      # <tt>:logger</tt>:: Logger to use
      #
      # === Return
      # retriever(Retrivers::Download):: Retriever for this repository
      def retriever(options)
        RightScraper::Retrievers::Download.new(self, options)
      end


      # Add this repository to the list of available types.
      @@types[:download] = RightScraper::Repositories::Download

    end
  end
end
