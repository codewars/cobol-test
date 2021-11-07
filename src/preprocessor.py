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

TEST_GROUP = format(r'''move spaces to group-title
string \1
  into group-title
perform begin-test-group''')

TEST_CASE = format(r'''move spaces to test-case-title
string \1
  into test-case-title
perform begin-test-case''')

EXPECT = format(r'''if \1 = \2
  move spaces to assertion-message
  perform assert-true
else
  string
    'expected: ' \2
    '<:LF:>' 
    'actual: ' \1
    into assertion-message
  perform assert-false
end-if''')

def preprocess(text):
    flags = re.I | re.MULTILINE
    ident = r'''[zZnNxXgG]?'[^']+'|[zZnNxXgG]?"[^"]+"|[-a-zA-Z0-9_]+'''
    s = insert_after(r'^\s+working-storage\s+section\s*\.', text, 'copy tdata.')
    if not s:
        s = insert_after(r'^\s+data\s+division\s*\.', text, 'working-storage section. copy tdata.')
        s = s or text
    s = re.sub(r'^\s+end\s+tests\s*\.', '       copy tproc.', s, flags=flags)
    s = re.sub(r'^\s+testsuite\s*([^.]+)\.', TEST_GROUP, s, flags=flags)
    s = re.sub(r'^\s+testcase\s*([^.]+)\.', TEST_CASE, s, flags=flags)
    s = re.sub(rf'^\s+expect\s+({ident})\s+to\s+be\s+({ident})', EXPECT, s, flags=flags)

    return s

def main():
    args = parse_args()
    with open(args.input, 'r') as f:
        text = preprocess(f.read())
    with open(args.output, 'w') as f:
        f.write(text)

main()