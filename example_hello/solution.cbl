       id division.
       program-id. hello.

       data division.
       working-storage section.
       copy preloaded.
       linkage section.
       01  arg     pic a(20).
       01  result  pic x(50).

      * arg and result should be null terminated strings
       procedure division using arg result.
           string hello delimited by size
                  arg delimited by low-value '!'
                  x'00' 
             into result
           goback.
       end program hello.
