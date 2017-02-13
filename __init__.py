#!/usr/bin/env python3

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

This program is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this
program.  If not, see <http://www.gnu.org/licenses/>.


Author:               Dr Andrew C. R. Martin <andrew@bioinf.org.uk>
Contributors:         Dr Craig T. Porter, Pouria Hadjibagheri
Python interface:     Pouria Hadjibagheri <p.bagheri@ucl.ac.uk>

"""

# Imports
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Python:

# 3rd party:

# Internal: 
from bioplib import ReadPDB

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__author__ = 'Pouria Hadjibagheri'
__credits__ = ['Andrew C. R. Martin', 'Craig T. Porter', 'Pouria Hadjibagheri']
__copyright__ = 'Copyright 1990-2017'
__license__ = 'GPLv3'
__maintainer__ = ['Andrew C. R. Martin', 'Pouria Hadjibagheri']
__email__ = ['andrew.martin@ucl.ac.uk', 'p.bagheri.12@ucl.ac.uk']
__date__ = '09/02/2017, 22:53'


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

__all__ = ['ReadPDB']
