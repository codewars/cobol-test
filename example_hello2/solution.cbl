       id division.
       program-id. hello.

       data division.
       working-storage section.
       linkage section.
       01  arg.
           05  len     pic 9(4).
           05  chars   pic a(20).
       01  result.
           05  len     pic 9(4).
           05  chars   pic x(50).

       procedure division using arg result.
           string 'Hello, ' delimited by size
                  chars of arg(1:len of arg)
                  '!'
             into chars of result
           compute len of result = length of 'Hello, !' + len of arg
           goback.
       end program hello.
