---
layout: post
title: Breadth-First Search, Visually
date: 2026-08-20 09:00
comments: true
external-url:
categories: Algorithms
---

Depth-first search gets all the attention because it's the one you can write in four lines with a stack, and your call stack does the bookkeeping for free. Breadth-first search asks for a little more discipline, an explicit queue, but it buys you something DFS can't give: the first time you reach a node, you've reached it by the shortest path, measured in number of edges.

## The graph

Take this small graph, six nodes, undirected:

<div class="diagram">
<svg viewBox="0 0 320 220" role="img" aria-label="An undirected graph with six nodes A through F, used to demonstrate breadth-first search starting from A">
<line x1="40" y1="30" x2="150" y2="30" class="diagram-edge"/>
<line x1="40" y1="30" x2="40" y2="120" class="diagram-edge"/>
<line x1="150" y1="30" x2="150" y2="120" class="diagram-edge"/>
<line x1="40" y1="120" x2="150" y2="120" class="diagram-edge"/>
<line x1="150" y1="120" x2="260" y2="75" class="diagram-edge"/>
<line x1="150" y1="30" x2="260" y2="75" class="diagram-edge"/>
<line x1="40" y1="120" x2="95" y2="190" class="diagram-edge"/>
<circle cx="40" cy="30" r="16" class="diagram-node"/>
<text x="40" y="35" text-anchor="middle" class="diagram-node-label">A</text>
<circle cx="150" cy="30" r="16" class="diagram-node"/>
<text x="150" y="35" text-anchor="middle" class="diagram-node-label">B</text>
<circle cx="40" cy="120" r="16" class="diagram-node"/>
<text x="40" y="125" text-anchor="middle" class="diagram-node-label">C</text>
<circle cx="150" cy="120" r="16" class="diagram-node"/>
<text x="150" y="125" text-anchor="middle" class="diagram-node-label">D</text>
<circle cx="260" cy="75" r="16" class="diagram-node"/>
<text x="260" y="80" text-anchor="middle" class="diagram-node-label">E</text>
<circle cx="95" cy="190" r="16" class="diagram-node"/>
<text x="95" y="195" text-anchor="middle" class="diagram-node-label">F</text>
</svg>
</div>

Starting a breadth-first search from $A$, the queue empties out in the order $A, B, C, D, E, F$: everything one edge away from $A$ gets visited before anything two edges away, which is exactly the guarantee the algorithm exists to provide.

## The algorithm

```python
from collections import deque

def bfs(graph, start):
    visited = {start}
    order = []
    queue = deque([start])
    while queue:
        node = queue.popleft()
        order.append(node)
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
    return order

graph = {
    "A": ["B", "C"],
    "B": ["A", "D", "E"],
    "C": ["A", "D", "F"],
    "D": ["B", "C", "E"],
    "E": ["B", "D"],
    "F": ["C"],
}

print(bfs(graph, "A"))
# ['A', 'B', 'C', 'D', 'E', 'F']
```

## Why the queue matters

Swap the queue for a stack and you've written depth-first search instead: same skeleton, different discipline about which frontier node gets explored next. The complexity is the same either way, $O(V + E)$: every vertex is enqueued once and every edge is inspected at most twice, once from each endpoint, so the work is linear in the size of the graph, not exponential in its depth. What you're paying for with BFS is the queue itself: in the worst case, a wide, shallow graph, it can hold $O(V)$ nodes at once, where DFS's recursion stack only ever holds one path's worth.
