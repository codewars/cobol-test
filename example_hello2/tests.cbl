       id division.
       program-id. tests.

       data division.
       working-storage section.
       01  all-chars   pic a(60) value 
           'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.
       01  i           pic 9(2).
       01  j           pic 9(2).
       01  n           pic 9(2).
       01  expected.
           05  len     pic 9(4).
           05  chars   pic x(50).
       01  arg.
           05  len     pic 9(4).
           05  chars   pic a(20).
       01  result.
           05  len     pic 9(4).
           05  chars   pic x(50).

       procedure division.
      * Fixed Tests
           testsuite 'Fixed Tests.'.
           testcase 'Testing: ' 'Jane Doe'.
           move 'Jane Doe' to chars of arg
           move length of 'Jane Doe' to len of arg
           move 'Hello, Jane Doe!' to chars of expected
           move length of 'Hello, Jane Doe!' to len of expected
           perform dotest

           testcase 'World'.
           move 'World' to chars of arg
           move length of 'World' to len of arg
           move 'Hello, World!' to chars of expected
           move length of 'Hello, World!' to len of expected
           perform dotest
           
      * Failing Tests     
           testsuite "Failing Tests".
           testcase 'John Doe (incorrect expected length)'.
           move 'John Doe' to chars of arg
           move length of 'John Doe' to len of arg
           move 'Hello, John Doe!' to chars of expected
           perform dotest

           testcase 'John (incorrect argument length)'.
           move 'John' to chars of arg
           move 'Hello, John!' to chars of expected
           move length of 'Hello, John!' to len of expected
           perform dotest

      * Random Tests
           testsuite "Random Tests".
           perform set-random-seed
           perform 5 times
               perform random-string
               testcase 'Testing ' '"', chars of arg(1:len of arg), '"'.
               initialize result
               initialize expected
               string 'Hello, ' 
                      chars of arg(1:len of arg)
                      '!'
                   into chars of expected
               compute len of expected = len of arg + 8
               perform dotest
           end-perform

           end tests.

       random-string.
           compute n = function random() * 19 + 1
           move n to len of arg
           perform varying i from 1 by 1 until i > n
               compute j = function random() * 
                               function length(all-chars) + 1
               move all-chars(j:1) to chars of arg(i:1)
           end-perform
           .
      
       dotest.
           initialize result
           call 'hello' using arg result
           if len of result <> len of expected
               string 'Strings have different lengths' 
                      line-feed
                      'expected: ' len of expected 
                      line-feed
                      'actual:   ' len of result
                   into assertion-message
               perform assert-false
           end-if
           if len of result = 0 and len of expected = 0 then
               perform assert-true
           else
               expect chars of result(1:function min(len of result,
                                      function length(chars of result))) 
                      to be 
                      chars of expected(1:len of expected).
           end-if
           .

       end program tests.
