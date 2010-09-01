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

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'logger'))

module RightScale
  module Loggers
    # A very noisy logger, useful for debugging.
    class NoisyLogger < Logger
      # Initialize the logger, setting the current operation depth to 1.
      def initialize(*args)
        super
        @pending = []
      end
      # Begin an operation that merits logging.  Will write the
      # details to the log, including a visual indicator of how many
      # nested operations are currently pending.
      #
      # === Parameters
      # type(Symbol):: operation type identifier
      # explanation(String):: optional explanation
      def operation(type, explanation="")
        begin
          @pending.push [type, explanation]
          debug("#{depth_str} begin #{immediate_context}")
          result = super
          debug("#{depth_str} close #{immediate_context}")
          @pending.pop
          return result
        rescue
          debug("#{depth_str} abort #{immediate_context}")
          @pending.pop
          raise
        end
      end

      def note_error(exception, type, explanation="")
        recordedtype, recordedexplanation = @pending[-1]
        if recordedtype != type || recordedexplanation != explanation
          @pending.push [type, explanation]
        end
        error("Saw #{exception} during #{context}")
        if recordedtype != type || recordedexplanation != explanation
          @pending.pop
        end
      end

      private
      def depth_str
        '>' * @pending.size
      end

      def context
        @pending.reverse.map {|pair| contextify(pair)}.join(" in ")
      end

      def immediate_context
        contextify(@pending[-1])
      end

      def contextify(pair)
        type, explanation = pair
        "#{type}#{maybe_explain(explanation)}"
      end
    end
  end
end