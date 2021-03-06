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

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'retriever_spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'scraper_helper'))
require 'git'

module Git
  class Lib
    def public_command(*args, &block)
      command(*args, &block)
    end
  end
end
module RightScraper

  # Git implementation of scraper spec helper
  # See parent class for methods headers comments
  class GitRetrieverSpecHelper < RetrieverSpecHelper
    def initialize
      super()
      FileUtils.mkdir(scraper_path)
      @git = Git.init(repo_path)
    end

    def repo
      RightScraper::Repositories::Base.from_hash(:display_name => "test git repo",
                                                 :repo_type => :git,
                                                 :url => repo_path)
    end

    def setup_cookbooks
      create_cookbook(repo_path, repo_content)
      commit_content(repo_path)
    end

    def setup_workflows
      create_workflow(repo_path, 'workflow', "sequence\na\nb", {})
      commit_content(repo_path)
    end

    def scraper_path
      File.join(@tmpdir, "scraper")
    end

    def commit_content(commit_message='commit')
      @git.add('.')
      @git.commit_all(commit_message)
    end

    def setup_branch(branch, new_content=nil)
      @git.branch(branch).checkout
      unless new_content.nil?
        create_file_layout(repo_path, new_content)
        @repo_content += new_content
        File.open(File.join(repo_path, 'metadata.json'), 'w') { |f|
          f.puts @repo_content.to_json
        }
        commit_content("Branch #{branch}")
      end
    end

    def setup_tag(tag)
      @git.add_tag(tag)
    end

    def delete_tag(tag)
      @git.lib.tag(['-d', tag])
    end

    def branch?(branch)
      Git.open(RightScraper::Retrievers::Base.repo_dir(scraper_path, repo)).branches.find {|b| b.name == branch}
    end

    def tag?(tag)
      Git.open(RightScraper::Retrievers::Base.repo_dir(scraper_path, repo)).tags.find {|t| t.name == tag}
    end

    def delete_branch(branch)
      @git.branch(branch).delete
    end

    def force_rebase(upstream, newbase)
      @git.lib.public_command("rebase", ["--onto", newbase, upstream])
    end

    def commit_id(index_from_last=0)
      @git.log.skip(1).first.sha
    end
  end
end
