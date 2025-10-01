*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZODATA_KEYS_CFG.................................*
DATA:  BEGIN OF STATUS_ZODATA_KEYS_CFG               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZODATA_KEYS_CFG               .
CONTROLS: TCTRL_ZODATA_KEYS_CFG
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *ZODATA_KEYS_CFG               .
TABLES: ZODATA_KEYS_CFG                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
