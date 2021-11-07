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

def preprocess(text):
    return text

def main():
    args = parse_args()
    with open(args.input, 'r') as f:
        text = preprocess(f.read())
    with open(args.output, 'w') as f:
        f.write(text)

main()