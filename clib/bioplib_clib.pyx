#!/usr/bin/env python3

"""
<Description of the programme>

Programmed in Python 3.5.1-final.
"""

# Imports
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Cython/C:

# Python:

# 3rd party:

# Internal: 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""
Author: Pouria Hadjibagheri
Copyright: Copyright 2017
Credits: Pouria Hadjibagheri
Licence: MIT
Maintainer: Pouria Hadjibagheri
Email: p.bagheri.12@ucl.ac.uk
Created on: 09/02/2017, 22:49
"""
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cdef class ReadWholePDB:
    cdef WHOLEPDB *wpdb
    cdef WHOLEPDB *_wpdb_original

    def __cinit__(self, path):
        cdef FILE* fp_in
        path_bytes = path.encode(encoding='utf-8')
        cdef const char *fname = path_bytes
        fp_in = fopen(fname, "r")

        if fp_in == NULL:
            raise FileNotFoundError(2, "No such file or clib_abs_dir: '%s'" % fname)

        self._wpdb_original = blReadWholePDB(fp_in)
        self.wpdb = self._wpdb_original
        fclose(fp_in)

    # --------------------------------------------------------------------------------------------

    def __iter__(self):
        for item in self._get_all():
            yield item

    cpdef int _natoms(self):
        return self.wpdb.natoms

    cpdef char* chain(self):
        return self.wpdb.pdb.chain

    cpdef int formal_charge(self):
        return self.wpdb.pdb.formal_charge

    cpdef void reset(self):
        self.wpdb = self._wpdb_original

    # --------------------------------------------------------------------------------------------

    @property
    def natoms(self):
        return self._natoms()

    # --------------------------------------------------------------------------------------------

    cdef list _ctype2python(self, values):
        for index, item in enumerate(values):
            if isinstance(item, bytes):
                decoded_str = bytes.decode(item, 'UTF-8')
                decoded_striped = decoded_str.strip()
                values[index] = decoded_striped if decoded_striped else None
        return values

    # --------------------------------------------------------------------------------------------

    cdef list _get_atoms(self, PDB *pointer, keys=None):
        """
        Get all atoms from the PDB file.

        :param pointer:
        :type pointer:
        :param keys: Limit the attributes included in the dictionary.
        :type keys: set, list, tuple
        :return: List of dictionaries containing the results limited to `keys` if defined.
        :rtype: list
        """

        keys_collection = (
            'resnum', 'resnam', 'atnam', 'atnum',
            'nConect','atomtype', 'chain', 'element',
            'p.segid', 'secstr', 'altpos'
        )

        iterator = 0

        if isinstance(keys, str):
            keys = {[keys]}

        if keys:
            keys = set(keys_collection).intersection(set(keys))

        # predefining the list
        # The -1 in the length is to address 0-based indexing.
        keys = keys or keys_collection
        dict_template = dict(zip(keys, [None] * len(keys)))
        atoms = [dict_template] * (self.wpdb.natoms - 1)

        while pointer.next != NULL:
            pointer = pointer.next

            values = [
                pointer.resnum, pointer.resnam, pointer.atnam,
                pointer.atnum, pointer.nConect, pointer.atomtype,
                pointer.chain, pointer.element, pointer.segid,
                pointer.secstr, pointer.altpos
            ]

            # Constructing a dictionary of values.
            structured_values = dict(zip(
                keys_collection,
                self._ctype2python(values)
            ))

            # Checking against the keys to extract the requested items only.
            atoms[iterator] = (
                structured_values if not keys == keys_collection else
                dict([(key, structured_values[key]) for key in dict_template])
            )

            iterator += 1

        return atoms[:iterator]

    cdef list _get_all(self):
        cdef PDB *pointer = self.wpdb.pdb
        return self._get_atoms(pointer=pointer)

    @property
    def atoms(self):
        return self._get_all()

    # --------------------------------------------------------------------------------------------

    cdef list _get_Ca(self):
        return self._get_atoms(pointer=blSelectCaPDB(self.wpdb.pdb))

    @property
    def get_Ca(self):
        """
        Find carbon alpha atoms.

        :return: List of dicts containing the PDB data.
        :rtype: list
        """
        return self._get_Ca()

    # --------------------------------------------------------------------------------------------

    cdef list _find_atom_wildcard_in_res(self, char *pattern):
        cdef PDB* pointer = blFindAtomWildcardInRes(self.wpdb.pdb, pattern)

        if pointer != NULL:
            return self._get_atoms(pointer=pointer)

        return None

    def find_atom_wildcard_in_res(self, pattern):
        return self._find_atom_wildcard_in_res(pattern.encode())

    # --------------------------------------------------------------------------------------------

    cdef list _remove_alternates(self):
        return self._get_atoms(pointer=blRemoveAlternates(self.wpdb.pdb))

    def remove_alternates(self):
        return self._remove_alternates()

    # --------------------------------------------------------------------------------------------

    cdef list _strip_Gly_CB(self):
        return self._get_atoms(pointer=blStripGlyCB(self.wpdb.pdb))

    def strip_Gly_CB(self):
        return self._strip_Gly_CB()

    # --------------------------------------------------------------------------------------------

