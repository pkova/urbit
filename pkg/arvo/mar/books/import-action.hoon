/-  *books-import-hook
=,  dejs:format
|_  act=books-import-action
++  grab
  |%
  ++  noun  books-import-action
  ++  json
    |^  %-  of
        :~  %request-token^request-token
            %access-token^access-token
            %import^import
        ==
    ::
    ++  request-token
      (ot 'consumerKey'^so 'consumerSecret'^so ~)
    ++  access-token
      ul
    ++  import
      (ot 'path'^pa 'profileId'^so ~)
    --
  --
::
++  grow
  |%
  ++  noun  act
  --
--
