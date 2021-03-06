# frozen_string_literal: true

module Entangler
  module Executor
    class Slave < Base
      def initialize(base_dir, opts = {})
        super(base_dir, opts)
        STDIN.binmode
        STDOUT.binmode
        STDIN.sync = true
        STDOUT.sync = true

        @remote_reader = STDIN
        @remote_writer = STDOUT
        $stderr.reopen(File.join(Entangler::Logger.log_file_path(base_dir, 'entangler.err')), 'w')
      end
    end
  end
end
