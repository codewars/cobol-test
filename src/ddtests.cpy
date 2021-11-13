       01  line-feed-char      pic x value x'0a'.
       
       01  assertion-message   pic x(200).

       01  group-title         pic x(80).
       01  group-start-time    pic 9(8).
       01  group-status        pic x value 'f'.
           88 group-open       value 't'.
           88 group-closed     value 'f'.

       01  test-case-title     pic x(80).
       01  test-start-time     pic 9(8).
       01  test-case-status    pic x value 'f'.
           88 test-case-open   value 't'.
           88 test-case-closed value 'f'.

       01  time-start.
           05 hours    pic 9(2).
           05 minutes  pic 9(2).
           05 seconds  pic 9(2).
           05 mseconds pic 9(2).

       01  time-end.
           05 hours    pic 9(2).
           05 minutes  pic 9(2).
           05 seconds  pic 9(2).
           05 mseconds pic 9(2).

       01  time-difference     pic s9(10).
       01  time-diff-display   pic z(8)9.

       01  random-seed         pic 9(10) value 0.
       01  tmp-numeric-value   pic 9(8).
