::  books: social books
::
/-  *books-store, books-import-hook
::
|%
++  de-json
  =,  dejs:format
  |%
  ::  +action: json into action
  ::
  ::    formats:
  ::    { add: { path: '/path',
  ::             title: 'title',
  ::             coverUrl: 'url',
  ::             author: 'author',
  ::             rating: 1,
  ::             pages: 100,
  ::             published: unix time,
  ::             read: unix time
  ::           }
  ::    }
  ::    {remove: {path: '/path', id: '1'}}
  ::    {note: {path: '/path', id: '1', udon: 'text'}}
  ::    {hear: {path: '/path', books: [books]}}
  ::    {read: {path: '/path', id: '1', comment: {ship: 'ship',
  ::                                              note: {time: unix time
  ::                                                     udon: 'text'}}}}
  ::
  ++  action
    |=  =json
    ^-  books-action
    ::TODO  the type system doesn't like +of here?
    ?+  json  ~|(json !!)
        [%o [%add *] ~ ~]
      :-  %add
      %.  q.n.p.json
      %-  ou
      :~  ['path' (un pa)]
          ['title' (un so)]
          ['coverUrl' (un so)]
          ['author' (un so)]
          ['rating' (un (mu (ci |=(a=@ `(rating a)) ni)))]
          ['pages' (un ni)]
          ['published' (un (se %da))]
          ['read' (un (mu di))]
      ==
    ::
        [%o [%remove *] ~ ~]
      :-  %remove
      %.  q.n.p.json
      (ot 'path'^pa 'id'^ni ~)
    ::
        [%o [%note *] ~ ~]
      :-  %note
      %.  q.n.p.json
      (ot 'path'^pa 'id'^ni 'udon'^so ~)
    ::
        [%o [%delete *] ~ ~]
      :-  %delete
      %.  q.n.p.json
      (ot 'path'^pa ~)
    ==
  --
--
