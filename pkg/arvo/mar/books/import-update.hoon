::  books-listen-update
::
/-  *books-import-hook
=,  dejs:format
|_  upd=update
++  grab
  |%
  ++  noun  update
  --
::
++  grow
  |%
  ++  noun  upd
  ++  json
    =,  enjs:format
    %+  frond  'books-import-update'
    %+  frond  ?:  =(%oauth-url -.upd)
      'oauthUrl'
    -.upd
    ?-  -.upd
      %oauth-url  s+url.upd
    ==
  --
--
