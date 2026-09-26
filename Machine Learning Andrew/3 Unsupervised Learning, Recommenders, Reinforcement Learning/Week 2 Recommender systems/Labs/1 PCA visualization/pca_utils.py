"""Small NumPy helper used by the Course 3 PCA visualization lab."""

import numpy as np


def random_point_circle(center=(0.0, 0.0), radius=1.0, n=1):
    """Sample points uniformly by area inside a circle."""
    radii = radius * np.sqrt(np.random.rand(n))
    angles = np.random.rand(n) * 2 * np.pi
    x = center[0] + radii * np.cos(angles)
    y = center[1] + radii * np.sin(angles)
    return np.column_stack((x, y))
