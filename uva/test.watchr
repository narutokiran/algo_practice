#!/usr/bin/env watchr
@problem = ARGV[1]
puts @problem
def run_all_tests
  print `clear`
  puts "Tests run #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
  puts `g++ #{@problem}.cpp -o #{@problem} && ./#{@problem} < #{@problem}.in > xxx && cat xxx && echo "---------" && diff xxx #{@problem}.out && echo ok`
end

run_all_tests
watch("#{@problem}.(cpp|in|out)") { |m| run_all_tests }

@interrupted = false

# Ctrl-C
Signal.trap "INT" do
  if @interrupted
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5

    run_all_tests
    @interrupted = false
  end
end