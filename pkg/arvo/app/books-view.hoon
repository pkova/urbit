::  books-view: frontend endpoints
::
::  endpoints, mapping onto books-store's paths. p is for page as in pagination.
::  updates only work for page 0.
::  as with link-store, urls are expected to use +wood encoding.
::
::    /json/[p]/local-books                           pages for all groups
::    /json/[p]/local-books/[some-group]              page for one group
::    /json/[p]/discussions/[wood-url]/[some-group]   page for url in group
::    /json/[n]/submission/[wood-url]/[some-group]    nth matching submission
::    /json/seen                                      mark-as-read updates
::
/-  *books-store, *books-view, *invite-store,
    group-store, group-hook, contact-view,
    permission-hook, permission-group-hook,
    metadata-hook, books-store
/+  *server, default-agent, verb, dbug, metadata
/=  index
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/books/index
  /|  /html/
      /~  ~
  ==
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/books/js/tile
  /|  /js/
      /~  ~
  ==
/=  script
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/books/js/index
  /|  /js/
      /~  ~
  ==
/=  style
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/books/css/index
  /|  /css/
      /~  ~
  ==
/=  books-png
  /^  (map knot @)
  /:  /===/app/books/img  /_  /png/
::
|%
+$  card  card:agent:gall
--
%+  verb  |
%-  agent:dbug
^-  agent:gall
=<
  |_  bol=bowl:gall
  +*  this  .
      do    ~(. +> bol)
      def   ~(. (default-agent this %|) bol)
  ::
  ++  on-init
    ^-  (quip card _this)
    :_  this
    :~  [%pass / %arvo %e %connect [~ /'~books'] %books-view]
        [%pass /local-books %agent [our.bol %books-store] %watch /local-books]
        [%pass /discussions %agent [our.bol %books-store] %watch /discussions]
      ::
        =+  [%add dap.bol /tile '/~books/js/tile.js']
        [%pass /launch %agent [our.bol %launch] %poke %launch-action !>(-)]
      ::
        =+  [%invite-action !>([%create /books])]
        [%pass /invitatory/create %agent [our.bol %invite-store] %poke -]
      ::
        =+  /invitatory/books
        [%pass - %agent [our.bol %invite-store] %watch -]
    ==
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bol src.bol)
    :_  this
    ?+    mark  (on-poke:def mark vase)
        %handle-http-request
      =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
      %+  give-simple-payload:app  eyre-id
      %+  require-authorization:app  inbound-request
      poke-handle-http-request:do
    ::
        %books-view-action
      (handle-view-action:do !<(books-view-action vase))

    ::
    ==
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?:  ?|  ?=([%http-response *] path)
            ?=([%json %seen ~] path)
        ==
      `this
    ?.  ?=([%json @ @ *] path)
      (on-watch:def path)
    =/  p=@ud  (slav %ud i.t.path)
    ?+  t.t.path  (on-watch:def path)
        [%local-books ~]
      :_  this
      (give-initial-books:do p ~)
    ::
        [%local-books ^]
      :_  this
      (give-initial-books:do p t.t.t.path)
    ::
        [%discussions @ ^]
      :_  this
      (give-initial-discussions:do p (break-discussion-path t.t.t.path))
    ==

  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    ?+  -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      =/  app=term
        ?:  ?=([%invites *] wire)
          %invite-store
        %books-store
      [%pass wire %agent [our.bol app] %watch wire]~
    ::
        %fact
      =*  mark  p.cage.sign
      =*  vase  q.cage.sign
      ?+  mark  (on-agent:def wire sign)
        %invite-update  [(handle-invite-update:do !<(invite-update vase)) this]
        %books-initial   [~ this]
      ::
          %books-update
        :_  this
        ~[(send-update:do !<(update vase))]
      ==
    ==

  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?.  ?=(%bound +<.sign-arvo)
      (on-arvo:def wire sign-arvo)
    [~ this]
  ::
  ++  on-save   on-save:def
  ++  on-load   on-load:def
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-fail   on-fail:def
  --
::
::
|_  bol=bowl:gall
::
+*  md  ~(. metadata bol)
::
++  poke-handle-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  url=(parse-request-line url.request.inbound-request)
  ?+  site.url  not-found:gen
      [%'~books' %css %index ~]  (css-response:gen style)
      [%'~books' %js %tile ~]    (js-response:gen tile-js)
      [%'~books' %js %index ~]   (js-response:gen script)
  ::
      [%'~books' %img @t *]
    =/  name=@t  i.t.t.site.url
    =/  img  (~(get by books-png) name)
    ?~  img
      not-found:gen
    (png-response:gen (as-octs:mimes:html u.img))
  ::
      [%'~books' %oauth-url ~]
    %-  json-response:gen
    %-  json-to-octs
    %-  oauth-url-to-json
    oauth-url-scry
  ::
      [%'~books' *]  (html-response:gen index)
  ==
::
++  do-poke
  |=  [app=term =mark =vase]
  ^-  card
  [%pass /create/[app]/[mark] %agent [our.bol app] %poke mark vase]
::
++  handle-view-action
  |=  act=books-view-action
  ^-  (list card)
  ?-  -.act
    %create         (handle-create +.act)
    %delete         (handle-delete +.act)
    %invite         (handle-invite +.act)
  ==
::
++  handle-create
  |=  [=path title=@t description=@t members=create-members real-group=?]
  ^-  (list card)
  =/  group-path=^path
    ?-  -.members
      %group  path.members
    ::
        %ships
      %+  weld
        ?:(real-group ~ [~.~]~)
      [(scot %p our.bol) path]
    ==
  =;  group-setup=(list card)
    %+  weld  group-setup
    :~  ::  add collection to metadata-store
        ::
        %^  do-poke  %metadata-hook
          %metadata-action
        !>  ^-  metadata-action:md
        :^  %add  group-path
          [%books path]
        %*  .  *metadata:md
          title         title
          description   description
          date-created  now.bol
          creator       our.bol
        ==
      ::
        ::  expose the metadata
        ::
        %^  do-poke  %metadata-hook
          %metadata-hook-action
        !>  ^-  metadata-hook-action:metadata-hook
        [%add-owned group-path]
    ==
  ?:  ?=(%group -.members)  ~
  ::  if the group is "real", make contact-view do the heavy lifting
  ::
  ?:  real-group
    :_  ~
    %^  do-poke  %contact-view
      %contact-view-action
    !>  ^-  contact-view-action:contact-view
    [%create group-path ships.members title description]
  ::  for "unmanaged" groups, do it ourselves
  ::
  :*  ::  create the new group
      ::
      %^  do-poke  %group-store
        %group-action
      !>  ^-  group-action:group-store
      [%bundle group-path]
    ::
      ::  fill the new group
      ::
      %^  do-poke  %group-store
        %group-action
      !>  ^-  group-action:group-store
      [%add (~(put in ships.members) our.bol) group-path]
    ::
      ::  make group available
      ::
      %^  do-poke  %group-hook
        %group-hook-action
      !>  ^-  group-hook-action:group-hook
      [%add our.bol group-path]
    ::
      ::  mirror group into a permission
      ::
      %^  do-poke  %permission-group-hook
        %permission-group-hook-action
      !>  ^-  permission-group-hook-action:permission-group-hook
      [%associate group-path [group-path^%white ~ ~]]
    ::
      ::  expose the permission
      ::
      %^  do-poke  %permission-hook
        %permission-hook-action
      !>  ^-  permission-hook-action:permission-hook
      [%add-owned group-path group-path]
    ::
      ::  send invites
      ::
      %+  turn  ~(tap in ships.members)
      |=  =ship
      ^-  card
      %^  do-poke  %invite-hook
        %invite-action
      !>  ^-  invite-action
      :^  %invite  /books
        (sham group-path eny.bol)
      :*  our.bol
          %group-hook
          group-path
          ship
          title
      ==
  ==
::
++  handle-delete
  |=  =path
  ^-  (list card)
  =/  groups=(list ^path)
    (groups-from-resource:md [%books path])
  %+  snoc
    ^-  (list card)
    %-  zing
    %+  turn  groups
    |=  =group=^path
    %+  snoc
      ^-  (list card)
      ::  if it's a real group, we can't/shouldn't unsync it. this leaves us with
      ::  no way to stop propagation of collection deletion.
      ::
      ?.  ?=([%'~' ^] group-path)  ~
      ::  if it's an unmanaged group, we just stop syncing the group & metadata,
      ::  and clean up the group (after un-hooking it, to not push deletion).
      ::
      :~  %^  do-poke  %group-hook
            %group-hook-action
          !>  ^-  group-hook-action:group-hook
          [%remove group-path]
        ::
          %^  do-poke  %metadata-hook
            %metadata-hook-action
          !>  ^-  metadata-hook-action:metadata-hook
          [%remove group-path]
        ::
          %^  do-poke  %group-store
            %group-action
          !>  ^-  group-action:group-store
          [%unbundle group-path]
      ==
    ::  remove collection from metadata-store
    ::
    %^  do-poke  %metadata-store
      %metadata-action
    !>  ^-  metadata-action:md
    [%remove group-path [%books path]]
  ::  delete shelf from books-store
  ::
  %^  do-poke  %books-store
    %books-action
  !>  ^-  books-action
  [%delete path]
::
++  handle-invite
  |=  [=path ships=(set ship)]
  ^-  (list card)
  %-  zing
  %+  turn  (groups-from-resource:md %books path)
  |=  =group=^path
  ^-  (list card)
  :-  %^  do-poke  %group-store
        %group-action
      !>  ^-  group-action:group-store
      [%add ships group-path]
  ::  for managed groups, rely purely on group logic for invites
  ::
  ?.  ?=([%'~' ^] group-path)
    ~
  ::  for unmanaged groups, send invites manually
  ::
  %+  turn  ~(tap in ships)
  |=  =ship
  ^-  card
  %^  do-poke  %invite-hook
    %invite-action
  !>  ^-  invite-action
  :^  %invite  /books
    (sham group-path eny.bol)
  :*  our.bol
      %group-hook
      group-path
      ship
      (rsh 3 1 (spat path))
  ==
::
++  oauth-url-scry
  ^-  @t
  .^  @t
    %gx
    (scot %p our.bol)
    %books-import-hook
    (scot %da now.bol)
    `path`~[%goodreads-oauth-url %noun]
  ==
::
++  oauth-url-to-json
  |=  url=@t
  =,  enjs:format
  ^-  json
  [%s url]
::
++  book-to-json
  |=  =book
  ^-  json
  =,  enjs:format
  %-  pairs
  :~  [%id (numb id.book)]
      [%title s+title.book]
      [%author s+author.book]
      [%rating ?~(rating.book ~ (numb u.rating.book))]
      [%pages (numb pages.book)]
      [%published s+(crip (dust:chrono:userlib (yore published.book)))]
      [%added (time added.book)]
      [%read ?~(read.book ~ (time u.read.book))]
      [%'coverUrl' s+cover-url.book]
  ==
::  +give-initial-books: page of submissions on path
::
::    for the / path, give page for every path
::
::    result is in the shape of: {
::      "/some/path": {
::        totalItems: 1,
::        totalPages: 1,
::        pageNumber: 0,
::        books: [
::          { commentCount: 1, ...restOfTheBooks }
::        ]
::      },
::      "/maybe/more": { etc }
::    }
::
++  give-initial-books
  |=  [p=@ud =path]
  ^-  (list card)
  :_  ?:  =(0 p)  ~
      [%give %kick ~ ~]~
  =;  =json
    [%give %fact ~ %json !>(json)]
  %+  frond:enjs:format  'initial-books'
  %-  pairs:enjs:format
  %+  turn
    %~  tap  by
    %+  scry-for  (map ^path books)
    [%local-books path]
  |=  [=^path =books]
  ^-  [@t json]
  :-  (spat path)
  %^  page-to-json  p
    %+  get-paginated  `p
    books
  |=  =book
  ^-  json
  =/  =json  (book-to-json book)
  ?>  ?=([%o *] json)
  ::  add in comment count
  ::
  =;  comment-count=@ud
    :-  %o
    %+  ~(put by p.json)  'commentCount'
    (numb:enjs:format comment-count)
  %-  lent
  ~|  [path id.book]
  ^-  comments
  =-  (~(got by (~(got by -) path)) id.book)
  %+  scry-for  (per-path-url comments)
  :-  %discussions
  (build-discussion-path path id.book)
