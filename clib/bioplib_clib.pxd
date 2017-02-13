
from libc.stdio cimport *
from libc.string cimport *


cdef extern from "<stdio.h>" nogil:
    ctypedef struct FILE
    cdef FILE *stdin
    cdef FILE *stdout
    cdef FILE *stderr

    FILE *fopen   (const char *filename, const char  *opentype)
    FILE *freopen (const char *filename, const char *opentype, FILE *stream)
    FILE *fdopen  (int fdescriptor, const char *opentype)
    int  fclose   (FILE *stream)
    size_t getline(char **lineptr, size_t *n, FILE *stream)


cdef extern from "<stdlib.h>":
    ctypedef void const_void "const void"


cdef extern from "./c_core/src/MathType.h":
    ctypedef double REAL

    ctypedef struct VEC3F:
        REAL x, y, z

    ctypedef VEC3F COOR


cdef extern from "./c_core/src/SysDefs.h":
    ctypedef short           BOOL
    ctypedef long            LONG
    ctypedef unsigned long   ULONG
    ctypedef short           SHORT
    ctypedef unsigned short  USHORT
    ctypedef unsigned char   UCHAR
    ctypedef unsigned char   UBYTE


cdef extern from "./c_core/src/general.h":
    ctypedef struct STRINGLIST:
        pass


cdef extern from "./c_core/src/hash.h":
    pass


cdef extern from "<string.h>" nogil:
    int strncmp (const char *s1, const char *s2, size_t size)


cdef extern from "./c_core/src/pdb.h":
    ctypedef void  *APTR

    ctypedef struct blATOMINFO:
        REAL mass, pol, NEff, vdwr
        char atomtype[8]

    ctypedef struct PDB:
        REAL       x, y, z, occ, bval, access, radius, partial_charge
        APTR       extras                   # Pointer for users to add information
        blATOMINFO *atomInfo                # Reserved for future use
        PDB        *next                    # Forward linked list
        PDB        *conect[8]               # CONECT record links
        int        atnum                    # Atom number
        int        resnum                   # Residue number
        int        formal_charge            # Formal charge - used in XML files
        int        nConect                  # Number of conections
        int        entity_id                # Entity ID - used in XML files
        int        atomtype                 # See ATOMTYPE_XXXX
        char       record_type[8]           # ATOM / HETATM                            [MIN 7]
        char       atnam[8]                 # Atom name, left justified                [MIN 6]
        char       atnam_raw[8]             # Atom name as it appears in the PDB file  [MIN 6]
        char       resnam[8]                # Residue name                             [MIN 5]
        char       insert[8]                # Numbering insert code                    [MIN 3*]
        char       chain[8]                 # Chain label                              [MIN 3*]
        char       element[8]               # Element type                             [MIN 3]
        char       segid[8]                 # Segment ID                               [MIN 3*]
        char       altpos                   # Alternate position indicator
        char       secstr                   # Secondary structure

    ctypedef struct PDBRESIDUE:
        PDBRESIDUE *next
        PDBRESIDUE *prev
        PDB        *start
        PDB        *stop
        APTR       *extras
        int        resnum
        char       chain[8]
        char       insert[8]
        char       resnam[8]
        char       resid[8]
        
    ctypedef struct PDBCHAIN:
        PDBCHAIN   *next
        PDBCHAIN   *prev
        PDB        *start
        PDB        *stop
        PDBRESIDUE *residues
        APTR       *extras
        char       chain[8]

    ctypedef struct PDBSTRUCT:
        PDB      *pdb
        PDBCHAIN *chains
        APTR     *extras 
        
    ctypedef struct SECSTRUC:
        SECSTRUC *next
        char     chain1[8]
        char     insert1[8]
        char     chain2[8]
        char     insert2[8]
        int      res1
        int      res2
        char     type
        
    ctypedef struct WHOLEPDB:
        PDB        *pdb
        STRINGLIST *header
        STRINGLIST *trailer
        int        natoms


    cdef WHOLEPDB *blReadWholePDB (FILE* fpin)
    cdef PDB      *blSelectCaPDB(PDB *pdb)
    cdef PDB      *blFindAtomWildcardInRes(PDB *pdb, char *pattern)
    cdef PDB      *blRemoveAlternates(PDB *pdb)
    cdef PDB      *blStripGlyCB(PDB *pdb)

    cdef PDB      *blDupeResiduePDB(PDB *pdb)
    cdef PDB      *blStripWatersPDBAsCopy(PDB *pdb, int *natom)
    cdef PDB      *blFindNextChain(PDB *pdb)
    cdef int      *blCalcTetraHCoords(PDB *nter, COOR *coor)


