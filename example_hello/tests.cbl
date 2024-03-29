       id division.
       program-id. tests.

       data division.
       working-storage section.
       copy preloaded.
       01  chars       pic a(60) value 
           'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.
       01  i           pic 9(2).
       01  j           pic 9(2).
       01  len         pic 9(2).
       01  arg         pic a(20).
       01  result      pic x(50).
       01  expected    pic x(50).

       procedure division.
      * Fixed Tests
           testsuite 'Fixed Tests'.
           testcase 'Jane Doe'.
           move z'Jane Doe' to arg
           initialize result
           call 'hello' using arg result
           expect result to be z"Hello, Jane Doe!".

           testcase 'World'.
           move z'World' to arg
           initialize result
           display "Testing " arg
           call 'hello' using arg result
           expect result to be z'Hello, World!'.
           
      * Failing Tests     
           testsuite 
               "Failing Tests".
           testcase 'John Doe (arg is not null-terminated)'.
           move 'John Doe' to arg
           initialize result
           call 'hello' using arg result
           expect result to be z'Hello, John Doe!'.

           testcase 'John (result is not initialized before the call)'.
           move z'John' to arg
           call 'hello' using arg result
           expect result to be z'Hello, John!'.

           testcase 'Codewars (result is passed by content)'.
           move z'Codewars' to arg
           initialize result
           call 'hello' using by content arg result
           expect result to be z'Hello, Codewars!'.


      * Random Tests
           testsuite "Random Tests".
           perform set-random-seed
           perform 5 times
               perform random-string
               testcase 'Testing ' arg.
               initialize result
               initialize expected
               call 'hello' using by content arg by reference result
               string hello delimited by size
                      arg delimited by low-value
                      z'!'
                   into expected
               expect result to be expected.
           end-perform

           end tests.

       random-string.
           move low-values to arg
           compute len = function random() * 19 + 1
           perform varying i from 1 by 1 until i > len
               compute j = function random() * 
                               function length(chars) + 1
               move chars(j:1) to arg(i:1)
           end-perform
           .

       end program tests.
