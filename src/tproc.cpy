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
               accept end-time from time
               move group-start-time to start-time
               perform compute-time-diff
               display "<COMPLETEDIN::>" time-diff-display
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
               accept end-time from time
               move test-start-time to start-time
               perform compute-time-diff
               display "<COMPLETEDIN::>" time-diff-display
           end-if
           set test-case-closed to true
           .

       compute-time-diff.
           compute time-difference =
               (hours of end-time - hours of start-time) * 3600000 +
               (minutes of end-time - minutes of start-time) * 60000 +
               (seconds of end-time - seconds of start-time) * 1000 +
               (mseconds of end-time - mseconds of start-time) * 10
           if time-difference < -10000
               add 86400000 to time-difference
           end-if
           move time-difference to time-diff-display
           .
