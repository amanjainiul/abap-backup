REPORT zassign_profile_to_user.

PARAMETERS: p_user   TYPE xubname   OBLIGATORY,   " Username
            p_profil TYPE xuprofile OBLIGATORY.   " Profile to add

DATA: lt_profiles TYPE TABLE OF bapiprof,
      ls_profile  TYPE bapiprof,
      lt_return   TYPE TABLE OF bapiret2,
      ls_return   TYPE bapiret2.

START-OF-SELECTION.

  " Step 1: Get current profiles
  CALL FUNCTION 'BAPI_USER_GET_DETAIL'
    EXPORTING
      username = p_user
    TABLES
      profiles = lt_profiles
      return   = lt_return.

  " Step 2: Append new profile if not already present
  READ TABLE lt_profiles WITH KEY bapiprof = p_profil TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
    CLEAR ls_profile.
    ls_profile-bapiprof = p_profil.
    APPEND ls_profile TO lt_profiles.
  ENDIF.

  " Step 3: Re-assign full profile list
  CALL FUNCTION 'BAPI_USER_PROFILES_ASSIGN'
    EXPORTING
      username = p_user
    TABLES
      profiles = lt_profiles
      return   = lt_return.

  " Show messages
  LOOP AT lt_return INTO ls_return.
    WRITE: / ls_return-type, ls_return-message.
  ENDLOOP.

  " Commit changes if no error
  IF NOT line_exists( lt_return[ type = 'E' ] ).
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait = abap_true.
    WRITE: / 'Profile', p_profil, 'added successfully to user', p_user.
  ELSE.
    WRITE: / 'Error occurred, no changes committed.'.
  ENDIF.
