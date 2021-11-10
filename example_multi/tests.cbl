       id division.
       program-id. tests.

       data division.
       working-storage section.
       01  i           pic 9(8).
       01  n           pic 9(10).
       01  n-disp      pic z(9)9.
       01  result      pic 9(10)v9(2).
       01  expected    pic 9(10)v9(2).

       procedure division.
           testsuite 'Fixed Tests'.
           move 1 to n
           move 0.5 to expected
           perform dotest-div

           move 2 to expected
           perform dotest-mul

           testsuite 'Random Tests'.
           perform set-random-seed.
           perform varying i from 1 by 1 until i > 5
               compute n = function random() * 20
               compute expected = n * 2
               perform dotest-mul
               compute expected = n / 2
               perform dotest-div
           end-perform
           
           end tests.
       
       dotest-div.
           move n to n-disp
           testcase "div2: n = " function trim(n-disp).
           call 'div2' using by content n by reference result
           expect result to be expected
           .

       dotest-mul.
           move n to n-disp
           testcase "mul2: n = " function trim(n-disp).
           call 'mul2' using by content n by reference result
           expect result to be expected
           .

       end program tests.
