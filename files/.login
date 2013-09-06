if (-e /usr/bin/calendar) then
  /usr/bin/calendar
endif

if (-e /usr/local/bin/keychain) then
  /usr/local/bin/keychain --host local
endif
