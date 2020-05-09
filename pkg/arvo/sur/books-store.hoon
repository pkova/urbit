|%
+$  book
  $:  id=@
      title=@t
      author=@t
      rating=(unit rating)
      pages=@
      published=@da
      added=@da
      read=(unit @da)
      cover-url=@t
  ==
::
+$  book-to-be-added
  $:  title=@t
      cover-url=@t
      author=@t
      rating=(unit rating)
      pages=@
      published=@da
      read=(unit @da)
  ==
::
+$  rating  ?(%1 %2 %3 %4 %5)
::
+$  books-action
  $%  ::    user actions
      ::
      [%add =path book=book-to-be-added]
      [%remove =path id=@]
      [%delete =path]
      ::  %note: save a note for a book
      ::
      [%note =path id=@ udon=@t]
      ::    hook actions
      ::
      ::  %hear: hear about book at path on other ship
      ::
      [%hear =path book]
      ::  %read: read note on book from ship
      ::
      [%read =path id=@ =comment]
  ==
+$  initial
  $%  [%local-books pages=(map path books)]
      [%annotations notes=(per-path-url notes)]
      [%discussions comments=(per-path-url comments)]
  ==
+$  update
  $%  [%local-books =path =books]
      [%annotations =path id=@ =notes]
      [%discussions =path id=@ =comments]
  ==
::  +note: a comment on some url
::
+$  note
  $:  =time
      udon=@t
  ==
::  +comment: a comment by a ship on some url
::
+$  comment
  $:  =ship
      note
  ==
::
+$  discussion
  $:  =comments
      ours=notes
==
::
+$  notes     (list note)
::
+$  comments  (list comment)
::
+$  books     (list book)
::
+$  discussions  (per-path-url discussion)
::  state builder
::
++  per-path-url
  |$  [value]
  (map path (map @ value))
--
