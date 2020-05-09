/-  *books-import-hook, *books-store, books-import-hook
/+  default-agent, verb, dbug
::
|%
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0
  $:  %0
      consumer-key=@t
      consumer-secret=@t
      oauth-token=@t
      oauth-secret=@t
      access-token=@t
      access-secret=@t
  ==
+$  card  card:agent:gall
--
=|  state-0
=*  state  -
::
%-  agent:dbug
%+  verb  |
^-  agent:gall
=<
  |_  bol=bowl:gall
  +*  this  .
      do    ~(. +> bol)
      def   ~(. (default-agent this %|) bol)
  ::
  ++  on-init  on-init:def
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bol src.bol)
    =^  cards  state
      ?+  mark  (on-poke:def mark vase)
          %books-import-action
        (handle-import-action:do !<(books-import-action vase))
      ==
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?.  ?=([%oauth-url ~] path)
      (on-watch:def path)
    :_  this
    :_  ~
    :*  %give
        %fact
        ~
        %books-import-update
        !>  :-  %oauth-url
        ?~  oauth-token  ''
        (cat 3 'https://goodreads.com/oauth/authorize?oauth_token=' oauth-token)
    ==
  ::
  ++  on-agent  on-agent:def
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    =^  cards  state
      ?:  ?=([%i %http-response %finished *] sign-arvo)
        ?+  wire  (on-arvo:def wire sign-arvo)
            [%request-token *]
          (handle-oauth-token:do full-file.client-response.sign-arvo)
            [%access-token *]
          [~ (handle-access-token:do full-file.client-response.sign-arvo)]
            [%import @ta @ta *]
          =/  page=@  (rash -.+.+.wire dem)
          =/  id=@t   -.+.+.+.wire
          =/  =path   +.+.+.+.wire
          :_  state
          (handle-import:do page id path full-file.client-response.sign-arvo)
        ==
      ?.  ?=(%bound +<.sign-arvo)
        (on-arvo:def wire sign-arvo)
      [~ state]
    [cards this]
  ::
  ++  on-save   on-save:def
  ++  on-load   on-load:def
  ++  on-leave  on-leave:def
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?+  path  (on-peek:def path)
        ::  .^(@t %gx (scot %p our) %books-import-hook (scot %da now) /goodreads-oauth-url/noun)
        [%x %goodreads-oauth-url ~]
      ?~  oauth-token
        ~
      ``noun+!>((cat 3 'https://goodreads.com/oauth/authorize?oauth_token=' oauth-token))
    ==
  ++  on-fail   on-fail:def
  --
::
::
|_  bol=bowl:gall
::
+*  md  ~(. metadata bol)
::
++  handle-import-action
  |=  act=books-import-action
  ^-  (quip card _state)
  ?-  -.act
      %request-token
    :_  state(consumer-key consumer-key.act, consumer-secret consumer-secret.act)
    (do-request-token +.act)
      %access-token
    :_  state
    (do-access-token)
      %import
    :_  state
    (do-import 1 +.act)
  ==
::
++  do-import
  |=  [page=@ =path id=@t]
  ^-  (list card)
  =/  url=@t
    %^  cat  3
      %^  cat  3
        %^  cat  3
          'https://www.goodreads.com/review/list/'
        id
      '.xml?v=2&per_page=200&order=a&sort=date_added&page='
    (crip (scow %ud page))
  =/  headers=header-list:http
    %-  generate-oauth-headers
    :*  url
        consumer-key.state
        consumer-secret.state
        access-token.state
        access-secret.state
    ==
  =/  req=request:http
    [%'GET' url headers ~]
  :_  ~
  :*  %pass
      (weld (weld (weld (weld /import /[(scot %da now.bol)]) /[(scot %ud page)]) /[id]) path)
      %arvo
      %i
      %request
      req
      *outbound-config:iris
  ==
::
++  do-access-token
  |.
  ^-  (list card)
  =/  req=request:http
    %-  generate-goodreads-request
    :*  'https://www.goodreads.com/oauth/access_token'
        consumer-key.state
        consumer-secret.state
        oauth-token.state
        oauth-secret.state
    ==
  ~&  req
  [%pass /access-token/[(scot %da now.bol)] %arvo %i %request req *outbound-config:iris]~
