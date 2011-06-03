class Executioner
  
  def initialize(worker, request_repreive_method, options)
    @using_windows = !!((RUBY_PLATFORM =~ /(win|w)(32|64)$/) || (RUBY_PLATFORM=~ /mswin|mingw/))
    @process_class = (@using_windows ? Windows::Process : Process)
    
    @worker = worker
    @request_repreive_method = request_repreive_method
    @interval = options[:interval] || 5
    
    Thread.new { reap_condemned }
    
    @pid = @process_class.fork 
    puts "#{Process.pid}: got #{@pid} from fork()"
    if @pid
      @waiter = Thread.new do 
        @process_class.wait @pid
        @is_dead = true
      end
    else
      worker.execute!
      exit!
    end
  end
  
  def self.execute(worker, request_repreive_method, options={})
    new worker, request_repreive_method, options
  end
  
  def child_pid
    @pid
  end
  
  def is_dead?
    @is_dead ||= false
  end
  
  def reap_condemned
    until is_dead? do
      sleep @interval
      if @worker.send(@request_repreive_method)
        puts "#{Process.pid}: Killing #{@pid}"
        @process_class.kill 9, @pid
        Thread.join @waiter
      end
    end
  end
  
end