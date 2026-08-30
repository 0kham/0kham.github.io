---
layout: post
title: The Birthday Paradox
date: 2026-08-10 09:00
comments: true
external-url:
categories: Mathematics
---

How many people do you need in a room before it's more likely than not that two of them share a birthday? Most people guess somewhere close to 183, half of 365. The actual answer is 23, and the gap between intuition and reality is what makes this such a good example of how badly humans reason about combinatorics.

## Counting collisions instead of matches

It's much easier to compute the probability that **no two people** share a birthday than to compute the probability that some pair does. With $n$ people and 365 equally likely birthdays,[^uniform] the probability of no collision is

$$
P(\text{no match}) = \prod_{i=0}^{n-1} \frac{365 - i}{365}
$$

and so the probability we actually care about is its complement:

$$
P(\text{match}) = 1 - \prod_{i=0}^{n-1} \frac{365 - i}{365}
$$

Each new person added to the room doesn't just add one new chance of a collision, they add one new chance *against every person already there*. That's what gives the curve its characteristically explosive early growth: with 23 people there are $\binom{23}{2} = 253$ pairs to check, not 23.

<div class="diagram">
<svg viewBox="0 0 420 220" role="img" aria-label="Probability of a shared birthday climbing steeply as group size grows from 0 to 60 people, crossing 50% at 23 people">
<line x1="40" y1="180" x2="400" y2="180" class="diagram-axis"/>
<line x1="40" y1="20" x2="40" y2="180" class="diagram-axis"/>
<text x="220" y="205" text-anchor="middle" class="diagram-label">people in the room</text>
<text x="14" y="100" text-anchor="middle" class="diagram-label" transform="rotate(-90 14 100)">P(match)</text>
<polyline class="diagram-accent" stroke-width="2.5" points="40,180 76,179 112,172 148,151 184,110 220,66 256,38 292,23 328,16 364,12 400,10" />
<circle class="diagram-accent" cx="184" cy="110" r="3.5"/>
<text x="184" y="95" text-anchor="middle" class="diagram-label">23 people, 50.7%</text>
</svg>
</div>

## Checking it by simulation

When a formula feels too clean to trust, simulate it:

```python
import random

def has_collision(n, days=365, trials=20000):
    hits = 0
    for _ in range(trials):
        birthdays = [random.randrange(days) for _ in range(n)]
        if len(set(birthdays)) < n:
            hits += 1
    return hits / trials

for n in (10, 23, 40, 57):
    print(f"n={n:>2}  P(match) ~= {has_collision(n):.3f}")
```

```
n=10  P(match) ~= 0.117
n=23  P(match) ~= 0.507
n=40  P(match) ~= 0.891
n=57  P(match) ~= 0.990
```

23 people is the smallest room where the odds tip in favor of a match; by 57 it's essentially guaranteed. The same $1 - \prod(\ldots)$ shape shows up anywhere you're checking pairs instead of individuals — hash collisions, birthday attacks on cryptographic digests,[^attack] deduplication in a database — which is the real reason this puzzle keeps coming back up.

[^uniform]: In reality birthdays aren't quite uniform across the year (September runs higher, February 29 far lower), which makes the true collision probability a little *higher* than this idealized model predicts, not lower — non-uniformity always increases collision odds compared to the uniform case.

[^attack]: See Yuval, G. (1979), "How to Swindle Rabin", Cryptologia, for the original description of exploiting this against digital signatures.
