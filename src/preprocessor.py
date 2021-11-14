import os
import argparse
import re

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', '-o', default=None)
    parser.add_argument('input')
    
    args = parser.parse_args()
    if not args.output:
        name, ext = os.path.splitext(args.input)
        args.output = f'{name}-out{ext}'

    return args

def insert_after(pattern, text, s):
    m = re.search(pattern, text, flags=re.I | re.MULTILINE)
    if m:
        pos = m.end()
        return text[:pos] + '\n       ' + s + '\n' + text[pos:]

def format(s):
    return '\n'.join(' ' * 11 + line for line in s.split('\n'))

TEST_GROUP = format(r'''initialize group-title
string \1
  into group-title
perform begin-test-group''')

TEST_CASE = format(r'''initialize test-case-title
string \1
  into test-case-title
perform begin-test-case''')

# Don't call assert-true or assert-false because it is not straightforward
# to create an assertion message for negative numbers
EXPECT = format(r'''if \1 = 
    \2
  display line-feed-char '<PASSED::>Test Passed'
else
  display line-feed-char '<FAILED::>'
    'expected: ' \2
    line-feed 
    'actual: ' \1
end-if''')

def preprocess(text):
    flags = re.I | re.MULTILINE
    pat_string1 = r"[zZnNxXgG]?'[^']+'"
    pat_string2 = r'[zZnNxXgG]?"[^"]+"'
    pat_number = r'[+-]?\d+(?:\.\d*(?:[eE][+-]?\d+)?)?'
    pat_other = r'[-a-zA-Z0-9_:()]+'
    pat_value = f'(?:{pat_string1}|{pat_string2}|{pat_number}|{pat_other})'
    pat_sep = r'[\s;,]'
    s = insert_after(r'^\s*working-storage\s+section\s*\.', text, 'copy ddtests.')
    if not s:
        s = insert_after(r'^\s*data\s+division\s*\.', text, 'working-storage section. copy ddtests.')
        s = s or text
    s = re.sub(r'^\s*end\s+tests\s*\.', '       copy pdtests.', s, flags=flags)
    s = re.sub(rf'^\s*testsuite\s+((?:{pat_value}{pat_sep}*)+)\.', TEST_GROUP, s, flags=flags)
    s = re.sub(rf'^\s*testcase\s+((?:{pat_value}{pat_sep}*)+)\.', TEST_CASE, s, flags=flags)
    s = re.sub(rf'^\s*expect\s+((?:{pat_value}{pat_sep}*)+?)to\s+be\s+((?:{pat_value}{pat_sep}*)+)\.', EXPECT, s, flags=flags)

    return s

def main():
    args = parse_args()
    with open(args.input, 'r') as f:
        text = preprocess(f.read())
    with open(args.output, 'w') as f:
        f.write(text)

main()