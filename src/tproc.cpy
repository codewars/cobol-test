           perform end-test-group
           goback.
       
       end-tests.
           perform end-test-group
           goback.
       
       assert-true.
           if assertion-message = spaces
               move "Test Passed" to assertion-message
           end-if
           display "<PASSED::>" assertion-message
           .

       assert-false.
           if assertion-message = spaces
               move "Test Failed" to assertion-message
           end-if
           display "<FAILED::>" assertion-message
           .

       begin-test-group.
           perform end-test-group
           accept group-start-time from time
           display "<DESCRIBE::>" group-title
           set group-open to true
           .

       end-test-group.
           perform end-test-case
           if group-open
               accept time-end from time
               move group-start-time to time-start
               perform compute-time-diff
               display "<COMPLETEDIN::>" 
                       function trim(time-diff-display)
           end-if
           set group-closed to true
           .

       begin-test-case.
           perform end-test-case
           accept test-start-time from time
           display "<IT::>" test-case-title
           set test-case-open to true
           .

       end-test-case.
           if test-case-open
               accept time-end from time
               move test-start-time to time-start
               perform compute-time-diff
               display "<COMPLETEDIN::>"
                       function trim(time-diff-display)
           end-if
           set test-case-closed to true
           .

       compute-time-diff.
           compute time-difference =
               (hours of time-end - hours of time-start) * 3600000 +
               (minutes of time-end - minutes of time-start) * 60000 +
               (seconds of time-end - seconds of time-start) * 1000 +
               (mseconds of time-end - mseconds of time-start) * 10
           if time-difference < -10000
               add 86400000 to time-difference
           end-if
           move time-difference to time-diff-display
           .

       set-random-seed.
           if random-seed = 0
               accept random-seed from time
           end-if
           compute tmp-numeric-value = function random(random-seed)
           .
