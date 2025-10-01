REPORT zreset_pwd_put.

PARAMETERS:
  p_user TYPE xubname         OBLIGATORY,   " Username (CHAR12)
  p_pass TYPE xu400-newcode   OBLIGATORY.   " New password (CHAR40)

DATA: ls_logondata TYPE uslogond,   " Structure required by FM
      lv_subrc     TYPE sy-subrc.

START-OF-SELECTION.

  CLEAR ls_logondata.   " no changes in logon data

  CALL FUNCTION 'SUSR_USER_PASSWORD_PUT'
    EXPORTING
      user_name               = p_user
      password                = p_pass
      delete_password         = space
      user_logondata          = ls_logondata
      maint_for_own_user_only = space
      password_status         = space
    EXCEPTIONS
      user_name_not_exist     = 1
      password_not_allowed    = 2
      passwords_not_equal     = 3
      others                  = 4.

  lv_subrc = sy-subrc.

  CASE lv_subrc.
    WHEN 0.
      COMMIT WORK.
      WRITE: / 'Password for user', p_user, 'was reset successfully.'.
    WHEN 1.
      WRITE: / 'Error: User does not exist.'.
    WHEN 2.
      WRITE: / 'Error: Password not allowed (policy violation).'.
    WHEN 3.
      WRITE: / 'Error: Passwords not equal (check parameter).'.
    WHEN OTHERS.
      WRITE: / 'Error: Unknown problem during password reset.'.
  ENDCASE.
