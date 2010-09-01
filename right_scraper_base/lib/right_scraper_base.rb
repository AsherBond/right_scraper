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

# Explicitly list required files to make IDEs happy
require 'fileutils'
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'builders', 'base'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'builders', 'archive'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'builders', 'filesystem'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'builders', 'union'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'cookbook'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'logger'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'processes', 'watcher'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'process_watcher'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'repository'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'repositories', 'download'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scanners', 'base'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scanners', 'manifest'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scanners', 'metadata'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scanners', 'union'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scraper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scrapers', 'base'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scrapers', 'checkout'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scrapers', 'filesystem'))
require File.expand_path(File.join(File.dirname(__FILE__), 'right_scraper_base', 'scrapers', 'command_line_download'))
