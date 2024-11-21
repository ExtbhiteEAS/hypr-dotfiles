import argparse
from styles import *

parser = argparse.ArgumentParser()
parser.add_argument(
    '-p', '--path',
    type = str,
    help = 'Set path to current wallpaper image',
    required = True
)

args = parser.parse_args()

if args.path is None or args.path == '':
    print('Path is didn\'t set, please set it')
else:
    ThemeChanger().waypaper(args.path)