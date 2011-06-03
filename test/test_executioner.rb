require 'helper'

class TestExecutioner < Test::Unit::TestCase
  context "Executioner with MyWorker" do
    setup do
      puts "running setup"
      @executioner = Executioner.execute(MyWorker.new, :should_kill_me?)
      puts "got #{@executioner.child_pid}"
    end

    should "execute the work and kill the worker" do
      assert @executioner.child_pid != nil, "no process id"
      sleep 6
      assert @executioner.is_dead?, "is not killed"
    end

  end
end

class MyWorker
  
  def execute!
    $working = true
    1.upto(10) {|i| puts "#{Process.pid}: #{i}"; sleep 1}
  end
  
  def should_kill_me?
    return true
  end
end
