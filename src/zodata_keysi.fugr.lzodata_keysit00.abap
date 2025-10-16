*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZODATA_KEYS_CF1.................................*
DATA:  BEGIN OF STATUS_ZODATA_KEYS_CF1               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZODATA_KEYS_CF1               .
CONTROLS: TCTRL_ZODATA_KEYS_CF1
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *ZODATA_KEYS_CF1               .
TABLES: ZODATA_KEYS_CF1                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
