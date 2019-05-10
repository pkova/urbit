!:  ::  %gall, agent execution
!?  163
!:
::::
|=  pit=vase
=,  gall
=>  =~
::
::  (rest of arvo)
::
|%
::
::  +coke: cook.
::
++  coke
  $?  %inn
      %out
      %cay
  ==
::
::  +volt: voltage.
::
++  volt  ?(%low %high)
::
::  +security-control: security control.
::
++  security-control  $@(?(%iron %gold) [%lead p=ship])
::
::  +reverse-ames: reverse ames message.
::
++  reverse-ames
  $%
      :: diff
      ::
      [action=%d p=mark q=*]
      ::  etc.
      ::
      [action=%x ~]
  ==
::
::  +forward-ames: forward ames message.
::
++  forward-ames
  $%
      :: message
      ::
      [action=%m mark=mark noun=*]
      :: "peel" subscribe
      ::
      [action=%l mark=mark path=path]
      :: subscribe
      ::
      [action=%s path=path]
      :: cancel+unsubscribe
      ::
      [action=%u ~]
  ==
::
::  +foreign-response: foreign response.
::
++  foreign-response
  $?  %peer
      %peel
      %poke
      %pull
  ==
--
::
::  (local arvo)
::
|%
::
::  +cote: +ap note.
::
++  cote
  $%  [note=%meta =term =vase]
      [note=%send =ship =cush]
      [note=%hiss knot=(unit knot) =mark =cage]
  ==
::
::  +internal-move: internal move.
::
++  internal-move
  $:
    =bone
    move=(wind cote cuft)
  ==
::
::  +move: typed move.
::
++  move  (pair duct (wind note-arvo gift-arvo))
--
::
::  (%gall state)
::
|%
::
::  +gall-n: upgrade path.
::
++  gall-n  ?(gall)
::
::  +gall: all state.
::
++  gall
  $:
      :: state version
      ::
      %0
      :: apps by ship
      ::
      =ship-state
  ==
::
::  +subscriber-data: subscriber data.
::
++  subscriber-data
  $:
      :: incoming subscribers
      ::
      incoming=bitt
      :: outgoing subscribers
      ::
      outgoing=boat
      :: queue meter
      ::
      meter=(map bone @ud)
  ==
::
::  +ship-state: ship state.
::
++  ship-state
  $:
      :: (deprecated)
      ::
      mak=*
      ::  system duct
      ::
      system-duct=duct
      ::  foreign contacts
      ::
      contacts=(map ship foreign)
      ::  running agents
      ::
      running=(map dude agent)
      ::  waiting queue
      ::
      waiting=(map dude blocked)
  ==
::
::  +routes: new cuff.
::
++  routes
    $:
        :: disclosing to
        ::
        disclosing=(unit (set ship))
        :: attributed to
        ::
        attributing=ship
    ==
::
::  +privilege: privilege.
::
++  privilege
    $:
        :: voltage
        ::
        =volt
        :: routes
        ::
        =routes
    ==
::
::  +foreign: foreign connections.
::
++  foreign
  $:
      :: index
      ::
      index=@ud
      :: by duct
      ::
      index-map=(map duct @ud)
      :: by index
      ::
      duct-map=(map @ud duct)
  ==
::
::  +opaque-input: opaque input.
::
++  opaque-input
  $:
      :: bone sequence
      ::
      bone=@ud
      :: by duct
      ::
      bone-map=(map duct bone)
      :: by bone
      ::
      duct-map=(map bone duct)
  ==
::
::  +misvale-data: subscribers with bad marks.
::
::    XX a hack, required to break a subscription loop
::    which arises when an invalid mark crashes a diff.
::    See usage in ap-misvale.
::
++  misvale-data  (set wire)
::
::  +agent: agent state.
::
++  agent
  $:
      :: bad reqs
      ::
      misvale=misvale-data
      :: cache
      ::
      cache=worm
      :: ap-find cache
      ::
      find-cache=(map [term path] (unit (pair @ud term)))
      :: control duct
      ::
      control-duct=duct
      :: unstopped
      ::
      live=?
      :: privilege
      ::
      privilege=security-control
      :: statistics
      ::
      stats=stats
      :: subscribers
      ::
      subscribers=subscriber-data
      :: running state
      ::
      running-state=vase
      :: update control
      ::
      beak=beak
      :: req'd translations
      ::
      required-trans=(map bone mark)
      :: opaque ducts
      ::
      ducts=opaque-input
  ==
::
:: +blocked: blocked kisses.
::
++  blocked  (qeu (trel duct privilege club))
::
:: +stats: statistics.
::
++  stats
  $:
      :: change number
      ::
      change=@ud
      :: entropy
      ::
      eny=@uvJ
      :: time
      ::
      time=@da
  ==
--
::
:: (vane header)
::
.  ==
::
:: (all vane state)
::
=|  =gall
|=  $:
        :: identity
        ::
        our=ship
        :: urban time
        ::
        now=@da
        :: entropy
        ::
        eny=@uvJ
        :: activate
        ::
        ska=sley
    ==
