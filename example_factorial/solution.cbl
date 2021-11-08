       id division.
       program-id. factorial recursive.

       data division.
       linkage section.
       01  n   pic 9(2).
       01  res pic 9(38).

      * procedure division using n returning res.
      * is not implemented by GnuCOBOL 
       procedure division using n res.
           move 1 to res
           if n > 1
              subtract 1 from n
              call 'factorial' using by content n by reference res
              compute res = res * (n + 1)
           end-if
           goback.
       end program factorial.
