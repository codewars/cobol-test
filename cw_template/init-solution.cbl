       identification division.
       program-id. solution.

       data division.
       working-storage section.
       linkage section.
       01  arg1        pic s9(5).
       01  arg2        pic s9(5).
       01  result      pic s9(6).

       procedure division using arg1 arg2 result.
           compute result = 0
           goback.
       end program solution.