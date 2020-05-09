/-  *books-store
/+  default-agent, verb, dbug

|%
+$  card  card:agent:gall
::
+$  versioned-state
  $%  state-zero
  ==
::
+$  state-zero
  $:  %0
      by-group=(map path books)
      discussions=(per-path-url discussion)
      latest-id=@
  ==
::
--
::
=|  state-zero
=*  state  -
::
%-  agent:dbug
%+  verb  |
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this        .
      books-core  +>
      do          ~(. books-core bowl)
      def         ~(. (default-agent this %|) bowl)
  ::
  ++  on-init   on-init:def
  ++  on-save   !>(state)
  ++  on-load
    |=  old=vase
    `this(state !<(state-zero old))
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bowl src.bowl)
    =^  cards  state
      ?+  mark  (on-poke:def mark vase)
        %books-action  (poke-books-action:do !<(books-action vase))
      ==
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?>  (team:title [our src]:bowl)  ::TODO  /lib/store
    :_  this
    |^  ?+  path  (on-watch:def path)
            [%local-books *]
          %+  give  %books-initial
          ^-  initial
          [%local-books (get-local-books:do t.path)]
        ::
            [%annotations *]
          %+  give  %books-initial
          ^-  initial
          [%annotations (get-annotations:do t.path)]
        ::
            [%discussions *]
          %+  give  %books-initial
          ^-  initial
          [%discussions (get-discussions:do t.path)]
        ::
          ::    [%seen ~]
          ::  ~
        ==
    ::
    ++  give
      |*  [=mark =noun]
      ^-  (list card)
      [%give %fact ~ mark !>(noun)]~
    ::
    ++  give-single
      |*  [=mark =noun]
      ^-  card
      [%give %fact ~ mark !>(noun)]
    --
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+  path  (on-peek:def path)
        [%x %all ~]
      ``noun+!>(by-group)
    ::
        [%y ?(%local-books %submissions) ~]
      ``noun+!>(~(key by by-group))
    ::
        [%x %local-books *]
      ``noun+!>((get-local-books:do t.t.path))
    ::
        [%y ?(%annotations %discussions) *]
      =/  [spath=^path id=(unit @)]
        (break-discussion-path t.t.path)
      =-  ``noun+!>(-)
      ::
      ?~  id
        ::  no id, provide ids that have comments
        ::
        ^-  (set @)
        ?~  spath
          ::  no path, find ids accross all paths
          ::
          %-  ~(rep by discussions)
          |=  [[* discussions=(map @ discussion)] ids=(set @)]
          %-  ~(uni in ids)
          ~(key by discussions)
        ::  specified path, find ids for that specific path
        ::
        %~  key  by
        (~(gut by discussions) spath *(map @ *))
      ::  specified id and path, nothing to list here
      ::
      ?^  spath  !!
      ::  no path, find paths with comments for this id
      ::
      ^-  (set ^path)
      %-  ~(rep by discussions)
      |=  [[=^path ids=(map @ discussion)] paths=(set ^path)]
      ?.  (~(has by ids) u.id)  paths
      (~(put in paths) path)
    ::
        [%x %discussions *]
      ``noun+!>((get-discussions:do t.t.path))
    ::
    ==
  ++  on-leave  on-leave:def
  ++  on-agent  on-agent:def
  ++  on-arvo   on-arvo:def
  ++  on-fail   on-fail:def
  --
::
|_  bol=bowl:gall
::
++  poke-books-action
  |=  action=books-action
  ^-  (quip card _state)
  ?+  -.action   !!
      %add     (handle-add +.action)
      %remove  (handle-remove +.action)
      %note    (handle-note +.action)
      %delete  (handle-delete +.action)
      %hear    (handle-hear +.action)
  ==
::
++  handle-hear
  |=  [=path =book]
  ^-  (quip card _state)
  ?<  ?=(~ path)
  =/  =books  (~(gut by by-group) path *books)
  =^  added  books
    ?:  ?=(^ (find ~[book] books))
      [| books]
    :-  &
    (merge-books books ~[book])
  =.  by-group  (~(put by by-group) path books)
  ::  send updates to subscribers
  ::
  :_  state
  ?.  added  ~
  :_  ~
  :+  %give  %fact
  :+  :~  /local-books
          [%local-books path]
      ==
    %books-update
  !>([%local-books path [book]~])
::
++  handle-add
  |=  [=path b=book-to-be-added]
  ^-  (quip card _state)
  ?<  ?=(~ path)
  =/  =book
    :*  latest-id.state
        title.b
        author.b
        rating.b
        pages.b
        published.b
        now.bol
        read.b
        cover-url.b
    ==
  :_
    ?.  (~(has by by-group.state) path)
      state(by-group (~(put by by-group.state) path ~[book]), latest-id +(latest-id.state))
    =/  new-state
      %+  ~(jab by by-group.state)  path
      |=  =books
      (into books 0 book)
    state(by-group new-state, latest-id +(latest-id.state))
  :_  ~
  :+  %give  %fact
  :+  :~  /local-books
          [%local-books path]
      ==
    %books-update
  !>([%local-books path [book]~])
::
:: TODO: handle subscriber updates somehow
::
++  handle-delete
  |=  =path
  ^-  (quip card _state)
  :-  ~
  state(by-group (~(del by by-group.state) path))
::
++  handle-remove
  |=  [=path id=@]
  ^-  (quip card _state)
  ?>  (~(has by by-group.state) path)
  :-  ~
  =/  new-state
    %+  ~(jab by by-group.state)  path
    |=  =books
    (skip books |=(b=book =(id id.b)))
  state(by-group new-state)
::
++  handle-note
  |=  [=path id=@ udon=@t]
  ^-  (quip card _state)
  ?<  |(=(~ path) =(~ udon))
  ::  add note to discussion ours
  ::
  =/  books  (~(gut by discussions) path *(map @ discussion))
  =/  =discussion  (~(gut by books) id *discussion)
  =/  =note  [now.bol udon]
  =.  ours.discussion  [note ours.discussion]
  =.  books  (~(put by books) id discussion)
  =.  discussions  (~(put by discussions) path books)
  ::  send updates to subscribers
  ::
  :_  state
  ^-  (list card)
  :_  ~
  :+  %give  %fact
  :+  :~  /annotations
          [%annotations %$ path]
          [%annotations (build-discussion-path id)]
          [%annotations (build-discussion-path path id)]
      ==
    %books-update
  !>([%annotations path id [note]~])
::

++  get-local-books
  |=  =path
  ^-  (map ^path books)
  ?~  path
    ::  all paths
    ::
    by-group
  ::  specific path
  ::
  %+  ~(put by *(map ^path books))  path
  (~(gut by by-group) path *books)
::
++  break-discussion-path
  |=  =path
  ^-  [=^path id=(unit @)]
  ?~  path  [/ ~]
  :-  t.path
  ?:  =(~ i.path)  ~
  ~|  path
  `(rash (slav %ta i.path) dem)
