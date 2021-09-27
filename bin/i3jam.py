import sys
import json
import re
from subprocess import run


def i3_msg(*args, mtype='command'):
    if args:
        endpart = ' "' + ' '.join(str(a) for a in args) + '"'
    else:
        endpart = ''
    runstr = f'i3-msg -t {mtype}{endpart}'
    raw_result = run(runstr, shell=True, check=True, capture_output=True)
    result = raw_result.stdout.decode('utf-8')
    return json.loads(result)


def i3_current_workspace():
    obj = i3_msg(mtype='get_workspaces')
    focused = [s for s in obj if s['focused']]
    if len(focused) != 1:
        raise Exception('Something is wrong: more than one workspace focused?')
    return focused[0]

def go_gen(f, move=False):
    n = i3_current_workspace()['num']
    new_n = f(n)
    if move:
        cmd = 'move container to workspace number {0}; workspace number {0}'
    else:
        cmd = 'workspace number {0}'
    i3_msg(cmd.format(new_n))

fs = {
    '+': (lambda n: n + 1 if n < 10 else 10),
    '-': (lambda n: n - 1 if n > 1 else 1),
}

if __name__ == '__main__':
    m = re.match(r'([+-])(:?)$', sys.argv[1])
    go_gen(fs[m.group(1)], len(m.group(2)) > 0)
