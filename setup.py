#!/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6

"""
Bioplib - a high quality programming library for protein bioinformatics.
==============

Python interface based on bioplib.
--------------

**Bioplib** is a programming library, written in the C programming language, for
handling bioinformatics data – primarily protein structures, but also sequence data.

The library has equivalents for other programming languages such as Python (BioPython)
and Perl (BioPerl) and another C library and tool-set (EMBOSS) is also available.
However, the focus of all these other libraries is on protein and DNA sequence rather
than structure. Conversely, **Bioplib** is a very comprehensive library for handling
protein structure, with some support for protein and DNA sequences. The fact that the
code is implemented in C means that it is ideal for more complex and CPU-intensive
tasks since C (unlike Perl and Python) is a compiled language.

(c) 1990-2017 SciTech Software.
Dr. Andrew C.R. Martin,
UCL and The University of Reading.

Author:               Dr Andrew C. R. Martin <andrew@bioinf.org.uk>
Contributors:         Dr Craig T. Porter, Pouria Hadjibagheri
Python interface:     Pouria Hadjibagheri <p.bagheri@ucl.ac.uk>

"""

from distutils.core import setup
from distutils.extension import Extension
from os import path, listdir
from os.path import split, abspath, join, relpath

__license__ = """
This program is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this
program.  If not, see <http://www.gnu.org/licenses/>.
"""


# Enabled only in development:
# Use Cython files for compilation if `True`,
# otherwise the existing C files are used.
# Only enable if new Cython files is added or
# an existing Cython files has been
# modified.
USE_CYTHON = False

# Files in the C library that do not
# need to be compiled:
EXCLUDED_C_FILES = {
    'test.c'
}


# Cython files (.pyx) in the
# library (exclude the extension):
CYTHON_FILES = {
    'bioplib_clib',
}

# Do NOT modify:
# -------------------------
C_EXTENSION = '.c'
CYTHON_EXTENSION = '.pyx'


current_dir = split(abspath(__file__))[0]
clib_dir = join('clib', 'c_core', 'src')
clib_abs_dir = path.join(current_dir, clib_dir)

c_files = [
    file_name + (CYTHON_EXTENSION if USE_CYTHON else C_EXTENSION)
    for file_name in CYTHON_FILES
]

clib = [
    relpath(join(clib_abs_dir, file_name))
    for file_name in listdir(clib_abs_dir)
    if file_name.endswith(C_EXTENSION) and file_name not in EXCLUDED_C_FILES
]

extensions = [
    Extension(
        name='clib.bioplib_clib',
        sources=clib + [join('clib', ext) for ext in c_files],
    )
]


if USE_CYTHON:
    from Cython.Build import cythonize
    extensions = cythonize(extensions)
# -------------------------


setup(
    name='bioplib',
    version='1.95',
    ext_modules=extensions,
    url='https://github.com/ACRMGroup/bioplib',
    license=__license__,
    author=['Andrew C. R. Martin', 'Craig T. Porter', 'Pouria Hadjibagheri'],
    author_email=['andrew.martin@ucl.ac.uk', 'p.bagheri.12@ucl.ac.uk'],
    description=__doc__,
    # setup_requires=[],
    # packages=[],
)
