#--
# Copyright: Copyright (c) 2010 RightScale, Inc.
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
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'checkout_scraper_base'))
require File.expand_path(File.join(File.dirname(__FILE__), 'client'))

module RightScale
  class SvnScraper < CheckoutBasedScraper
    def exists?
      File.exists?(File.join(checkout_path, '.svn'))
    end

    def do_update
      client = SvnClient.new(@repository)
      client.with_context do |ctx|
        @logger.operation(:update) do
          ctx.update(checkout_path, @repository.tag || nil)
        end
      end
    end
    def do_checkout
      super
      client = SvnClient.new(@repository)
      client.with_context do |ctx|
        @logger.operation(:checkout_revision) do
          ctx.checkout(@repository.url, checkout_path, @repository.tag || nil)
        end
      end
    end

    def ignorable_paths
      ['.svn']
    end
  end
end
