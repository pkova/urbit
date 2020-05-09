::  books-import-hook: encapsulating books importing
::
|%
+$  books-import-action
  $%  ::  %request-token: request token from goodreads
      ::
      [%request-token consumer-key=@t consumer-secret=@t]
      ::  %access-token: access token from goodreads
      ::
      [%access-token ~]
      ::  %import: import goodreads to books-store
      ::
      [%import =path id=@t]
  ==
+$  update
  $%  [%oauth-url url=@t]
  ==
--
