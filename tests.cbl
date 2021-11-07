       program-id. tests.

       data division.
       working-storage section.
       01  i           pic 9(8).
       01  n           pic 9(2).
       01  result      pic 9(38).
       01  expected    pic 9(38).

       copy tdata.

       procedure division.
          *>  testsuite 'Fixed Tests'
           string 'Fixed Tests' into group-title
           perform begin-test-group

           move 0 to n
           move 1 to expected
           perform dotest

          *>  testcase 'n = 3'
           move 3 to n
           move 6 to expected
           perform dotest

          *>  testsuite 'Random Tests'
           move 'Random Tests' to group-title
           perform begin-test-group
           perform varying i from 1 by 1 until i > 3
              *>  testcase 'Random'
               compute n = function random() * 20
               compute expected = function factorial(n)
               perform dotest
           end-perform
           
          *>  end tests.
           perform end-tests
           display 'test finished'
           .
           
       
       dotest.
           string "n = " n into test-case-title
           perform begin-test-case
           call 'factorial' using by content n by reference result
          *>  expect result to be expected
           if result = expected
               move spaces to assertion-message
               perform assert-true
           else
               string 'user-msg' '<:LF:>'
                      'expected: ' expected
                      'actual: ' result '<:LF:>'
                      into assertion-message
               perform assert-false
           end-if
           .

       copy tproc.

       end program tests.