::
::  (opaque core)
::
~%  %gall-top  ..is  ~
::
::  (state machine)
::
|%
::
::  +gall-payload:  gall payload.
::
++  gall-payload  +
::
::  +mo: move handling.
::
++  mo
  ~%  %gall-mo  +>  ~
  ::
  |_
    $:
      hen=duct
      moves=(list move)
    ==
  ::
  ++  mo-state  .
  ::
  ::  +mo-abed: initialise engine with the provided duct.
  ::
  ++  mo-abed
    |=  =duct
    ^+  mo-state
    ::
    mo-state(hen duct)
  ::
  ::  +mo-abet: resolve moves.
  ::
  ++  mo-abet
    ^-  [(list move) _gall-payload]
    ::
    =/  resolved  (flop moves)
    [resolved gall-payload]
  ::
  ::  +mo-boot: pass a %build move to ford.
  ::
  ++  mo-boot
    |=  [=dude =ship =desk]
    ^+  mo-state
    ::
    =/  =case  [%da now]
    ::
    =/  =path
      =/  ship  (scot %p ship)
      =/  case  (scot case)
      /sys/core/[dude]/[ship]/[desk]/[case]
    ::
    =/  =note-arvo
      =/  disc  [ship desk]
      =/  spur  /hoon/[dude]/app
      =/  schematic  [%core disc spur]
      [%f %build live=%.y schematic]
    ::
    =/  pass  [path note-arvo]
    (mo-pass pass)
  ::
  ::  +mo-pass: prepend a standard %pass move to the move state.
  ::
  ++  mo-pass
    |=  pass=(pair path note-arvo)
    ^+  mo-state
    ::
    =/  =move  [hen [%pass pass]]
    mo-state(moves [move moves])
  ::
  ::  +mo-give: prepend a standard %give move to the move state.
  ::
  ++  mo-give
    |=  =gift:able
    ^+  mo-state
    ::
    =/  =move  [hen [%give gift]]
    mo-state(moves [move moves])
  ::
  :: +mo-okay: check that a vase contains a valid bowl.
  ::
  ++  mo-okay
    ~/  %mo-okay
    |=  =vase
    ^-  ?
    ::
    ::  inferred type of default bowl
    =/  bowl-type  -:!>(*bowl)
    ::
    =/  maybe-vase  (slew 12 vase)
    ?~  maybe-vase
      %.n
    ::
    =/  =type  p.u.maybe-vase
    (~(nest ut type) %.n bowl-type)
  ::
  ::  +mo-receive-core: receives an app core built by ford.
  ::
  ++  mo-receive-core
    ~/  %mo-receive-core
    |=  [=dude =beak =made-result:ford]
    ^+  mo-state
    ::
    ?:  ?=([%incomplete *] made-result)
      (mo-give %onto %.n tang.made-result)
    ::
    =/  build-result  build-result.made-result
    ::
    ?:  ?=([%error *] build-result)
      (mo-give %onto %.n message.build-result)
    ::
    =/  =cage  (result-to-cage:ford build-result)
    =/  result-vase  q.cage
    ::
    =/  app-data=(unit agent)
      (~(get by running.ship-state.gall) dude)
    ::
    ?^  app-data
      ::  update the path
      ::
      =/  updated  u.app-data(beak beak)
      ::
      =.  running.ship-state.gall
        (~(put by running.ship-state.gall) dude updated)
      ::
      ::  magic update string from the old +mo-boon, "complete old boot"
      ::
      =/  =privilege
        =/  =routes  [disclosing=~ attributing=our]
        [%high routes]
      ::
      =/  initialised  (ap-abed:ap dude privilege)
      =/  peeped  (ap-peep:initialised result-vase)
      ap-abet:peeped
    ::  first install of the app
    ::
    ?.  (mo-okay result-vase)
      =/  err  [[%leaf "{<dude>}: bogus core"] ~]
      (mo-give %onto %.n err)
    ::
    =.  mo-state  (mo-born dude beak result-vase)
    ::
    =/  old  mo-state
    ::
    =/  wag
      =/  =routes  [disclosing=~ attributing=our]
      =/  =privilege  [%high routes]
      =/  initialised  (ap-abed:ap dude privilege)
      (ap-prop:initialised ~)
    ::
    =/  maybe-tang  -.wag
    =/  new  +.wag
    ::
    ?^  maybe-tang
      =.  mo-state  old
      (mo-give %onto %.n u.maybe-tang)
    ::
    =.  mo-state  ap-abet:new
    ::
    =/  clawed  (mo-claw dude)
    (mo-give:clawed %onto %.y dude %boot now)
  ::
  ::  +mo-born: create a new agent.
  ::
  ++  mo-born
    |=  [=dude =beak =vase]
    ^+  mo-state
    ::
    =/  =opaque-input
      :+  bone=1
        bone-map=[[[~ ~] 0] ~ ~]
       duct-map=[[0 [~ ~]] ~ ~]
    ::
    =/  agent
      =/  default-agent  *agent
      %_  default-agent
        control-duct    hen
        beak            beak
        running-state   vase
        ducts           opaque-input
      ==
    ::
    =/  agents
      (~(put by running.ship-state.gall) dude agent)
    ::
    %_  mo-state
      running.ship-state.gall  agents
    ==
  ::
  :: +mo-away: handle a foreign request.
  ::
  ++  mo-away
    ~/  %mo-away
    |=  [=ship =cush]
    ^+  mo-state
    ::
    =/  =dude  p.cush
    =/  =club  q.cush
    ::
    ?:  ?=(%pump -.club)
      ::
      ::  you'd think this would send an ack for the diff
      ::  that caused this pump.  it would, but we already
      ::  sent it when we got the diff in ++mo-cyst.  then
      ::  we'd have to save the network duct and connect it
      ::  to this returning pump.
      ::
      mo-state
    ::
    ?:  ?=(%peer-not -.club)
      =/  =tang  p.club
      =/  err  (some tang)
      (mo-give %unto %reap err)
    ::
    =^  bone  mo-state  (mo-bale ship)
    ::
    =/  =forward-ames
      ?-  -.club
        %poke  [%m p.p.club q.q.p.club]
        %pull  [%u ~]
        %puff  !!
        %punk  !!
        %peel  [%l club]
        %peer  [%s p.club]
      ==
    ::
    =/  =path
      =/  action  -.club
      /sys/way/[action]
    ::
    =/  =note-arvo  [%a %want ship [%g %ge dude ~] [bone forward-ames]]
    ::
    (mo-pass path note-arvo)
  ::
  ::  +mo-awed: handle foreign response.
  ::
  ++  mo-awed
    |=  [=foreign-response art=(unit ares)]
    ^+  mo-state
    ::
    =/  =ares
      =/  tanks  [%blank ~]
      =/  tang  (some tanks)
      (fall art tang)
    ::
    =/  to-tang
      |=  ars=(pair term tang)
      ^-  tang
      =/  tape  (trip p.ars)
      [[%leaf tape] q.ars]
    ::
    =/  result  (bind ares to-tang)
    ::
    ?-  foreign-response
      %peel  (mo-give %unto %reap result)
      %peer  (mo-give %unto %reap result)
      %poke  (mo-give %unto %coup result)
      %pull  mo-state
    ==
  ::
  ::  +mo-bale: assign an out bone.
  ::
  ++  mo-bale
    |=  =ship
    ^-  [bone _mo-state]
    ::
    =/  =foreign
      =/  existing  (~(get by contacts.ship-state.gall) ship)
      (fall existing [1 ~ ~])
    ::
    =/  existing  (~(get by index-map.foreign) hen)
    ::
    ?^  existing
      [u.existing mo-state]
    ::
    =/  index  index.foreign
    ::
    =/  new-foreign
      %_  foreign
        index      +(index)
        index-map  (~(put by index-map.foreign) hen index)
        duct-map   (~(put by duct-map.foreign) index hen)
      ==
    ::
    =/  contacts  (~(put by contacts.ship-state.gall) ship new-foreign)
    ::
    =/  next
      %_  mo-state
        contacts.ship-state.gall  contacts
      ==
    ::
    [index next]
  ::
  ::  +mo-ball: retrieve an out bone by index.
  ::
  ++  mo-ball
    |=  [=ship index=@ud]
    ^-  duct
    ::
    =/  =foreign  (~(got by contacts.ship-state.gall) ship)
    (~(got by duct-map.foreign) index)
  ::
  ::  +mo-cyst-core: receive a core.
  ::
  ++  mo-cyst-core
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?>  ?=([%f %made *] sign-arvo)
    ?>  ?=([@ @ @ @ @ ~] path)
    ::
    =/  beak-path  t.t.path
    ::
    =/  =beak
      =/  =ship  (slav %p i.beak-path)
      =/  =desk  i.t.beak-path
      =/  =case  [%da (slav %da i.t.t.beak-path)]
      [p=ship q=desk r=case]
    ::
    (mo-receive-core i.t.path beak result.sign-arvo)
  ::
  ::  +mo-cyst-pel: translated peer.
  ::
  ++  mo-cyst-pel
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?>  ?=([%f %made *] sign-arvo)
    ?>  ?=([@ @ ~] path)
    ::
    ?:  ?=([%incomplete *] result.sign-arvo)
      =/  err  (some tang.result.sign-arvo)
      (mo-give %unto %coup err)
    ::
    =/  build-result  build-result.result.sign-arvo
    ::
    ?:  ?=([%error *] build-result)
      =/  err  (some message.build-result)
      (mo-give %unto %coup err)
    ::
    =/  =cage  (result-to-cage:ford build-result)
    (mo-give %unto %diff cage)
  ::
  ::  +mo-cyst-red: diff ack.
  ::
  ++  mo-cyst-red
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?>  ?=([@ @ @ @ ~] path)
    ::
    ?.  ?=([%a %woot *] sign-arvo)
      ~&  [%red-want path]
      mo-state
    ::
    =/  him  (slav %p i.t.path)
    =/  dap  i.t.t.path
    =/  num  (slav %ud i.t.t.t.path)
    ::
    =/  =coop  q.+>.sign-arvo
    ::
    =/  sys-path
      =/  pax  [%req t.path]
      [%sys pax]
    ::
    ?~  coop
      =/  =note-arvo  [%g %deal [him our] dap %pump ~]
      (mo-pass sys-path note-arvo)
    ::
    =/  gall-move  [%g %deal [him our] dap %pull ~]
    =/  ames-move  [%a %want him [%g %gh dap ~] [num %x ~]]
    ::
    =.  mo-state  (mo-pass sys-path gall-move)
    =.  mo-state  (mo-pass sys-path ames-move)
    ::
    ?.  ?=([~ ~ %mack *] coop)
      ~&  [%diff-bad-ack coop]
      mo-state
    ~&  [%diff-bad-ack %mack]
    =/  slaw  (slog (flop q.,.+>.coop)) :: FIXME kill this lark
    (slaw mo-state)
  ::
  ::  +mo-cyst-rep: reverse request.
  ::
  ++  mo-cyst-rep
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?>  ?=([@ @ @ @ ~] path)
    ?>  ?=([%f %made *] sign-arvo)
    ::
    =/  him  (slav %p i.t.path)
    =/  dap  i.t.t.path
    =/  num  (slav %ud i.t.t.t.path)
    ::
    ?:  ?=([%incomplete *] result.sign-arvo)
      =/  err  (some tang.result.sign-arvo)
      (mo-give %mack err)
    ::
    =/  build-result  build-result.result.sign-arvo
    ::
    ?:  ?=([%error *] build-result)
      ::  "XX should crash"
      =/  err  (some message.build-result)
      (mo-give %mack err)
    ::
    ::  "XX pump should ack"
    =.  mo-state  (mo-give %mack ~)
    ::
    =/  duct  (mo-ball him num)
    =/  initialised  (mo-abed duct)
    ::
    =/  =cage  (result-to-cage:ford build-result)
    =/  move  [%unto [%diff cage]]
    ::
    (mo-give:initialised move)
  ::
  ::  +mo-cyst-req: inbound request.
  ::
  ++  mo-cyst-req
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?>  ?=([@ @ @ @ ~] path)
    ::
    =/  him  (slav %p i.t.path)
    =/  dap  i.t.t.path
    =/  num  (slav %ud i.t.t.t.path)
    ::
    ?:  ?=([%f %made *] sign-arvo)
      ?:  ?=([%incomplete *] result.sign-arvo)
        =/  err  (some tang.result.sign-arvo)
        (mo-give %mack err)
      ::
      =/  build-result  build-result.result.sign-arvo
      ::
      ?:  ?=([%error *] build-result)
        =/  err  (some message.build-result)
        (mo-give %mack err)
      ::
      =/  =cage  (result-to-cage:ford build-result)
      =/  sys-path  [%sys path]
      =/  =note-arvo  [%g %deal [him our] i.t.t.path %poke cage]
      ::
      (mo-pass sys-path note-arvo)
    ::
    ?:  ?=([%a %woot *] sign-arvo)
      mo-state
    ::
    ?>  ?=([%g %unto *] sign-arvo)
    ::
    =/  =cuft  +>.sign-arvo
    ::
    ?-    -.cuft
        ::
        %coup
        ::
      (mo-give %mack p.cuft)
        ::
        %diff
        ::
      =/  sys-path  [%sys %red t.path]
      =/  =note-arvo
        =/  path  [%g %gh dap ~]
        =/  noun  [num %d p.p.cuft q.q.p.cuft]
        [%a %want him path noun]
      ::
      (mo-pass sys-path note-arvo)
        ::
        %quit
        ::
      =/  sys-path  [%sys path]
      =/  =note-arvo
        =/  path  [%g %gh dap ~]
        =/  noun  [num %x ~]
        [%a %want him path noun]
      ::
      (mo-pass sys-path note-arvo)
        ::
        %reap
        ::
      (mo-give %mack p.cuft)
    ==
  ::
  ::  +mo-cyst-val: inbound validate.
  ::
  ++  mo-cyst-val
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?>  ?=([%f %made *] sign-arvo)
    ?>  ?=([@ @ @ ~] path)
    ::
    =/  =ship  (slav %p i.t.path)
    =/  =dude  i.t.t.path
    ::
    ?:  ?=([%incomplete *] result.sign-arvo)
      =/  err  (some tang.result.sign-arvo)
      (mo-give %unto %coup err)
    ::
    =/  build-result  build-result.result.sign-arvo
    ::
    ?:  ?=([%error *] build-result)
      =/  err  (some message.build-result)
      (mo-give %unto %coup err)
    ::
    =/  =privilege
      =/  =routes  [disclosing=~ attributing=ship]
      [%high routes]
    ::
    =/  =cage  (result-to-cage:ford build-result)
    =/  =club  [%poke cage]
    (mo-clip dude privilege club)
  ::
  ::  +mo-cyst-way: outbound request.
  ::
  ++  mo-cyst-way
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?>  ?=([%a %woot *] sign-arvo)
    ?>  ?=([@ @ ~] path)
    ::
    =/  =foreign-response  (foreign-response i.t.path)
    =/  art  +>+.sign-arvo
    ::
    (mo-awed foreign-response art)
  ::
  ::  +mo-cyst: take in /sys.
  ::
  ++  mo-cyst
    ~/  %mo-cyst
    |=  [=path =sign-arvo]
    ^+  mo-state
    ::
    ?+  -.path  !!
      %core  (mo-cyst-core path sign-arvo)
      %pel  (mo-cyst-pel path sign-arvo)
      %red  (mo-cyst-red path sign-arvo)
      %rep  (mo-cyst-rep path sign-arvo)
      %req  (mo-cyst-req path sign-arvo)
      %val  (mo-cyst-val path sign-arvo)
      %way  (mo-cyst-way path sign-arvo)
    ==
  ::
  ::  +mo-cook: take in /use.
  ::
  ++  mo-cook
    ~/  %mo-cook
    |=  [=path hin=(hypo sign-arvo)]
    ^+  mo-state
    ::
    ?.  ?=([@ @ coke *] path)
      ~&  [%mo-cook-bad-path path]
      !!
    ::
    =/  initialised
      =/  =term  i.path
      =/  =privilege
        =/  =ship  (slav %p i.t.path)
        =/  =routes  [disclosing=~ attributing=ship]
        [%high routes]
      ::
      (ap-abed:ap term privilege)
    ::
    =/  =vase  (slot 3 hin)
    =/  =sign-arvo  q.hin
    ::
    ?-  i.t.t.path
        ::
        %inn
        ::
      =/  poured  (ap-pour:initialised t.t.t.path vase)
      ap-abet:poured
        ::
        %cay
        ::
      ?.  ?=([%e %sigh *] sign-arvo)
        ~&  [%mo-cook-weird sign-arvo]
        ~&  [%mo-cook-weird-path path]
        mo-state
      ::
      =/  purred
        =/  =cage  +>.sign-arvo
        (ap-purr:initialised %sigh t.t.t.path cage)
      ::
      ap-abet:purred
        ::
        %out
        ::
      ?.  ?=([%g %unto *] sign-arvo)
        ~&  [%mo-cook-weird sign-arvo]
        ~&  [%mo-cook-weird-path path]
        mo-state
      ::
      =/  pouted
        =/  =cuft  +>.sign-arvo
        (ap-pout:initialised t.t.t.path cuft)
      ::
      ap-abet:pouted
    ==
  ::
  ::  +mo-claw: clear queue.
  ::
  ++  mo-claw
    |=  =dude
    ^+  mo-state
    ::
    ?.  (~(has by running.ship-state.gall) dude)
      mo-state
    ::
    =/  maybe-blocked  (~(get by waiting.ship-state.gall) dude)
    ::
    ?~  maybe-blocked
      mo-state
    ::
    =/  =blocked  u.maybe-blocked
    ::
    |-  ^+  mo-state
    ::
    ?:  =(~ blocked)
      %_  mo-state
        waiting.ship-state.gall  (~(del by waiting.ship-state.gall) dude)
      ==
    ::
    =^  kiss  blocked  [p q]:~(get to blocked)
    ::
    =/  =duct  p.kiss
    =/  =privilege  q.kiss
    =/  =club  r.kiss
    ::
    =/  move
      =/  =sock  [attributing.routes.privilege our]
      =/  =cush  [dude club]
      =/  action  [%slip %g %deal sock cush]
      [duct action]
    ::
    $(moves [move moves])
  ::
  ::  +mo-beak: build beak.
  ::
  ++  mo-beak
    |=  =dude
    ^-  beak
    ::
    =/  =beak
      =/  running  (~(got by running.ship-state.gall) dude)
      beak.running
    ::
    =/  =ship  p.beak
    ::
    ?.  =(ship our)
      beak
    beak(r [%da now])
  ::
  ::  +mo-peek: scry.
  ::
  ++  mo-peek
    ~/  %mo-peek
    |=  [=dude =privilege =term =path]
    ^-  (unit (unit cage))
    ::
    =/  initialised  (ap-abed:ap dude privilege)
    (ap-peek:initialised term path)
  ::
  ::  +mo-clip: apply club.
  ::
  ++  mo-clip
    |=  [=dude =privilege =club]
    ^+  mo-state
    ::
    =/  =path
      =/  ship  (scot %p attributing.routes.privilege)
      /sys/val/[ship]/[dude]
    ::
    =/  ship-desk
      =/  =beak  (mo-beak dude)
      [p q]:beak
    ::
    ?:  ?=(%puff -.club)
      =/  =schematic:ford  [%vale ship-desk +.club]
      =/  =note-arvo  [%f %build live=%.n schematic]
      (mo-pass path note-arvo)
    ::
    ?:  ?=(%punk -.club)
      =/  =schematic:ford  [%cast ship-desk p.club [%$ q.club]]
      =/  =note-arvo  [%f %build live=%.n schematic]
      (mo-pass path note-arvo)
    ::
    ?:  ?=(%peer-not -.club)
      =/  err  (some p.club)
      (mo-give %unto %reap err)
    ::
    =/  initialised  (ap-abed:ap dude privilege)
    =/  applied  (ap-club:initialised club)
    ap-abet:applied
  ::
  ::  +mo-come: handle locally.
  ::
  ++  mo-come
    |=  [=ship =cush]
    ^+  mo-state
    ::
    =/  =privilege
      =/  =routes  [disclosing=~ attributing=ship]
      [%high routes]
    ::
    =/  =dude  p.cush
    =/  =club  q.cush
    ::
    =/  is-running  (~(has by running.ship-state.gall) dude)
    =/  is-waiting  (~(has by waiting.ship-state.gall) dude)
    ::
    ?:  |(!is-running is-waiting)
      ::
      =/  =blocked
        =/  waiting  (~(get by waiting.ship-state.gall) dude)
        =/  kisses  (fall waiting *blocked)
        =/  kiss  [hen privilege club]
        (~(put to kisses) kiss)
      ::
      =/  waiting  (~(put by waiting.ship-state.gall) dude blocked)
      ::
      %_  mo-state
        waiting.ship-state.gall  waiting
      ==
    ::
    (mo-clip dude privilege club)
  ::
  ::  +mo-gawk: ames forward.
  ::
  ++  mo-gawk
    |=  [=ship =dude =bone =forward-ames]
    ^+  mo-state
    ::
    =.  mo-state
      ?.  ?=(%u action.forward-ames)
        mo-state
      (mo-give %mack ~)
    ::
    =/  =path
      =/  him  (scot %p ship)
      =/  num  (scot %ud bone)
      /sys/req/[him]/[dude]/[num]
    ::
    =/  =sock  [ship our]
    ::
    =/  =note-arvo
      ?-  action.forward-ames
          ::
          %m
          ::
        =/  =task:able
          =/  =cush  [dude %puff mark.forward-ames noun.forward-ames]
          [%deal sock cush]
        [%g task]
          ::
          %l
          ::
        =/  =task:able
          =/  =cush  [dude %peel mark.forward-ames path.forward-ames]
          [%deal sock cush]
        [%g task]
          ::
          %s
          ::
        =/  =task:able
          =/  =cush  [dude %peer path.forward-ames]
          [%deal sock cush]
        [%g task]
          ::
          %u
          ::
        =/  =task:able
          =/  =cush  [dude %pull ~]
          [%deal sock cush]
        [%g task]
      ==
    ::
    (mo-pass path note-arvo)
  ::
  ::  +mo-gawd: ames backward.
  ::
  ++  mo-gawd
    |=  [=ship =dude =bone =reverse-ames]
    ^+  mo-state
    ::
    ?-    action.reverse-ames
        ::
        %d
        ::
      =/  =path
        =/  him  (scot %p ship)
        =/  num  (scot %ud bone)
        /sys/rep/[him]/[dude]/[num]
      ::
      =/  =note-arvo
        =/  beak  (mo-beak dude)
        =/  info  [p q]:beak
        =/  =schematic:ford  [%vale info p.reverse-ames q.reverse-ames]
        [%f %build live=%.n schematic]
      ::
      (mo-pass path note-arvo)
        ::
        %x
        ::
      ::  XX should crash
      =.  mo-state  (mo-give %mack ~)
      ::
      =/  initialised
        =/  out  (mo-ball ship bone)
        (mo-abed out)
      ::
      (mo-give:initialised %unto %quit ~)
    ==
  ::
  ::  +ap: agent engine
  ::
  ++  ap
    ~%  %gall-ap  +>  ~
    ::
    |_  $:  dap=dude
            pry=privilege
            ost=bone
            zip=(list internal-move)
            dub=(list (each suss tang))
            sat=agent
        ==
    ::
    ++  ap-state  .
    ::
    ::  +ap-abed: initialise the provided app with the supplied privilege.
    ::
    ++  ap-abed
      ~/  %ap-abed
      |=  [=dude =privilege]
      ^+  ap-state
      ::
      =/  =agent
        =/  running  (~(got by running.ship-state.gall) dude)
        =/  =stats
          =/  change  +(change.stats.running)
          =/  trop  (shaz (mix (add dude change) eny))
          [change=change eny=trop time=now]
        running(stats stats)
      ::
      =/  maybe-bone  (~(get by bone-map.ducts.agent) hen)
      ::
      ?^  maybe-bone
        =/  bone  u.maybe-bone
        ap-state(dap dude, pry privilege, sat agent, ost bone)
      ::
      =/  =opaque-input
        =/  bone  +(bone.ducts.agent)
        :+  bone=bone
          bone-map=(~(put by bone-map.ducts.agent) hen bone)
        duct-map=(~(put by duct-map.ducts.agent) bone hen)
      ::
      %=  ap-state
        ost        bone.ducts.agent :: FIXME check that this is right
        ducts.sat  opaque-input
      ==
    ::
    ::  +ap-abet: resolve moves.
    ::
    ++  ap-abet
      ^+  mo-state
      ::
      =>  ap-abut
      ::
      =/  running  (~(put by running.ship-state.gall) dap sat)
      ::
      =/  next
        =/  from-internal  (turn zip ap-aver)
        =/  from-suss  (turn dub ap-avid)
        (weld from-internal (weld from-suss moves))
      ::
      %_  mo-state
        running.ship-state.gall  running
        moves                    next
      ==
    ::
    ::  +ap-abut: track queue.
    ::
    ++  ap-abut
      ^+  ap-state
      ::
      =/  internal-moves  zip
      =/  bones  *(set bone)
      ::
      |-  ^+  ap-state
      ::
      ?^  internal-moves
        ?.  ?=([%give %diff *] move.i.internal-moves)
          $(internal-moves t.internal-moves)
        ::
        =^  filled  ap-state  ap-fill(ost bone.i.internal-moves)
        ::
        =/  ribs
          ?:  filled
            bones
          (~(put in bones) bone.i.internal-moves)
        ::
        $(internal-moves t.internal-moves, bones ribs)
      ::
      =/  boned  ~(tap in bones)
      ::
      |-  ^+  ap-state
      ::
      ?~  boned
        ap-state
      ::
      =>
      ::
      $(boned t.boned, ost i.boned)
      ::
      =/  tib  (~(get by incoming.subscribers.sat) ost)
      ::
      ?~  tib
        ~&  [%ap-abut-bad-bone dap ost]
        ap-state
      ::
      ap-kill(attributing.routes.pry p.u.tib)
    ::
    ::  +ap-aver: internal move to move.
    ::
    ++  ap-aver
      ~/  %ap-aver
      |=  =internal-move
      ^-  move
      ::
      =/  =duct  (~(got by duct-map.ducts.sat) bone.internal-move)
      =/  wind
        ?-    -.move.internal-move
            ::
            %slip  !!
            ::
            %sick  !!
            ::
            %give
            ::
          ?<  =(0 bone.internal-move)
          ?.  ?=(%diff -.p.move.internal-move)
            [%give %unto p.move.internal-move]
          ::
          =/  =cage  p.p.move.internal-move
          =/  =mark
            =/  trans  (~(get by required-trans.sat) bone.internal-move)
            (fall trans p.cage)
          ::
          ?:  =(mark p.cage)
            [%give %unto p.move.internal-move]
          ::
          =/  =path  /sys/pel/[dap]
          =/  =schematic:ford
            =/  =beak  (mo-beak dap)
            [%cast [p q]:beak mark [%$ cage]]
          ::
          ::
          ?:  =(mark p.cage)
            [%give %unto p.move.internal-move]
          ::
          =/  =path  /sys/pel/[dap]
          =/  =schematic:ford
            =/  =beak  (mo-beak dap)
            [%cast [p q]:beak mark [%$ cage]]
          ::
          =/  =note-arvo  [%f %build live=%.n schematic]
          [%pass path note-arvo]
            ::
            %pass
            ::
          =/  =path  [%use dap p.move.internal-move]
          =/  =note-arvo
            ?-  note.q.move.internal-move
                ::
                %send
                ::
              =/  =sock  [our ship.q.move.internal-move]
              =/  =cush  cush.q.move.internal-move
              [%g %deal sock cush]
                ::
                %meta
                ::
              =/  =term  term.q.move.internal-move
              =/  =vase  vase.q.move.internal-move
              [term %meta vase]
            ==
          [%pass path note-arvo]
        ==
      ::
      [duct wind]
    ::
    ::  +ap-avid: onto results.
    ::
    ++  ap-avid
      |=  a=(each suss tang)
      ^-  move
      ::
      [hen %give %onto a]
    ::
    ::  +ap-call: call into server.
    ::
    ++  ap-call
      ~/  %ap-call
      |=  [=term =vase]
      ^-  [(unit tang) _ap-state]
      ::
      =.  ap-state  ap-bowl
      =^  arm  ap-state  (ap-farm term)
      ::
      ?:  ?=(%.n -.arm)
        [(some p.arm) ap-state]
      ::
      =^  arm  ap-state  (ap-slam term p.arm vase)
      ::
      ?:  ?=(%.n -.arm)
        [(some p.arm) ap-state]
      (ap-sake p.arm)
    ::
    ::  +ap-peek: peek.
    ::
    ++  ap-peek
      ~/  %ap-peek
      |=  [=term tyl=path]
      ^-  (unit (unit cage))
      ::
      =/  marked
        ?.  ?=(%x term)
          [mark=%$ tyl=tyl]
        ::
        =/  =path  (flop tyl)
        ::
        ?>  ?=(^ path)
        [mark=i.path tyl=(flop t.path)]
      ::
      =/  =mark  mark.marked
      =/  tyl  tyl.marked
      ::
      =^  maybe-arm  ap-state  (ap-find %peek term tyl)
      ::
      ?~  maybe-arm
        =/  =tank  [%leaf "peek find fail"]
        ((slog tank >tyl< >mark< ~) [~ ~])
      ::
      =^  arm  ap-state  (ap-farm q.u.maybe-arm)
      ::
      ?:  ?=(%.n -.arm)
        =/  =tank  [%leaf "peek farm fail"]
        ((slog tank p.arm) [~ ~])
      ::
      =/  slammed
        =/  =path  [term tyl]
        =/  =vase  !>((slag p.u.maybe-arm path))
        (ap-slam q.u.maybe-arm p.arm vase)
      ::
      =^  zem  ap-state  slammed
      ::
      ?:  ?=(%.n -.zem)
        =/  =tank  [%leaf "peek slam fail"]
        ((slog tank p.zem) [~ ~])
      ::
      =/  err
        =/  =tank  [%leaf "peek bad result"]
        ((slog tank ~) [~ ~])
      ::
      ?+  q.p.zem  err
          ::
          ~
          ::
        ~
          ::
          [~ ~]
          ::
        [~ ~]
          ::
          [~ ~ ^]
          ::
        =/  =vase  (sped (slot 7 p.zem))
        ::
        ?.  ?=([p=@ *] q.vase)
          =/  =tank  [%leaf "scry: malformed cage"]
          ((slog tank ~) [~ ~])
        ::
        ?.  ((sane %as) p.q.vase)
          =/  =tank  [%leaf "scry: malformed cage"]
          ((slog tank ~) [~ ~])
        ::
        ?.  =(mark p.q.vase)
          [~ ~]
        ::
        =/  =cage  [p.q.vase (slot 3 vase)]
        (some (some cage))
      ==
    ::
    ::  +ap-club: apply effect.
    ::
    ++  ap-club
      |=  =club
      ^+  ap-state
      ::
      ?-  -.club
        %peel       (ap-peel +.club)
        %poke       (ap-poke +.club)
        %peer       (ap-peer +.club)
        %puff       !!
        %punk       !!
        %peer-not   !!
        %pull       ap-pull
        %pump       ap-fall
      ==
    ::
    ::  +ap-diff: pour a diff.
    ::
    ++  ap-diff
      ~/  %ap-diff
      |=  [=ship pax=path =cage]
      ^+  ap-state
      ::
      =/  diff  [%diff p.cage +.pax]
      ::
      =^  cug  ap-state  (ap-find diff)
      ::
      ?~  cug
        =/  target  [%.n ship +.pax]
        ::
        =/  =tang
          =/  why  "diff: no {<`path`[p.cage +.pax]>}"
          (ap-suck why)
        ::
        =/  lame  (ap-lame %diff tang)
        (ap-pump:lame target)
      ::
      =/  =vase
        =/  target
          ?:  =(0 p.u.cug)
            =/  vas  (ap-cage cage)
            [!>(`path`+.pax) vas]
          [!>((slag (dec p.u.cug) `path`+.pax)) q.cage]
        (slop target)
      ::
      =^  cam  ap-state  (ap-call q.u.cug vase)
      ::
      ?^  cam
        =/  lame  (ap-lame q.u.cug u.cam)
        (ap-pump:lame %.n ship pax)
      (ap-pump %.y ship pax)
    ::
    ::  +ap-cage: cage to tagged vase.
    ::
    ++  ap-cage
      |=  cag/cage
      ^-  vase
      (slop `vase`[[%atom %tas `p.cag] p.cag] q.cag)
    ::
    ::  +ap-pump: update subscription.
    ::
    ++  ap-pump
      ~/  %ap-pump
      |=  [is-ok=? =ship =path]
      ^+  ap-state
      ::
      =/  way  [(scot %p ship) %out path]
      ::
      ?:  is-ok
        =/  =cote  [%send ship -.path %pump ~]
        (ap-pass way cote)
      ::
      =/  give  (ap-give %quit ~)
      =/  =cote  [%send ship -.path %pull ~]
      (ap-pass:give way cote)
    ::
    ::  +ap-fail: drop from queue.
    ::
    ++  ap-fall
      ^+  ap-state
      ::
      ?.  (~(has by incoming.subscribers.sat) ost)
        ap-state
      ::
      =/  level  (~(get by meter.subscribers.sat) ost)
      ::
      ?:  |(?=(~ level) =(0 u.level))
        ap-state
      ::
      =.  u.level  (dec u.level)
      ::
      ?:  =(0 u.level)
        =/  deleted  (~(del by meter.subscribers.sat) ost)
        ap-state(meter.subscribers.sat deleted)
      ::
      =/  dropped  (~(put by meter.subscribers.sat) ost u.level)
      ap-state(meter.subscribers.sat dropped)
    ::
    ::  +ap-farm: produce arm.
    ::
    ++  ap-farm
      ~/  %ap-farm
      |=  =term
      ^-  [(each vase tang) _ap-state]
      ::
      =/  pyz
        (mule |.((~(mint wa cache.sat) p.running-state.sat [%limb term]))) :: FIXME
      ::
      ?:  ?=(%.n -.pyz)
        =/  =tang  +.pyz
        [[%.n tang] ap-state]
      ::
      =/  this=(each vase tang)
        =/  ton  (mock [q.running-state.sat q.+<.pyz] ap-sled)
        ?-  -.ton
          %0  [%.y p.+<.pyz p.ton]
          %1  [%.n (turn p.ton |=(a=* (smyt (path a))))]
          %2  [%.n p.ton]
        ==
      ::
      =/  =worm  +>.pyz
      =/  next  ap-state(cache.sat worm)
      [this next]
    ::
    ::  +ap-fill: add to queue.
    ::
    ++  ap-fill
      ^-  [? _ap-state]
      ::
      =/  level
        =/  lev  (~(get by meter.subscribers.sat) ost)
        (fall lev 0)
      ::
      =/  subscriber=(unit (pair ship path))
        (~(get by incoming.subscribers.sat) ost)
      ::
      =/  incoming  (~(get by incoming.subscribers.sat) ost)
      =/  duct  (~(get by duct-map.ducts.sat) ost)
      ::
      ?:  ?&  =(20 level)
              ?|  ?=(~ subscriber)
                  !=(our p.u.subscriber)
              ==
          ==
        ~&  [%gall-pulling-20 ost incoming duct]
        [%.n ap-state]
      ::
      =/  meter  (~(put by meter.subscribers.sat) ost +(level))
      =/  next  ap-state(meter.subscribers.sat meter)
      [%.y next]
    ::
    ::  +ap-find: general arm.
    ::
    ++  ap-find
      ~/  %ap-find
      |=  [=term =path]
      ^-  [(unit (pair @ud @tas)) _ap-state]
      ::  check cache
      ::
      =/  maybe-result  (~(get by find-cache.sat) [term path])
      ?^  maybe-result
        [u.maybe-result ap-state]
      ::
      =/  result
        =/  dep  0
        |-  ^-  (unit (pair @ud @tas))
        =/  spu
          ?~  path
            ~
          =/  hyped  (cat 3 term (cat 3 '-' i.path))
          $(path t.path, dep +(dep), term hyped)
        ::
        ?^  spu
          spu
        ::
        ?.  (ap-fond term)
          ~
        (some [dep term])
      ::
      =.  find-cache.sat  (~(put by find-cache.sat) [term path] result)
      ::
      [result ap-state]
    ::
    ::  +ap-fond: check for arm.
    ::
    ++  ap-fond
      ~/  %ap-fond
      |=  =term
      ^-  ?
      ::
      (slob term p.running-state.sat)
    ::
    ::  +ap-give: return result.
    ::
    ++  ap-give
      |=  =cuft
      ^+  ap-state
      ::
      =/  internal-moves  [[ost [%give cuft]] zip]
      ap-state(zip internal-moves)
    ::
    ::  +ap-bowl: set up bowl.
    ::
    ++  ap-bowl
      ^+  ap-state
      :: FIXME
      %_    ap-state
          +12.q.running-state.sat
        ^-   bowl
        :*  :*  our                               ::  host
                attributing.routes.pry            ::  guest
                dap                               ::  agent
            ==                                    ::
            :*  wex=~                             ::  outgoing
                incoming=incoming.subscribers.sat ::  incoming
            ==                                    ::
            :*  ost=ost                           ::  cause
                change=change.stats.sat           ::  tick
                eny=eny.stats.sat                 ::  nonce
                now=time.stats.sat                ::  time
                byk=beak.sat                      ::  source
        ==  ==                                    ::
      ==
    ::
    ::  +ap-move: process each move.
    ::
    ++  ap-move
      ~/  %ap-move
      |=  =vase
      ^-  [(each internal-move tang) _ap-state]
      ::
      ?@  q.vase
        =/  =tang  (ap-suck "move: invalid move (atom)")
        [[%.n tang] ap-state]
      ::
      ?^  -.q.vase
        =/  =tang  (ap-suck "move: invalid move (bone)")
        [[%.n tang] ap-state]
      ::
      ?@  +.q.vase
        =/  =tang  (ap-suck "move: invalid move (card)")
        [[%.n tang] ap-state]
      ::
      =/  hun  (~(get by duct-map.ducts.sat) -.q.vase)
      ::
      ?.  &((~(has by duct-map.ducts.sat) -.q.vase) !=(0 -.q.vase))
        ~&  [q-vase+q.vase has-by-r-zam+(~(has by duct-map.ducts.sat) -.q.vase)]
        =/  =tang  (ap-suck "move: invalid card (bone {<-.q.vase>})")
        [[%.n tang] ap-state]
      ::
      =^  pec  cache.sat  (~(spot wa cache.sat) 3 vase)
      =^  cav  cache.sat  (~(slot wa cache.sat) 3 pec)
      ::
      ?+  +<.q.vase
               (ap-move-pass -.q.vase +<.q.vase cav)
        %diff  (ap-move-diff -.q.vase cav)
        %hiss  (ap-move-hiss -.q.vase cav)
        %peel  (ap-move-peel -.q.vase cav)
        %peer  (ap-move-peer -.q.vase cav)
        %pull  (ap-move-pull -.q.vase cav)
        %poke  (ap-move-poke -.q.vase cav)
        %send  (ap-move-send -.q.vase cav)
        %quit  (ap-move-quit -.q.vase cav)
        %http-response  (ap-move-http-response -.q.vax cav)
      ==
    ::
    ::  +ap-move-quit: give quit move.
    ::
    ++  ap-move-quit
      ~/  %quit
      |=  [=bone =vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      =/  that
        ?^  q.vase
          =/  =tang  (ap-suck "quit: improper give")
          [%.n tang]
        =/  =cuft  [%quit ~]
        =/  =internal-move  [bone=bone move=[%give cuft]]
        [%.y p=internal-move]
      ::
      =/  next
        =/  incoming  (~(del by incoming.subscribers.sat) bone)
        ap-state(incoming.subscribers.sat incoming)
      ::
      [that next]
    ::
    ::  +ap-move-diff: give diff move.
    ::
    ++  ap-move-diff
      ~/  %diff
      |=  [=bone =vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      =^  pec  cache.sat  (~(sped wa cache.sat) vase)
      ::
      ?.  &(?=(^ q.pec) ?=(@ -.q.pec) ((sane %tas) -.q.pec)) :: FIXME
        =/  =tang  (ap-suck "diff: improper give")
        [[%.n tang] ap-state]
      ::
      =^  tel  cache.sat  (~(slot wa cache.sat) 3 pec)
      ::
      =/  =internal-move
        =/  =cage  [-.q.pec tel]
        [bone [%give %diff cage]]
      ::
      [[%.y p=internal-move] ap-state]
    ::
      ::
      ::  TODO: Magic vase validation. I have no idea how malformed
      ::  checking works.
      ::
      ::  This should be moved into +cote
      ::
      :_  ap-state
      [%& sto %give %http-response ;;(http-event:http q.vax)]
    ::
    ::
    ::  +ap-move-mess: extract path, target.
    ::
    ++  ap-move-mess
      ~/  %mess
      |=  =vase
      ^-  [(each (trel path ship term) tang) _ap-state]
      ::
      =/  that=(each (trel path ship term) tang)
        ?.  ?&  ?=([p=* [q=@ r=@] s=*] q.vase)
                (gte 1 (met 7 q.q.vase))
            ==
          =/  =tang  (ap-suck "mess: malformed target")
          [%.n tang]
        ::
        =/  pux  ((soft path) p.q.vase)
        ::
        ?.  &(?=(^ pux) (levy u.pux (sane %ta)))
          =/  =tang  (ap-suck "mess: malformed path")
          [%.n tang]
        ::
        =/  =path  [(scot %p q.q.vase) %out r.q.vase u.pux]
        =/  =ship  q.q.vase
        =/  =term  r.q.vase
        [%.y path ship term]
      ::
      [that ap-state]
    ::
    ::  +ap-move-pass: pass general move.
    ::
    ++  ap-move-pass
      ~/  %pass
      |=  [=bone =noun =vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      ?.  &(?=(@ noun) ((sane %tas) noun))
        =/  =tang  (ap-suck "pass: malformed card")
        [[%.n tang] ap-state]
      ::
      =/  pux  ((soft path) -.q.vase)
      ::
      ?.  &(?=(^ pux) (levy u.pux (sane %ta)))
        =/  =tang  (ap-suck "pass: malformed path")
        ~&  [%bad-path pux]
        [[%.n tang] ap-state]
      ::
      =/  huj  (ap-vain noun)
      ::
      ?~  huj
        =/  =tang  (ap-suck "move: unknown note {(trip noun)}")
        [[%.n tang] ap-state]
      ::
      =^  tel  cache.sat  (~(slot wa cache.sat) 3 vase)
      ::
      :_  ap-state
      :^  %.y  bone  %pass
      :-  [(scot %p attributing.routes.pry) %inn u.pux]
      [%meta u.huj (slop (ap-term %tas noun) tel)]
    ::
    ::  +ap-move-poke: pass %poke.
    ::
    ++  ap-move-poke
      ~/  %poke
      |=  [sto=bone vax=vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      =^  yep  ap-state  (ap-move-mess vax)
      ::
      ?:  ?=(%.n -.yep)
        [yep ap-state]
      ::
      =^  gaw  cache.sat  (~(slot wa cache.sat) 7 vax)
      ::
      ?.  &(?=([p=@ q=*] q.gaw) ((sane %tas) p.q.gaw))
        =/  =tang  (ap-suck "poke: malformed cage")
        [[%.n tang] ap-state]
      ::
      =^  paw  cache.sat  (~(stop wa cache.sat) 3 gaw)
      ::
      :_  ap-state
      :^  %.y  sto  %pass
      :-  p.p.yep
      [%send q.p.yep r.p.yep %poke p.q.gaw paw]
    ::
    ::  +ap-move-peel: pass %peel.
    ::
    ++  ap-move-peel
      ~/  %peel
      |=  [=bone =vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      =^  yep  ap-state  (ap-move-mess vase)
      ::
      :: FIXME invert
      :_  ap-state
      ?:  ?=(%.n -.yep)
        yep
      ::
      =/  mar  ((soft mark) +>-.q.vase)
      ::
      ?~  mar
        =/  =tang  (ap-suck "peel: malformed mark")
        [%.n tang]
      ::
      =/  pux  ((soft path) +>+.q.vase)
      ::
      ?.  &(?=(^ pux) (levy u.pux (sane %ta)))
        =/  =tang  (ap-suck "peel: malformed path")
        [%.n tang]
      ::
      ?:  (~(has in misvale.sat) p.p.yep)
        =/  err  [leaf+"peel: misvalidation encountered"]~
        :^  %.y  bone  %pass
        :-  p.p.yep
        [%send q.p.yep r.p.yep %peer-not err]
      ::
      :^  %.y  bone  %pass
      :-  p.p.yep
      [%send q.p.yep r.p.yep %peel u.mar u.pux]
    ::
    ::  +ap-move-peer: pass %peer.
    ::
    ++  ap-move-peer
      ~/  %peer
      |=  [=bone =vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      =^  yep  ap-state  (ap-move-mess vase)
      ::
      :_  ap-state
      ?:  ?=(%.n -.yep)
        yep
      ::
      =/  pux  ((soft path) +>.q.vase)
      ::
      ?.  &(?=(^ pux) (levy u.pux (sane %ta)))
        =/  =tang  (ap-suck "peer: malformed path")
        [%.n tang]
      ::
      ?:  (~(has in misvale.sat) p.p.yep)
        =/  err  [leaf+"peer: misvalidation encountered"]~
        :^  %&  bone  %pass
        :-  p.p.yep
        [%send q.p.yep r.p.yep %peer-not err]
      ::
      :^  %&  bone  %pass
      :-  p.p.yep
      [%send q.p.yep r.p.yep %peer u.pux]
    ::
    ::  +ap-move-pull: pass %pull.
    ::
    ++  ap-move-pull
      ~/  %pull
      |=  [=bone =vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      =^  yep  ap-state  (ap-move-mess vase)
      ::
      :_  ap-state
      ?:  ?=(%.n -.yep)
        yep
      ::
      ?.  =(~ +>.q.vase)
        =/  =tang  (ap-suck "pull: malformed card")
        [%.n tang]
      ::
      :^  %.y  bone  %pass
      :-  p.p.yep
      [%send q.p.yep r.p.yep %pull ~]
    ::
    ::  +ap-move-send: pass gall action.
    ::
    ++  ap-move-send
      ~/  %send
      |=  [=bone =vase]
      ^-  [(each internal-move tang) _ap-state]
      ::
      ?.  ?&  ?=([p=* [q=@ r=@] [s=@ t=*]] q.vase)
              (gte 1 (met 7 q.q.vase))
              ((sane %tas) r.q.vase)
          ==
        =/  =tang  (ap-suck "send: improper ask.[%send wire gill club]")
        :_(ap-state [%.n tang])
      ::
      =/  pux  ((soft path) p.q.vase)
      ::
      ?.  &(?=(^ pux) (levy u.pux (sane %ta)))
        =/  =tang  (ap-suck "send: malformed path")
        [[%.n tang] ap-state]
      ::
      ?:  ?=($poke s.q.vase)
        =^  gav  cache.sat  (~(spot wa cache.sat) 7 vase)
        ::
        ?>  =(%poke -.q.gav)
        ::
        ?.  ?&  ?=([p=@ q=*] t.q.vase)
                ((sane %tas) p.t.q.vase)
            ==
          =/  =tang  (ap-suck "send: malformed poke")
          [[%.n tang] ap-state]
        ::
        =^  vig  cache.sat  (~(spot wa cache.sat) 3 gav)
        =^  geb  cache.sat  (~(slot wa cache.sat) 3 vig)
        ::
        :_  ap-state
        :^  %.y  bone  %pass
        :-  [(scot %p q.q.vase) %out r.q.vase u.pux]
        ^-  cote
        [%send q.q.vase r.q.vase %poke p.t.q.vase geb]
      ::
      :_  ap-state
      =/  cob  ((soft club) [s t]:q.vase)
      ?~  cob
        =/  =tang  (ap-suck "send: malformed club")
        [%.n tang]
      :^  %&  bone  %pass
      :-  [(scot %p q.q.vase) %out r.q.vase u.pux]
      [%send q.q.vase r.q.vase u.cob]
    ::
    ::  +ap-pass: request action.
    ::
    ++  ap-pass
      |=  [=path =cote]
      ^+  ap-state
      ::
      =/  =internal-move  [ost [%pass path cote]]
      ap-state(zip [internal-move zip])
    ::
    ::  +ap-peep: reinstall.
    ::
    ++  ap-peep
      ~/  %ap-peep
      |=  =vase
      ^+  ap-state
      ::
      =/  prep
        =/  installed  ap-prep(running-state.sat vase)
        =/  running  (some running-state.sat)
        (installed running)
      ::
      =^  maybe-tang  ap-state  prep
      ::
      ?~  maybe-tang
        ap-state
      (ap-lame %prep-failed u.maybe-tang)
    ::
    ::  +ap-peel: apply %peel.
    ::
    ++  ap-peel
      |=  [=mark =path]
      ^+  ap-state
      ::
      =.  required-trans.sat  (~(put by required-trans.sat) ost mark)
      ::
      (ap-peer path)
    ::
    ::  +ap-peer: apply %peer.
    ::
    ++  ap-peer
      ~/  %ap-peer
      |=  pax=path
      ^+  ap-state
      ::
      =.  incoming.subscribers.sat
        (~(put by incoming.subscribers.sat) ost [attributing.routes.pry pax])
      ::
      =^  maybe-arm  ap-state  (ap-find %peer pax)
      ::
      ?~  maybe-arm
        ap-state
      ::
      =/  arm  u.maybe-arm
      =/  old  zip
      ::
      =.  zip  ~
      =^  cam  ap-state
          :: FIXME
          %+  ap-call  q.arm
          !>(`path`(slag p.arm pax))
      ::
      =.  zip  (weld zip `(list internal-move)`[[ost %give %reap cam] old])
      ::
      ?^  cam
        ap-pule
      ap-state
    ::
    ::  +ap-poke: apply %poke.
    ::
    ++  ap-poke
      ~/  %ap-poke
      |=  =cage
      ^+  ap-state
      ::
      =^  maybe-arm  ap-state  (ap-find %poke p.cage ~)
      ::
      ?~  maybe-arm
        =/  =tang  (ap-suck "no poke arm for {(trip p.cage)}")
        (ap-give %coup (some tang))
      ::
      =/  arm  u.maybe-arm
      ::
      =^  tur  ap-state
          :: FIXME
          %+  ap-call  q.arm
          ?.  =(0 p.arm)  q.cage
          (slop (ap-term %tas p.cage) q.cage)
      (ap-give %coup tur)
    ::
    ::  +ap-lame: pour error.
    ::
    ++  ap-lame
      |=  [=term =tang]
      ^+  ap-state
      ::
      =^  maybe-arm  ap-state  (ap-find /lame)
      ::
      :: FIXME
      ?~  maybe-arm
        =.  tang  [>%ap-lame dap term< (turn tang |=(a=tank rose+[~ "! " ~]^[a]~))]
        ~>  %slog.`rose+["  " "[" "]"]^(flop tang)
        ap-state
      ::
      =/  arm  u.maybe-arm
      ::
      =^  cam  ap-state
        %+  ap-call  q.arm
        !>([term tang])
      ::
      ?^  cam
        =.  tang  [>%ap-lame-lame< (turn u.cam |=(a/tank rose+[~ "! " ~]^[a]~))]
        ~>  %slog.`rose+["  " "[" "]"]^(welp (flop tang) leaf+"." (flop u.cam))
        ap-state
      ::
      ap-state
    ::
    ::  +ap-misvale: broken vale.
    ::
    ++  ap-misvale
      |=  =wire
      ^+  ap-state
      ::
      ~&  [%ap-blocking-misvale wire]
      =/  misvaled  (~(put in misvale.sat) wire)
      ap-state(misvale.sat misvaled)
    ::
    ::  +ap-pour: generic take.
    ::
    ++  ap-pour
      ~/  %ap-pour
      |=  [pax=path =vase]
      ^+  ap-state
      ::
      ?.  &(?=([@ *] q.vase) ((sane %tas) -.q.vase))
        =/  =tang  (ap-suck "pour: malformed card")
        (ap-lame %pour tang)
      ::
      =^  maybe-arm  ap-state  (ap-find [-.q.vase pax])
      ::
      ?~  maybe-arm
        =/  =tang  (ap-suck "pour: no {(trip -.q.vase)}: {<pax>}")
        (ap-lame -.q.vase tang)
      ::
      =/  arm  u.maybe-arm
      ::
      =^  tel  cache.sat  (~(slot wa cache.sat) 3 vase)
      =^  cam  ap-state
          %+  ap-call  q.arm
          %+  slop
            !>(`path`(slag p.arm pax))
          tel
      ::
      ?^  cam
        (ap-lame -.q.vase u.cam)
      ap-state
    ::
    ::  +ap-purr: unwrap take.
    ::
    ++  ap-purr
      ~/  %ap-purr
      |=  [=term pax=path =cage]
      ^+  ap-state
      ::
      =^  maybe-arm  ap-state  (ap-find [term p.cage pax])
      ::
      ?~  maybe-arm
        =/  =tang  (ap-suck "{(trip term)}: no {<`path`[p.cage pax]>}")
        (ap-lame term tang)
      ::
      =/  arm  u.maybe-arm
      ::
      =/  =vase
        %-  slop
        ?:  =(0 p.arm)
          =/  vas  (ap-cage cage)
          [!>(`path`pax) vas]
        [!>((slag (dec p.arm) `path`pax)) q.cage]
      ::
      =^  maybe-tang  ap-state  (ap-call q.arm vase)
      ::
      ?^  maybe-tang
        (ap-lame q.arm u.maybe-tang)
      ap-state
    ::
    ::  +ap-pout: specific take.
    ::
    ++  ap-pout
      |=  [=path =cuft]
      ^+  ap-state
      ::
      ?-  -.cuft
        %coup  (ap-take %coup +.path (some !>(p.cuft)))
        %diff  (ap-diff attributing.routes.pry path p.cuft)
        %quit  (ap-take %quit +.path ~)
        %reap  (ap-take %reap +.path (some !>(p.cuft)))
        %http-response  !!
      ==
    ::
    ::  +ap-prep: install.
    ::
    ++  ap-prep
      |=  vux=(unit vase)
      ^-  [(unit tang) _ap-state]
      ::
      =^  gac  ap-state  (ap-prop vux)
      ::
      :-  gac
      %=    ap-state
          misvale.sat
        ~?  !=(misvale.sat *misvale-data)  misvale-drop+misvale.sat
        *misvale-data                 ::  new app might mean new marks
      ::
          find-cache.sat
        ~
      ::
          dub
        :_(dub ?~(gac [%& dap ?~(vux %boot %bump) now] [%| u.gac]))
      ==
    ::
    ::  +ap-prop: install.
    ::
    ++  ap-prop
      ~/  %ap-prop
      |=  vux=(unit vase)
      ^-  [(unit tang) _ap-state]
      ::
      ?.  (ap-fond %prep)
        ?~  vux
          (some ap-state)
        ::
        =+  [new=p:(slot 13 running-state.sat) old=p:(slot 13 u.vux)]
        ::
        ?.  (~(nest ut p:(slot 13 running-state.sat)) %| p:(slot 13 u.vux))
          =/  =tang  (ap-suck "prep mismatch")
          :_(ap-state (some tang))
        (some ap-state(+13.q.running-state.sat +13.q.u.vux))
      ::
      =^  tur  ap-state
          %+  ap-call  %prep
          ?~(vux !>(~) (slop !>(~) (slot 13 u.vux)))
      ::
      ?~  tur
        (some ap-state)
      :_(ap-state (some u.tur))
    ::
    ::  +ap-pule: silent delete.
    ::
    ++  ap-pule
      ^+  ap-state
      ::
      =/  incoming  (~(get by incoming.subscribers.sat) ost)
      ?~  incoming
        ap-state
      ::
      %_  ap-state
        incoming.subscribers.sat  (~(del by incoming.subscribers.sat) ost)
        meter.subscribers.sat  (~(del by meter.subscribers.sat) ost)
      ==
    ::
    ::  +ap-pull: load delete.
    ::
    ++  ap-pull
      ^+  ap-state
      ::
      =/  maybe-incoming  (~(get by incoming.subscribers.sat) ost)
      ?~  maybe-incoming
        ap-state
      ::
      =/  incoming  u.maybe-incoming
      ::
      =:  incoming.subscribers.sat  (~(del by incoming.subscribers.sat) ost)
          meter.subscribers.sat     (~(del by meter.subscribers.sat) ost)
      ==
      ::
      =^  maybe-arm  ap-state  (ap-find %pull q.incoming)
      ::
      ?~  maybe-arm
        ap-state
      ::
      =/  arm  u.maybe-arm
      ::
      =^  cam  ap-state
        %+  ap-call  q.arm
        !>((slag p.arm q.incoming))
      ::
      ?^  cam
        (ap-lame q.arm u.cam)
      ap-state
    ::
    ::  +ap-kill: queue kill.
    ::
    ++  ap-kill
      ^+  ap-state
      (ap-give:ap-pull %quit ~)
    ::
    ::  +ap-take: non-diff gall take.
    ::
    ++  ap-take
      ~/  %ap-take
      |=  [=term =path vux=(unit vase)]
      ^+  ap-state
      ::
      =^  maybe-arm  ap-state  (ap-find term path)
      ::
      ?~  maybe-arm
        ap-state
      ::
      =/  arm  u.maybe-arm
      ::
      =^  cam  ap-state
        %+  ap-call  q.arm
        =+  den=!>((slag p.arm path))
        ?~(vux den (slop den u.vux))
      ::
      ?^  cam
        (ap-lame q.arm u.cam)
      ap-state
    ::
    ::  +ap-safe: process move list.
    ::
    ++  ap-safe
      ~/  %ap-safe
      |=  =vase
      ^-  [(each (list internal-move) tang) _ap-state]
      ::
      ?~  q.vase
        [[%.y p=~] ap-state]
      ::
      ?@  q.vase
        =/  =tang  (ap-suck "move: malformed list")
        [[%.n tang] ap-state]
      ::
      =^  hed  cache.sat  (~(slot wa cache.sat) 2 vase)
      =^  sud  ap-state  (ap-move hed)
      ::
      ?:  ?=(%.n -.sud)
        [sud ap-state]
      ::
      =^  tel  cache.sat  (~(slot wa cache.sat) 3 vase)
      =^  res  ap-state  $(vase tel)
      ::
      =/  that
        ?:  ?=(%.n -.res)
          res
        [%.y p.sud p.res]
      ::
      [that ap-state]
    ::
    ::  +ap-sake: handle result.
    ::
    ++  ap-sake
      ~/  %ap-sake
      |=  =vase
      ^-  [(unit tang) _ap-state]
      ::
      ?:  ?=(@ q.vase)
        =/  =tang  (ap-suck "sake: invalid product (atom)")
        [(some tang) ap-state]
      ::
      =^  hed  cache.sat  (~(slot wa cache.sat) 2 vase)
      =^  muz  ap-state  (ap-safe hed)
      ::
      ?:  ?=(%.n -.muz)
        [(some p.muz) ap-state]
      ::
      =^  tel  cache.sat  (~(slot wa cache.sat) 3 vase)
      =^  sav  ap-state  (ap-save tel)
      ::
      ?:  ?=(%.n -.sav)
        [(some p.sav) ap-state]
      ::
      :-  ~
      %_  ap-state
        zip                (weld (flop p.muz) zip)
        running-state.sat  p.sav
      ==
    ::
    ::  +ap-save: verify core.
    ::
    ++  ap-save
      ~/  %ap-save
      |=  vax=vase
      ^-  [(each vase tang) _ap-state]
      ::
      =^  gud  cache.sat  (~(nest wa cache.sat) p.running-state.sat p.vax)
      ::
      :_  ap-state
      ?.  gud
        =/  =tang  (ap-suck "invalid core")
        [%.n tang]
      [%.y vax]
    ::
    ::  +ap-slam: virtual slam.
    ::
    ++  ap-slam
      ~/  %ap-slam
      |=  [cog=term gat=vase arg=vase]
      ^-  [(each vase tang) _ap-state]
      ::
      =/  wyz
        %-  mule  |.
        (~(mint wa cache.sat) [%cell p.gat p.arg] [%cnsg [%$ ~] [%$ 2] [%$ 3] ~])
      ::
      ?:  ?=(%.n -.wyz)
        %-  =/  sam  (~(peek ut p.gat) %free 6)
            (slog >%ap-slam-mismatch< ~(duck ut p.arg) ~(duck ut sam) ~)
        =/  =tang  (ap-suck "call: {<cog>}: type mismatch")
        [[%.n tang] ap-state]
      ::
      :_  ap-state(cache.sat +>.wyz)
      =+  [typ nok]=+<.wyz
      =/  ton  (mock [[q.gat q.arg] nok] ap-sled)
      ?-  -.ton
        %0  [%.y typ p.ton]
        %1  [%.n (turn p.ton |=(a/* (smyt (path a))))]
        %2  [%.n p.ton]
      ==
    ::
    ::  +ap-sled: namespace view.
    ::
    ++  ap-sled  (sloy ska)
    ::
    ::  +ap-suck: standard tang.
    ::
    ++  ap-suck
      |=  =tape
      ^-  tang
      ::
      =/  =tank  [%leaf (weld "gall: {<dap>}: " tape)]
      [tank ~]
    ::
    ::  +ap-term: atomic vase.
    ::
    ++  ap-term
      |=  [=term =atom]
      ^-  vase
      ::
      =/  =type  [%atom term (some atom)]
      [p=type q=atom]
    ::
    ::  +ap-vain: card to vane.
    ::
    ++  ap-vain
      |=  =term
      ^-  (unit @tas)
      ::
      ?+  term  ~&  [%ap-vain term]
               ~
        %bonk   `%a
        %build  `%f
        %cash   `%a
        %conf   `%g
        %cred   `%c
        %crew   `%c
        %crow   `%c
        %deal   `%g
        %dirk   `%c
        %drop   `%c
        %flog   `%d
        %info   `%c
        %keep   `%f
        %kill   `%f
        %look   `%j
        %merg   `%c
        %mint   `%j
        %mont   `%c
        %nuke   `%a
        %ogre   `%c
        %perm   `%c
        %rest   `%b
        %snap   `%j
        %wait   `%b
        %want   `%a
        %warp   `%c
        %wind   `%j
        %wipe   `%f
        %request         `%l
        %cancel-request  `%l
        %serve       `%r
        %connect     `%r
        %disconnect  `%r
        %rule        `%r
      ==
    --
  --
::
::  +call: request.
::
++  call
  ~%  %gall-call  +>   ~
  |=  [=duct hic=(hypo (hobo task:able))]
  ^-  [(list move) _gall-payload]
  ::
  =>  .(q.hic ?.(?=($soft -.q.hic) q.hic ;;(task:able p.q.hic)))
  ::
  =/  initialised  (mo-abed:mo duct)
  ::
  ?-    -.q.hic
      ::
      %conf
      ::
    =/  =dock  p.q.hic
    =/  =ship  p.dock
    ?.  =(our ship)
      ~&  [%gall-not-ours ship]
      [~ gall-payload]
    ::
    =/  booted  (mo-boot:initialised q.dock q.q.hic)
    mo-abet:booted
      ::
      %deal
      ::
    =<  mo-abet
    :: either to us
    ::
    ?.  =(our q.p.q.hic)
      :: or from us
      ::
      ?>  =(our p.p.q.hic)
      (mo-away:initialised q.p.q.hic q.q.hic)
    (mo-come:initialised p.p.q.hic q.q.hic)
      ::
      %init
      ::
    =/  payload  gall-payload(system-duct.ship-state.gall duct)
    [~ payload]
      ::
      %sunk
      ::
    [~ gall-payload]
      ::
      %vega
      ::
    [~ gall-payload]
      ::
      %west
      ::
    ?>  ?=([?(%ge %gh) @ ~] q.q.hic)
    =*  dap  i.t.q.q.hic
    =*  him  p.q.hic
    ::
    ?:  ?=(%ge i.q.q.hic)
      =/  mes  ;;((pair @ud forward-ames) r.q.hic)
      =<  mo-abet
      (mo-gawk:initialised him dap mes)
    ::
    =/  mes  ;;((pair @ud reverse-ames) r.q.hic)
    =<  mo-abet
    (mo-gawd:initialised him dap mes)
      ::
      %wegh
      ::
    =/  =mass
      :+  %gall  %.n
      :~  foreign+&+contacts.ship-state.gall
          :+  %blocked  %.n
          (sort ~(tap by (~(run by waiting.ship-state.gall) |=(blocked [%.y +<]))) aor)
          :+  %active   %.n
          (sort ~(tap by (~(run by running.ship-state.gall) |=(agent [%.y +<]))) aor)
          [%dot %.y gall]
      ==
    =/  =move  [duct %give %mass mass]
    [[move ~] gall-payload]
  ==
::
::  +load: recreate vane.
::
++  load
  |=  old=gall-n
  ^+  gall-payload
  ?-  -.old
    %0  gall-payload(gall old)
  ==
::
::  +scry: standard scry.
::
++  scry
  ~/  %gall-scry
  |=  [fur=(unit (set monk)) =term =shop =desk =coin =path]
  ^-  (unit (unit cage))
  ?.  ?=(%.y -.shop)
    ~
  ::
  =/  =ship  p.shop
  ::
  ?:  ?&  =(%u term)
          =(~ path)
          =([%$ %da now] coin)
          =(our ship)
      ==
    =/  =vase  !>((~(has by running.ship-state.gall) desk))
    =/  =cage  [%noun vase]
    (some (some cage))
  ::
  ?.  =(our ship)
    ~
  ::
  ?.  =([%$ %da now] coin)
    ~
  ::
  ?.  (~(has by running.ship-state.gall) desk)
    (some ~)
  ::
  ?.  ?=(^ path)
    ~
  ::
  =/  initialised  mo-abed:mo
  =/  =privilege  [%high [p=~ q=ship]]
  (mo-peek:initialised desk privilege term path)
::
::  +stay: save without cache.
::
++  stay  gall
::
::  +take: response.
::
++  take
  ~/  %gall-take
  |=  [=wire =duct hin=(hypo sign-arvo)]
  ^-  [(list move) _gall-payload]
  ::
  ~|  [%gall-take wire]
  ::
  ?>  ?=([?(%sys %use) *] wire)
  =/  initialised  (mo-abed:mo duct)
  ?-  i.wire
      ::
      %sys
      ::
    =/  syssed  (mo-cyst:initialised t.wire q.hin)
    mo-abet:syssed
      ::
      %use
      ::
    =/  cooked  (mo-cook:initialised t.wire hin)
    mo-abet:cooked
  ==
--