::
++  page-size  25
::
++  get-paginated
  |*  [p=(unit @ud) l=(list)]
  ^-  [total=@ud pages=@ud page=_l]
  :+  (lent l)
    %+  add  (div (lent l) page-size)
    (min 1 (mod (lent l) page-size))
  ?~  p  l
  %+  scag  page-size
  %+  slag  (mul u.p page-size)
  l
::
++  page-to-json
  =,  enjs:format
  |*  $:  page-number=@ud
          [total-items=@ud total-pages=@ud page=(list)]
          item-to-json=$-(* json)
      ==
  ^-  json
  %-  pairs
  :~  'totalItems'^(numb total-items)
      'totalPages'^(numb total-pages)
      'pageNumber'^(numb page-number)
      'page'^a+(turn page item-to-json)
  ==
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
++  give-initial-discussions
  |=  [p=@ud =path id=@]
  ^-  (list card)
  :_  ?:  =(0 p)  ~
      [%give %kick ~ ~]~
  =;  =json
    [%give %fact ~ %json !>(json)]
  %+  frond:enjs:format  'initial-discussions'
  %^  page-to-json  p
    %+  get-paginated  `p
    =-  (~(got by (~(got by -) path)) id)
    %+  scry-for  (per-path-url comments)
    [%discussions (build-discussion-path path id)]
  comment-to-json
::
++  note-to-json
  =,  enjs:format
  |=  =note:books-store
  ^-  json
  %-  pairs
  :~  'time'^(time time.note)
      'udon'^s+udon.note  ::TODO  convert?
  ==
::
++  comment-to-json
  =,  enjs:format
  |=  =comment
  ^-  json
  =+  n=(note-to-json +.comment)
  ?>  ?=([%o *] n)
  o+(~(put by p.n) 'ship' (ship ship.comment))
::
++  update-to-json
  =,  enjs:format
  |=  upd=update
  ^-  json
  %-  frond
  :-  -.upd
  ?-  -.upd
      %local-books
    %-  pairs
    :~  'path'^(path path.upd)
        'pages'^a+(turn books.upd book-to-json)
    ==
  ::
      %annotations
    %-  pairs
    :~  'path'^(path path.upd)
        'id'^n+id.upd
        'notes'^a+(turn notes.upd note-to-json)
    ==
      %discussions
    %-  pairs
    :~  'path'^(path path.upd)
        'id'^n+id.upd
        'comments'^a+(turn comments.upd comment-to-json)
    ==
  ==

++  break-discussion-path
  |=  =path
  ^-  [=^path id=@]
  ?~  path  [/ 0]
  :-  t.path
  ?:  =(~ i.path)  0
  ~|  path
  (rash (slav %ta i.path) dem)
::
++  send-update
  |=  =update
  ^-  card
  ?+  -.update  ~|([dap.bol %unexpected-update -.update] !!)
      %local-books
    %+  give-json
      (update-to-json update)
    :~  /json/0/local-books
        (weld /json/0/local-books path.update)
    ==
  ::
      %discussions
    %+  give-json
      (update-to-json update)
    :_  ~
    %+  weld  /json/0/discussions
    (build-discussion-path [path id]:update)
  ==
::
++  handle-invite-update
  |=  upd=invite-update
  ^-  (list card)
  ?.  ?=(%accepted -.upd)  ~
  ?.  =(/books path.upd)   ~
  :~  ::  sync the group
      ::
      %^  do-poke  %group-hook
        %group-hook-action
      !>  ^-  group-hook-action:group-hook
      [%add ship path]:invite.upd
    ::
      ::  sync the metadata
      ::
      %^  do-poke  %metadata-hook
        %metadata-hook-action
      !>  ^-  metadata-hook-action:metadata-hook
      [%add-synced ship path]:invite.upd
  ==
::
++  generate-nonce
  |=  eny=@uvJ
  ^-  @t
  %-  crip
  %+  turn
    :~  eny
        +(eny)
        (add 2 eny)
        (add 3 eny)
        (add 4 eny)
        (add 5 eny)
        (add 6 eny)
        (add 7 eny)
        (add 8 eny)
        (add 9 eny)
        (add 10 eny)
    ==
  generate-char
::
++  generate-char
  |=  eny=@uvJ
  ^-  @t
  =/  rng  ~(. og eny)
  :: lowercase a-z
  `@`(add 97 (rad:rng 25))
::
++  get-s-time
  |=  now=@da
  ^-  @t
  =/  =json  (time now)
  ?>  ?=(%n -.json)
  p.json
::
++  time
  |=  a/^time
  =-  (numb:enjs:format (div - ~s1))
  (add (div ~s1 2.000) (sub a ~1970.1.1))
::
++  add-quotes
  |=  s=@t
  ^-  @t
  (crip (snoc (into (trip s) 0 '"') '"'))
::
++  give-json
  |=  [=json paths=(list path)]
  ^-  card
  [%give %fact paths %json !>(json)]
::
++  scry-for
  |*  [=mold =path]
  .^  mold
    %gx
    (scot %p our.bol)
    %books-store
    (scot %da now.bol)
    (snoc `^path`path %noun)
  ==
--