::
++  generate-oauth-headers
  |=  [url=@t consumer-key=@t consumer-secret=@t oauth-token=@t token-secret=@t]
  ^-  header-list:http
  =/  purl=(unit purl:eyre)  (de-purl:html url)
  ?~  purl  !!
  =/  query-params=(list [@t @t])  r.u.purl
  =/  base=(list [@t @t])
      ::  oauth headers alphabetically sorted by key
      ::
      %+  sort
      %+  weld
      %+  turn
        query-params
      |=(a=[@t @t] [(cat 3 -.a '=') +.a])
      :*  ['oauth_consumer_key=' consumer-key]
          ['oauth_nonce=' (generate-nonce eny.bol)]
          ['oauth_signature_method=' 'HMAC-SHA1']
          ['oauth_timestamp=' (get-s-time now.bol)]
          ['oauth_version=' '1.0']
          ?~  oauth-token  ~
          ['oauth_token=' oauth-token]~
      ==
      |=([a=[@t @t] b=[@t @t]] (aor (trip -.a) (trip -.b)))
  =/  base-url=@t  (crip (en-purl:html u.purl(r ~)))
  =/  signature-base=@t
    %-  crip
    %+  join  '&'
    ^-  (list @t)
    :~  'GET'
        (en-url base-url)
        %-  en-url
        %-  crip
        %+  join  '&'
        %+  turn
          base
        |=  a=[@t @t]
        ^-  @t
        (cat 3 a)
    ==
  ~&  [%base signature-base]
  =/  signing-key=@t
    (cat 3 (cat 3 (en-url consumer-secret) '&') (en-url token-secret))
  ~&  [%key signing-key]
  =/  oauth-signature=@t
    (en-url (en-base64 (hmac-sha1t:hmac:crypto signing-key signature-base)))
  ~&  [%signature oauth-signature]
  :_  ~
  :-  'Authorization'
  %^  cat  3  'OAuth '
  %-  crip
  %+  join  ','
  %+  turn
    (snoc base ['oauth_signature=' oauth-signature])
  |=  [key=@t value=@t]
  ^-  @t
  (cat 3 key (add-quotes value))

::
++  generate-goodreads-request
  |=  [url=@t consumer-key=@t consumer-secret=@t oauth-token=@t token-secret=@t]
  ^-  request:http
  =/  headers=header-list:http
    (generate-oauth-headers url consumer-key consumer-secret oauth-token token-secret)
  [%'GET' url headers ~]
::
++  en-url
  |=  s=@t
  ^-  @t
  (crip (en-urlt:html (trip s)))
::
++  do-request-token
  |=  [consumer-key=@t consumer-secret=@t]
  ^-  (list card)
  =/  req=request:http
    %-  generate-goodreads-request
    :*  'https://www.goodreads.com/oauth/request_token'
        consumer-key
        consumer-secret
        ''
        ''
    ==
  ~&  req
  [%pass /request-token/[(scot %da now.bol)] %arvo %i %request req *outbound-config:iris]~
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
++  update-subscribers
  |=  [pax=path =update:books-import-hook]
  ^-  (list card)
  [%give %fact ~[pax] %books-import-update !>(update)]~

::
++  handle-oauth-token
  |=  f=(unit mime-data:iris)
  ^-  (quip card _state)
  ?~  f  !!
  =/  oauth  (parse-oauth-token q.data.u.f)
  :_  state(oauth-token oauth-token.oauth, oauth-secret oauth-secret.oauth)
  %+  update-subscribers
    /oauth-url
  :-  %oauth-url
  %^  cat  3
    'https://goodreads.com/oauth/authorize?oauth_token='
  oauth-token.oauth
::
++  handle-access-token
  |=  f=(unit mime-data:iris)
  ^-  _state
  ?~  f  !!
  =/  oauth  (parse-oauth-token q.data.u.f)
  state(access-token oauth-token.oauth, access-secret oauth-secret.oauth)
::
++  get-from-book
  |=  [review=manx s=@tas]
  ^-  @t
  =/  val  c.i.-:(skim c.i.-.t.+.c.review |=(a=manx =(s n.g.a)))
  ?~  val  ''
  (crip v.i.-.a.g.i.-.val)
