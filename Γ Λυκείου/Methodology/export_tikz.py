import json
import re

def sanitize(name):
    # Replace spaces and special characters for TikZ node names
    return re.sub(r'[^a-zA-Z0-9]', '_', name)

with open('topics.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

nodes = set()
edges = []

def add_node(n):
    if isinstance(n, list):
        for x in n:
            nodes.add(x)
    elif n:
        nodes.add(n)

def add_edge(a, b):
    if isinstance(a, list):
        for x in a:
            edges.append((x, b))
    elif a and b:
        edges.append((a, b))

for chapter in data.get("exercises", []):
    for case in chapter.get("cases", []):
        given = case.get("given")
        add_node(given)
        for topic in case.get("topics", []):
            wanting = topic.get("wanting")
            add_node(wanting)
            add_edge(given, wanting)
            for nxt in topic.get("next", []):
                add_node(nxt)
                add_edge(wanting, nxt)

# Assign positions (simple vertical layout for demonstration)
positions = {}
for idx, node in enumerate(sorted(nodes)):
    positions[node] = (0, -idx)

with open('tikz.txt', 'w', encoding='utf-8') as out:
    out.write(r"\begin{tikzpicture}[>=Stealth, node distance=2cm, every node/.style={draw,rounded corners,fill=blue!10}]" + "\n")
    for node, (x, y) in positions.items():
        out.write(f'  \\node ({sanitize(node)}) at ({x},{y}) {{{node}}};\n')
    for a, b in edges:
        out.write(f'  \\draw[->] ({sanitize(a)}) -- ({sanitize(b)});\n')
    out.write(r"\end{tikzpicture}" + "\n")