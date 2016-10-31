module Entangler
  module Executor
    module Background
      module Master
        protected
        def start_remote_slave
          require 'open3'
          ignore_opts = @opts[:ignore].map{|regexp| "-i '#{regexp.inspect}'"}.join(' ')
          @remote_writer, @remote_reader, remote_err, @remote_thread = Open3.popen3("ssh -q #{@opts[:remote_user]}@#{@opts[:remote_host]} -p #{@opts[:remote_port]} -C \"source ~/.rvm/environments/default && entangler slave #{@opts[:remote_base_dir]} #{ignore_opts}\"")
          remote_err.close
        end

        def wait_for_threads
          super
          Process.wait @remote_thread[:pid] rescue nil
        end

        def kill_off_threads
          Process.kill("INT", @remote_thread[:pid])
          super
        end
      end
    end
  end
end