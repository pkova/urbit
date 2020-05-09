/+  *books
|_  act=books-action
++  grab
  |%
  ++  noun  books-action
  ++  json  action:de-json
  ::  ++  json
  ::    =,  dejs:format
  ::    |^  %-  of
  ::      :~  ['add' add]
  ::          ['remove' remove]
  ::          ['note' note]
  ::          ['hear' hear]
  ::          ['read' read]
  ::      ==
  ::    ::
  ::    ++  add
  ::      %-  ou
  ::      :~  ['path' (un pa)]
  ::          ['title' (un so)]
  ::          ['coverUrl' (un so)]
  ::          ['author' (un so)]
  ::          ['rating' (uf ~ (mu (cu |=(a=@ (rating a)) ni)))]
  ::          ['pages' (un ni)]
  ::          ['published' (un di)]
  ::          ['read' (uf ~ (mu di))]
  ::      ==
  ::    ++  remove
  ::      (ot 'path'^pa 'id'^ni ~)
  ::    ::
  ::    ++  note
  ::      (ot 'path'^pa 'id'^ni 'udon'^so ~)
  ::    ++  hear
  ::      (ot 'path'^pa 'books'^(ar book) ~)
  ::    ++  read
  ::      (ot 'path'^pa 'id'^ni 'comment'^comment ~)
  ::    ++  book
  ::      %-  ou
  ::      :~  ['id' (un ni)]
  ::          ['title' (un so)]
  ::          ['coverUrl' (un so)]
  ::          ['author' (un so)]
  ::          ['rating' (uf ~ (mu ni))]
  ::          ['pages' (un ni)]
  ::          ['published' (un ni)]
  ::          ['read' (uf ~ (mu ni))]
  ::          ['added' (un ni)]
  ::      ==
  ::    ++  comment
  ::      %-  ot
  ::      :~  ['ship' so]
  ::      :-  'note'
  ::        %-  ot
  ::        :~  ['time' di]
  ::            ['udon' so]
  ::        ==
  ::      ==
  ::    --
  ::  --
  --
--
