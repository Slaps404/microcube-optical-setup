#!/usr/bin/env python3
"""Reject disconnected or non-manifold STL meshes using only the standard library."""

from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from pathlib import Path
import struct


def load_triangles(path: Path) -> list[tuple[tuple[float, float, float], ...]]:
    data = path.read_bytes()
    if len(data) >= 84:
        count = struct.unpack_from("<I", data, 80)[0]
        if 84 + count * 50 == len(data):
            triangles = []
            for index in range(count):
                offset = 84 + index * 50 + 12
                values = struct.unpack_from("<9f", data, offset)
                triangles.append(tuple(tuple(values[i : i + 3]) for i in range(0, 9, 3)))
            return triangles

    triangles = []
    current: list[tuple[float, float, float]] = []
    for raw_line in data.decode("utf-8").splitlines():
        fields = raw_line.split()
        if fields[:1] == ["vertex"]:
            current.append(tuple(float(value) for value in fields[1:4]))
            if len(current) == 3:
                triangles.append(tuple(current))
                current = []
    if not triangles:
        raise ValueError("contains no triangles")
    return triangles


def inspect(path: Path) -> tuple[int, int, int]:
    triangles = load_triangles(path)
    vertex_ids: dict[tuple[float, float, float], int] = {}
    indexed = []
    for triangle in triangles:
        indexed.append(tuple(vertex_ids.setdefault(vertex, len(vertex_ids)) for vertex in triangle))

    edge_counts: Counter[tuple[int, int]] = Counter()
    edge_triangles: defaultdict[tuple[int, int], list[int]] = defaultdict(list)
    for triangle_index, triangle in enumerate(indexed):
        edges = (
            tuple(sorted((triangle[0], triangle[1]))),
            tuple(sorted((triangle[1], triangle[2]))),
            tuple(sorted((triangle[2], triangle[0]))),
        )
        edge_counts.update(edges)
        for edge in edges:
            edge_triangles[edge].append(triangle_index)

    nonmanifold_edges = sum(count != 2 for count in edge_counts.values())
    adjacency: defaultdict[int, set[int]] = defaultdict(set)
    for incident in edge_triangles.values():
        for triangle_index in incident:
            adjacency[triangle_index].update(other for other in incident if other != triangle_index)

    unseen = set(range(len(indexed)))
    components = 0
    while unseen:
        components += 1
        stack = [unseen.pop()]
        while stack:
            neighbors = adjacency[stack.pop()] & unseen
            unseen.difference_update(neighbors)
            stack.extend(neighbors)

    return len(triangles), components, nonmanifold_edges


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("stl", nargs="+", type=Path)
    args = parser.parse_args()
    failed = False
    for path in args.stl:
        try:
            triangles, components, nonmanifold_edges = inspect(path)
            valid = components == 1 and nonmanifold_edges == 0
            print(
                f"{path}: triangles={triangles}, surface_components={components}, "
                f"watertight={nonmanifold_edges == 0}"
            )
            failed |= not valid
        except (OSError, UnicodeDecodeError, ValueError) as error:
            print(f"{path}: invalid STL: {error}")
            failed = True
    return int(failed)


if __name__ == "__main__":
    raise SystemExit(main())