::
++  get-from-book-default
  |=  [review=manx s=@tas default=@t]
  ^-  @t
  =/  res=@t  (get-from-book review s)
  ?:  =('' res)  default
  res
::
++  get-published
  |=  review=manx
  ^-  @da
  %-  year
  :*  [%.y (rash (get-from-book-default review %'publication_year' '1970') dem)]
      (rash (get-from-book-default review %'publication_month' '1') dem)
      [(rash (get-from-book-default review %'publication_day' '1') dem) 0 0 0 ~]
  ==
::
++  get-author
  |=  review=manx
  ^-  @t
  =/  name-elem
    %+  skim
      c.i.-.c.i.-:(skim c.i.-.t.+.c.review |=(a=manx =(%authors n.g.a)))
    |=(a=manx =(%name n.g.a))
  (crip v.i.-.a.g.i.-.c.i.-.name-elem)
::
++  get-rating
  |=  review=manx
  ^-  (unit rating)
  ?~  review  !!
  =/  rating-elem  (skim c.review |=(a=manx =(%rating n.g.a)))
  ?~  rating-elem  !!
  =/  r=@  (rash (crip v.i.-.a.g.i.-.c.i.rating-elem) dem)
  ?:  =(0 r)  ~
  [~ (rating r)]
::
++  get-read
  |=  review=manx
  ^-  (unit @da)
  =/  read-elem  (skim c.review |=(a=manx =(%'read_at' n.g.a)))
  ?~  read-elem  !!
  ?~  c.i.read-elem  ~
  =/  res=(unit date)  (stud:chrono:userlib (crip v.i.-.a.g.i.-.c.i.-.read-elem))
  ?~  res  ~
  [~ (year u.res)]
::
++  handle-import
  |=  [page=@ id=@t =path f=(unit mime-data:iris)]
  ^-  (list card)
  ?~  f  !!
  ::  remove first row <?xml version="1.0" encoding="UTF-8"?>
  =/  parsed=(unit manx)  (de-xml:html (crip (slag 39 (trip q.data.u.f))))
  ?~  parsed  !!
  =/  end=@  (rash (crip v.i.-.+.a.g.-.-.+.c.u.parsed) dem)
  =/  total=@  (rash (crip v.i.-.t.+.+.a.g.-.-.+.c.u.parsed) dem)
  =/  next-page=(list card)
    ?:  =(end total)  ~
    (do-import +(page) path id)
  ~&  [%end end]
  ~&  [%total total]
  =/  reviews=marl  c.i.-.+.c.u.parsed
  =/  books=(list card)
    %+  turn
      reviews
    |=  review=manx
    ^-  card
    =/  book=book-to-be-added
      :*  (get-from-book review %title)
          (get-from-book review %'image_url')
          (get-author review)
          (get-rating review)
          (rash (get-from-book-default review %'num_pages' '0') dem)
          (get-published review)
          (get-read review)
      ==
    %^  do-poke  %books-store
      %books-action
    !>  ^-  books-action
    [%add path book]
  ~&  (lent books)
  (weld next-page books)
::
++  parse-oauth-token
  |=  raw-token=@t
  ^-  [oauth-token=@t oauth-secret=@t]
  =/  parser
    ;~  (glue pad)
      ;~  (glue tis)
          (jest 'oauth_token')
          (star aln)
      ==
      ;~  (glue tis)
          (jest 'oauth_token_secret')
          (star aln)
      ==
    ==
  =/  parsed=[[@t tape] [@t tape]]  (rash raw-token parser)
  [(crip +.-.parsed) (crip +.+.parsed)]
::
++  do-poke
  |=  [app=term =mark =vase]
  ^-  card
  [%pass /create/[app]/[mark] %agent [our.bol app] %poke mark vase]
:: en-base64: works for arbitrary @, does not work with @t
::
++  en-base64
  |=  tig=@
  ^-  @t
  =+  pad-num=(~(dif fo 3) 0 (met 3 tig))
  =+  pad=(ripn 6 (lsh 3 pad-num tig))
  =/  cha=@t
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  %-  crip
  %+  weld
    %-  flop
    %+  slag
      pad-num
    %+  turn
      pad
    |=  c=@
    ^-  @t
    (cut 3 [c 1] cha)
  (reap pad-num '=')
--