::
++  build-discussion-path
  |=  args=$@(id=@ [=path id=@])
  |^  ^-  path
      ?@  args  ~[(encode-id-for-path args)]
      :_  path.args
      (encode-id-for-path id.args)
  ::
  ++  encode-id-for-path
    |=  id=@
    ^-  @ta
    =/  n  (numb:enjs:format id)
    ?>  ?=(%n -.n)
    (scot %ta p.n)
  --
::
++  get-annotations
  |=  =path
  ^-  (per-path-url notes)
  =/  args=[=^path id=(unit @)]
    (break-discussion-path path)
  |^  ?~  path
        ::  all paths
        ::
        (~(run by discussions) get-ours)
      ::  specific path
      ::
      %+  ~(put by *(per-path-url notes))  path.args
      %-  get-ours
      %+  ~(gut by discussions)  path.args
      *(map @ discussion)
  ::
  ++  get-ours
    |=  m=(map @ discussion)
    ^-  (map @ notes)
    ?~  id.args
      ::  all urls
      ::
      %-  ~(run by m)
      |=(discussion ours)
    ::  specific url
    ::
    %+  ~(put by *(map @ notes))  u.id.args
    ours:(~(gut by m) u.id.args *discussion)
  --
::
++  merge-books
  |=  [a=books b=books]
  ^+  a
  %+  merge-sorted-unique
    |=  [a=book b=book]
    (gth added.a added.b)
  [a b]
::
++  merge-sorted-unique
  |*  [sort=$-([* *] ?) a=(list) b=(list)]
  |-  ^-  ?(_a _b)
  ?~  a  b
  ?~  b  a
  ?:  =(i.a i.b)
    [i.a $(a t.a, b t.b)]
  ?:  (sort i.a i.b)
    [i.a $(a t.a)]
  [i.b $(b t.b)]
::
++  get-discussions
  |=  =path
  ^-  (per-path-url comments)
  =/  args=[=^path id=(unit @)]
    (break-discussion-path path)
  |^  ?~  path
        ::  all paths
        ::
        (~(run by discussions) get-comments)
      ::  specific path
      ::
      %+  ~(put by *(per-path-url comments))  path.args
      %-  get-comments
      %+  ~(gut by discussions)  path.args
      *(map @ discussion)
  ::
  ++  get-comments
    |=  m=(map @ discussion)
    ^-  (map @ comments)
    ?~  id.args
      ::  all urls
      ::
      %-  ~(run by m)
      |=(discussion comments)
    ::  specific url
    ::
    %+  ~(put by *(map @ comments))  u.id.args
    comments:(~(gut by m) u.id.args *discussion)
  --

--
