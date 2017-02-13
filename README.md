# BiopLib Python
A Python interface for [**BiopLib**](http://bioinf.org.uk/software/bioplib/) version 3.45 

Bioplib is a library of routines for the manipulation of protein
structure and sequence using the C programming language. In addition,
the term "**Bioplib**" refers to routines for more general C programming
purposes.

This is a **Python** wrapper for 

Based on BiopLib for C: 

> &copy; 1990-2016 SciTech Software <br/>
> Dr. Andrew C.R. Martin <br/>
> UCL and The University of Reading <br/>
> EMail: andrew@bioinf.org.uk <br/>


Python interface developed by:
> Pouria Hadjibagheri <br/>
> Birkbeck, University of London / SysMIC, UCL <br/>

Also see:

- Original [copyright notice and disclaimer](https://github.com/ACRMGroup/bioplib/blob/master/README.md).
- C library repository on [GitHUB](https://github.com/ACRMGroup/bioplib/).
- Documentations for C on Dr Andrew C R Martin's Bioinformatics Group [website](http://bioinf.org.uk/software/bioplib/bioplib/doc/html/index.html).  

The library has other equivalents such as [BioPython](https://github.com/biopython/biopython.github.io/) 
in Python, [BioPerl](https://github.com/bioperl) in Perl, 
and another C library and tool-set (EMBOSS).

However, the focus of all these other libraries is on protein and DNA sequence rather
than structure. Conversely, **Bioplib** is a very comprehensive library for handling
protein structure, with some support for protein and DNA sequences. The fact that the
code is implemented in C means that it is ideal for more complex and CPU-intensive
tasks since C (unlike Perl and Python) is a compiled language.


## Installation

Download the repository and follow the instructions:

```bash
git clone ...
```  

```bash
cd bioplib
python3 setup.py
```
This will install both the Python interface and its C dependencies. You will 
need a C compiler (e.g. `gcc` or `clang`) already installed on your operating 
system to complete the process.


## Licence

BiopLib, the original library and the Python interface, are both licensed 
under the **GPLv3**. See the file `LICENCE.md` for additional information.

This program is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Commercial licences are also available - 
see [COPYING](https://github.com/ACRMGroup/bioplib/blob/master/COPYING.DOC) 
for additional information.


### Prospective implementations

#### libxml2

The C library supports PDBML. This tool has not been adapted in the 
Python interface, but is in our _To Do_ list. 

By default, PDBML (XML) format files are supported by the C library, but 
the usage requires the installation of `libxml2`. We are reviewing the 
pros and cons to determine as to whether we should stick with this approach
in `libxml2` or leverage Python-based tools and develop a brand-new parser 
for PDBML.  


#### Documentations
Both the original C library and the Python interface source codes are 
well commented and documented. 

Formal documentations for **Bioplib Python** will be compiled and made 
available once the initial stage of the development is finished.


#### Contributions
Please feel free to fork the repository to implement the outstanding 
tools and make pull requests. 

Coding style (and nomenclature in for Python-accessible declarations) 
should be strictly based on 
[Python PEP 8: Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/).
 
Development of direct interactions with the C library requires `cython>=0.25`.
