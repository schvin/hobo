#if (-e /usr/bin/calendar) then
#  /usr/bin/calendar
#endif

if (-e /usr/local/bin/keychain || -e /usr/bin/keychain) then
  keychain --host local
endif
