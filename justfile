task1:
    swipl -l task1/main.pl

task2:
    swipl -l task2/main.pl

task3:
    swipl -l task3/main.pl

task4:
    swipl -l task4/main.pl

test:
   swipl -g run_tests -t halt task4/tests.pl

random:
    swipl -l random/main.pl
