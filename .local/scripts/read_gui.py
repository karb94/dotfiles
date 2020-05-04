#! /usr/bin/env python

import numpy as np
from ase import Atoms
from ase.visualize import view
from ase.build import make_supercell

from sys import argv

cell = {}

def readi(f):
    return list(map(int, f.readline().split()))
def readf(f):
    return list(map(float, f.readline().split()))

with open(argv[1]) as f:

    cell['dimensionality'], cell['centring'], cell['typa'] = readi(f)[:3]
    pbc = {
        1: (True, False, False),
        2: (True, True, False),
        3: (True, True, True)
    }

    cell['lattice vectors'] = np.array([readf(f), readf(f), readf(f)])
    if cell['dimensionality'] == 2:
        cell['lattice vectors'][2] = np.zeros(3)

    cell['n sym ops'] = int(f.readline())

    cell['sym ops'] = []
    for _ in range(cell['n sym ops']):
        sym_op = {
            'matrix': np.array([readf(f), readf(f), readf(f)]),
            'translation': np.array(readf(f))
        }
        cell['sym ops'].append(sym_op)

    cell['n atoms'] = int(f.readline())

    cell['atoms'] = {'atomic number': [], 'coordinates': []}
    for _ in range(cell['n atoms']):
        line = f.readline().split()
        cell['atoms']['atomic number'].append(int(line[0]))
        cell['atoms']['coordinates'].append(list(map(float, line[1:])))

atoms = Atoms(positions=cell['atoms']['coordinates'],
              numbers=cell['atoms']['atomic number'],
              cell=cell['lattice vectors'],
              pbc=pbc.get(cell['dimensionality']))

atoms.wrap(pbc=(True,True,False))
# print(atoms.cell)
# T = np.array([[ 2, 0, 0],
#               [ 0, 2, 0],
#               [ 0, 0, 1]])
# sc = make_supercell(atoms, T)
# view(sc)
# print(sc.cell)
view(atoms=atoms)
