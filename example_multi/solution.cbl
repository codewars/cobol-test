       identification division.
       program-id. div2.
       data division.
       linkage section.
       01  n       pic 9(10).
       01  res     pic 9(10)v9(2).

       procedure division using n res.
           compute res = n / 2
           goback.
       end program div2.

       program-id. mul2.
       data division.
       linkage section.
       01  n       pic 9(10).
       01  res     pic 9(10)v9(2).

       procedure division using n res.
           compute res = n * 2
           goback.
       end program mul2.
