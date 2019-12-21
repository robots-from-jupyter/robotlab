import re

ANSI_ESCAPE = re.compile(r'(?:\x1B[@-_]|[\x80-\x9F])[0-?]*[ -/]*[@-~]')


def decolorize(line):
    return ANSI_ESCAPE.sub('', line)
