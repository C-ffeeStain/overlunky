import re

header_files = ['../src/game_api/rpc.hpp', '../src/injected/script.hpp', '../src/game_api/entity.hpp']
api_files = ['../src/injected/script.cpp']
rpc = []
events = []
funcs = []
types = []
enums = [{'name': 'ENT_TYPE', 'vars': [{'name': 'FLOOR_BORDERTILE', 'type': '1'}, {'name': '', 'type': '...blah blah read your entities.txt...'}, {'name': 'LIQUID_STAGNANT_LAVA', 'type': '898'}]}]
replace = {
    'uint8_t': 'int',
    'uint16_t': 'int',
    'uint32_t': 'int',
    'int32_t': 'int',
    'ImU32': 'int',
    'vector': 'array',
    'wstring': 'string',
    'std::': '',
    'sol::': '',
    'void': '',
    'variadic_args va': 'int, int...'
}
comment = []
skip = False

def getfunc(name):
    for func in funcs:
        if func['name'] == name:
            return func
    return False

def rpcfunc(name):
    ret = []
    for func in rpc:
        if func['name'] == name:
            ret.append(func)
    return ret

def replace_all(text, dic):
    for i, j in dic.items():
        text = text.replace(i, j)
    return text

def print_af(lf, af):
    ret = replace_all(af['return'], replace)
    param = replace_all(af['param'], replace)
    print('### `'+lf['name']+'`')
    if param: print('#### Params: `'+param+'`')
    if ret: print('#### Returns: `'+ret+'`')
    for com in lf['comment']:
        print(('#### ' if com.startswith('Returns:') else '')+com)

for file in header_files:
    data = open(file, 'r').read().split('\n')
    for line in data:
        line = line.replace('*', '')
        s = re.search(r'{', line)
        if s:
            skip = True
        s = re.search(r'}', line)
        if s:
            skip = False
        c = re.search(r'/// ?(.*)$', line)
        if c:
            comment.append(c.group(1))
        m = re.search(r'\s*(.*)\s+([^\(]*)\(([^\)]*)', line)
        if m:
            if not skip or file.endswith('script.hpp'): rpc.append({'return': m.group(1), 'name': m.group(2), 'param': m.group(3), 'comment': comment})
        else:
            comment = []

for file in api_files:
    data = open(file, 'r').read().split('\n')
    for line in data:
        line = line.replace('*', '')
        c = re.search(r'/// ?(.*)$', line)
        if c:
            comment.append(c.group(1))
        m = re.search(r'lua\[[\'"]([^\'"]*)[\'"]\];', line)
        if m:
            events.append({'name': m.group(1), 'comment': comment})
        else:
            comment = []

for file in api_files:
    data = open(file, 'r').read().split('\n')
    for line in data:
        line = line.replace('*', '')
        a = re.search(r'lua\[[\'"]([^\'"]*)[\'"]\]\s+=\s+(.*);', line)
        b = re.search(r'lua\[[\'"]([^\'"]*)[\'"]\]\s+=\s+(.*)$', line)
        if a:
            if not getfunc(a.group(1)): funcs.append({'name': a.group(1), 'cpp': a.group(2), 'comment': comment})
            comment = []
        elif b:
            if not getfunc(b.group(1)): funcs.append({'name': b.group(1), 'cpp': b.group(2), 'comment': comment})
            comment = []
        c = re.search(r'/// ?(.*)$', line)
        if c:
            comment.append(c.group(1))

for file in api_files:
    data = open(file, 'r').read()
    data = data.replace('\n', '')
    data = re.sub(r' ', '', data)
    m = re.findall(r'new_usertype\<.*?\>\s*\(\s*"([^"]*)",([^\)]*)', data);
    for type in m:
        name = type[0]
        attr = type[1]
        attr = attr.replace('",', ',')
        attr = attr.split('"')
        vars = []
        for var in attr:
            if not var: continue
            var = var.split(',')
            vars.append({ 'name': var[0], 'type': var[1] })
        types.append({'name': name, 'vars': vars})

for file in api_files:
    data = open(file, 'r').read()
    data = data.replace('\n', '')
    data = re.sub(r' ', '', data)
    m = re.findall(r'new_enum\s*\(\s*"([^"]*)",([^\)]*)', data);
    for type in m:
        name = type[0]
        attr = type[1]
        attr = attr.replace('",', ',')
        attr = attr.split('"')
        vars = []
        for var in attr:
            if not var: continue
            var = var.split(',')
            vars.append({ 'name': var[0], 'type': var[1] })
        enums.append({'name': name, 'vars': vars})

print('## Global variables')
print("""These variables are always there to use.""")
for lf in funcs:
    if lf['name'] in ['players', 'state', 'options', 'meta']:
        print('### `'+lf['name']+'`')
        for com in lf['comment']:
            print(com)

print('## Event functions')
print("""Define these in your script to be called on an event. For example:
```
function on_level()
    toast("Welcome to the level")
end
```""")
for lf in events:
    if lf['name'].startswith('on_'):
        print('### `'+lf['name']+'`')
        for com in lf['comment']:
            print(com)

print('## Functions')
print('Note: The game functions like `spawn` use level coordinates that you can get with `get_position`. Draw functions use normalized screen coordinates from `-1.0 .. 1.0` where `0.0, 0.0` is the center of the screen.')
for lf in funcs:
    if len(rpcfunc(lf['cpp'])):
        for af in rpcfunc(lf['cpp']):
            print_af(lf, af)
    elif not (lf['name'].startswith('on_') or lf['name'] in ['players', 'state', 'options', 'meta']):
        m = re.search(r'\(([^\{]*)\)', lf['cpp'])
        param = ''
        if m:
            param = m.group(1)
            param = replace_all(param, replace)
        print('### `'+lf['name']+'`')
        if param: print('#### Params: `'+param+'`')
        for com in lf['comment']:
            print(('#### ' if com.startswith('Returns:') else '')+com)

print('## Types')
print('Using the api through these directly is kinda dangerous, but such is life. I got pretty bored writing this doc generator at this point, so you can find the variable types in the [.hpp files](https://github.com/spelunky-fyi/overlunky/tree/main/src/game_api). They\'re mostly just ints and floats.')
for type in types:
    print('### '+type['name'])
    for var in type['vars']:
        print('- `'+var['name']+'` '+var['type'])

print('## Enums')
print('Enums are like numbers but in text that\'s easier to remember. Example:')
print("""```
set_callback(function()
    if state.theme == THEME.COSMIC_OCEAN then
        x, y, l = get_position(players[1].uid)
        spawn(ENT_TYPE.ITEM_JETPACK, x, y, l, 0, 0)
    end
end, ON.LEVEL)
```""")
for type in enums:
    print('### '+type['name'])
    for var in type['vars']:
        if var['name']: print('- `'+var['name']+'` '+var['type'])
        else: print('- '+var['type'])