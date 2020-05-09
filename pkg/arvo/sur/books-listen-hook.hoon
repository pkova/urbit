::  books-listen-hook: actions for getting your friends' shelves
::
::    Note that /app/books-listen-hook auto-joins any new collections in groups
::    you're a part of. You only need the watch action here for leaving and
::    re-joining.
::
|%
+$  action
  $%  [%watch =path]
      [%leave =path]
  ==
::
+$  update
  $%  [%listening paths=(set path)]
      action
  ==
--
