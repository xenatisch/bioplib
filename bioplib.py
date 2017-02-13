#!/usr/bin/env python3


# Imports
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Python:

# 3rd party: None

# Internal: 
from clib.bioplib_clib import ReadWholePDB

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__all__ = ['ReadPDB']


class ReadPDB(ReadWholePDB):
    def __init__(self, path):
        """
        :param path: Path to the PDB file.
        :type path: str

        Examples
        ----------
        >>> pdb_file = 'test_assets/5ljb.pdb'
        >>> protein = ReadPDB(pdb_file)
        >>> atoms = protein.atoms
        >>> len(atoms)
        2421
        >>> atoms[0]['resnam']
        'PRO'
        """
        # Path is not used in this method. It is, however, used
        # in the `__cinit__` method defined in the Cython class,
        # and is shown here merely to assist IDEs, helps, and
        # documentations to expect an attribute.
        super(ReadPDB, self).__init__()

    @property
    def get_carbon_alpha(self):
        """
        Finds and returns a list of carbon alpha atoms.

        :return: List of dictionaries containing information on carbon alpha atoms.
        :rtype: list

        Examples
        ----------
        >>> pdb_file = 'test_assets/5ljb.pdb'
        >>> protein = ReadPDB(pdb_file)
        >>> carbon_alphas = protein.get_carbon_alpha
        >>> len(carbon_alphas)
        134
        >>> carbon_alphas[0]['atnam']
        'CA'
        >>> carbon_alphas[0]['resnam']
        'PRO'
        >>> carbon_alphas[0]['atnum']
        2
        """
        ca = filter(lambda x: 'CA' in x['atnam'].upper(), self)
        return list(ca)


if __name__ == '__main__':
    from doctest import testmod
    testmod()
