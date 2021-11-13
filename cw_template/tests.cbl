       identification division.
       program-id. tests.

       data division.
       working-storage section.
       01  arg1        pic s9(5).
       01  arg2        pic s9(5).
       01  arg1-str    pic -9(5).
       01  arg2-str    pic -9(5).
       01  result      pic s9(6).
       01  expected    pic s9(6).

       procedure division.
      * Fixed Tests
           testsuite 'Fixed Tests'.
           testcase 'Test 1'.
           move 3 to arg1
           move -5 to arg2
           call 'solution' using 
               by content arg1 arg2 
               by reference result
           expect result to be -2.0.

      * Random Tests
           testsuite "Random Tests".
           perform set-random-seed
           perform 5 times
               compute arg1 = function random() * 199999 - 99999
               compute arg2 = function random() * 199999 - 99999
               move arg1 to arg1-str
               move arg2 to arg2-str
               testcase 'Testing ' arg1-str ' + ' arg2-str.
               add arg1 to arg2 giving expected
               call 'solution' using 
                   by content arg1 arg2
                   by reference result
               expect result to be expected.
           end-perform

           end tests.

       end program tests.
