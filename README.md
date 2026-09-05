# X50 Navigation releases

Public protected binary releases and Magisk update metadata for X50
Navigation. The Magisk module includes the three separate steering-wheel
shortcut applications, so they do not need to be installed manually.

This repository intentionally contains no application source code.

Navigation works without activation. Background usage statistics report
anonymous session starts and duration, without location, routes, speed or a raw VIN.

Since 0.15.20, the Diagnostics tab also offers an explicit support recording.
Only after the user starts it with consent, the session records trip coordinates,
GPS/FakeGPS state, settings, permissions and errors. Stopping attempts upload to
the support bot; the same archive can be saved or shared manually. Reports and
original files are owner-only, linked to the vehicle. Tokens and the full VIN
are excluded; server archives expire after 14 days. This is separate from
background usage statistics.
