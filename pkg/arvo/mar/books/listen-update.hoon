::  books-listen-update
::
/-  *books-listen-hook
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
    %+  frond  'books-listen-update'
    %+  frond  -.upd
    ?-  -.upd
      %listening        a+(turn ~(tap in paths.upd) path)
      ?(%watch %leave)  (path path.upd)
    ==
  --
--
