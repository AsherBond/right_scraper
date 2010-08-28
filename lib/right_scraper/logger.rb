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

require 'logger'

module RightScale
  # Very simplistic logger for scraper operations.
  class Logger < ::Logger
    def initialize(*args)
      if args.empty?
        super('/dev/null')
        self.level = ::Logger::ERROR
      else
        super
      end
    end

    # (RightScale::Repository) Repository currently being examined.
    attr_writer :repository

    # Begin an operation that merits logging.  Will call #note_error
    # if an exception is raised during the operation.
    #
    # === Parameters
    # type(Symbol):: operation type identifier
    # explanation(String):: optional explanation
    def operation(type, explanation="")
      begin
        yield
      rescue
        note_error($!, type, explanation)
        raise
      end
    end

    # Log an error, with the given exception and explanation of what
    # was going on.
    #
    # === Parameters
    # exception(Exception):: exception raised
    # type(Symbol):: operation type identifier
    # explanation(String):: optional explanation
    def note_error(exception, type, explanation="")
      error("Saw #{exception} during #{type}#{maybe_explain(explanation)}")
    end

    protected
    def maybe_explain(explanation)
      if explanation
        ": #{explanation}"
      else
        ""
      end
    end
  end
end
