       id division.
       program-id. tests.

       data division.
       working-storage section.
       01  n           pic 9(2).
       01  result      pic 9(38).
       01  expected    pic 9(38).

       procedure division.
           testsuite 'Fixed Tests'.
           move 0 to n
           move 1 to expected
           perform dotest

           move 3 to n
           move 6 to expected
           perform dotest

           testsuite 'Random Tests'.
           perform set-random-seed.
           perform 3 times
               compute n = function random() * 20
               compute expected = function factorial(n)
               perform dotest
           end-perform
           
           end tests.
       
       dotest.
           testcase "n = " n.
           call 'factorial' using by content n by reference result
           expect result to be expected.
           .

       end program tests.
