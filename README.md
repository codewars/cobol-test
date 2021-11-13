## Codewars Test Framework for COBOL

### Project setup

`src` contains the preprocessor `preprocessor.py` and two copybooks `tdata.cpy` and `tproc.cpy` which are imported by the preprocessed test code.

All COBOL projects contain the following files: `solution.cbl` and `tests.cbl`. `preloaded.cpy` is an optional copybook.

### Running examples

```
python3 src/preprocessor.py example_hello/tests.cbl
```

This command creates `example_hello/tests-out.cbl`.

```
cobc -x -std=ibm -O2 -fstatic-call -ffold-copy=lower -I src -I example_hello -o out example_hello/tests-out.cbl example_hello/solution.cbl
```

This command compiles the source code and creates the executable `out`. The following options are used:
- `-x`: build an executable program
- `-std=ibm`: use warnings/features for the IBM COBOL (alternatively, `-std=ibm-strict` may be used but it lacks many useful intrinsic functions such as `trim`, `abs`).
- `-fstatic-call`: all literal function calls are static.
- `-ffold-copy=lower`: all copybook file names are converted to lower-case. So it is possible to write `copy preloaded` or `COPY PRELOADED`.
- `-I`: the path to copybooks. 
- `-o`: the name of the output executable file.

```
./out
```

The script `run` executes all these commands automatically:
```
./run example_hello
```

### Test code

All statements listed below (except those which start with `perform`) must begin on a separate line.

#### `testsuite (identifier | literal)+.`
Starts a group of tests. Examples:
```
testsuite 'Group 1'.
testsuite 'Group ' n.
```
Note: the period at the end is mandatory. This period does not affect the statement scope. The maximum group title length is 100 characters.

#### `testcase (identifier | literal)+.`
Starts a test case. Examples:
```
testcase 'Test 1'.
testcase 'Testing n = ' n.
```
Note: the period at the end is mandatory. This period does not affect the statement scope. The maximum test case title length is 100 characters.

#### `expect (identifier | literal) to be (identifier | literal).`
Compares the first indentifier with the second identifier (or literal) and reports a failure if they are different. Examples:
```
expect result to be expected.
expect result to be '1. Hello, World!'.
expect field1 of result to be field1 of expected.
expect result(3) to be 1.0.
```
Note: the period at the end is mandatory. This period does not affect the statement scope.

#### `end tests.`
This statement should be placed at the end of test code. It is possible to define subroutines after this statement. Note: the period at the end is mandatory.

#### `assert-true`
Prints a passed test message. Example:
```cobol
if result > 0
  move 'the result is positive' to assertion-message
  perform assert-true
end-if
```

#### `assert-false`
Prints a failed test message. Example:
```cobol
if result <= 0
  move 'the result should be positive' to assertion-message
  perform assert-false
end-if
```

#### `set-random-seed`
Initializes the random seed. The seed value is provided in the variable `random-seed`. If the value of `random-seed` is zero (the default value) then the random seed is initialized with the current time value. Example:
```
perform set-random-seed
```

#### `line-feed`
This constant can be used to display the line feed in test group or test case titles. Example:
```cobol
testcase 'Fixed test' line-feed '(case 1)'.
```
It also works with log messages:
```cobol
display 'n = ' n line-feed 'm = ' m
```
