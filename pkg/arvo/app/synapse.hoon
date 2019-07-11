::
|%
:: +move: output effect
::
+$  move  [bone card]
::
+$  channel
  $:  uid=@t
      owner=@p
      members=(set @p)
      write-permission=(each [%white (set @p)] [%black (set @p)])
      read-permission=(each [%white (set @p)] [%black (set @p)])
      marks=(map mar=@tas (list app=@tas))
      num=@
  ==
::
+$  invite  [cha=@t channel=channel]
::
+$  event  [cha=@t num=@ wen=@da mar=@tas dat=*]
:: +card: output effect payload
::
+$  card
  $%  [%poke wire dock [@tas *]]
  ==
+$  state
  $%  [%0 state-zero]
  ==
::
+$  state-zero
  $:  channels=(map @t channel)
  ==
::
--
::
|_  [bol=bowl:gall state]
::
++  this  .
::
++  prep
  |=  old=(unit versioned-state)
  ^-  (quip move _this)
  ?~  old
    [~ this]
  [~ this(+<+ u.old]
::
++  poke-synapse-channel
  ::  invite or create
  ::  must come from app on our system
::
::  +poke-synapse-upstream-event: someone else tells owner about an event
::
++  poke-synapse-upstream-event
  =/  cha  (~(get by channel.sta) cha.eve)
  ?~  cha
    ~&  'no existing channel'
    [~ this]
  ::  check permission of sender
  ::  if sender permission checks out, send the event to all my apps
  ::  if my apps send me back an
::
::  +poke-synapse-propagate-event: owner propagates event to children
::
++  poke-synapse-propagate-event
  =/  cha  (~(get by channel.sta) cha.eve)
  ?~  cha
    ~&  'no existing channel'
    [~ this]
  ?.  =(src.bol owner.cha)
    ~&  'someone is sending me a message they should not'
    [~ this]
  =/  apps  (~(get by mar.eve) marks.cha)
  =|  movs=(list move)
  |-
  ?~  apps
    =.  num.cha  num.eve
    :-  movs
    %=  this
      channels  (~(put by channel.sta) cha.eve cha)
    ==
  =.  movs
    %+  weld
    movs
    %+  turn  ~(tap in members.cha)
    [ost.bol %poke /(scot %ud wen.cha) [our.bol i.apps] [mar.eve dat.eve]]
  $(movs t.movs)
::
::  +poke-synapse-downstream-event: tell all my apps about an event
::
++  poke-synapse-downstream-event
  |=  eve=event
  ^-  (quip move _this)
  =/  cha  (~(get by channel.sta) cha.eve)
  ?~  cha
    ~&  'no existing channel'
    [~ this]
  ?.  =(src.bol owner.cha)
    ~&  'someone is sending me a message they should not'
    [~ this]
  =/  apps  (~(get by mar.eve) marks.cha)
  =|  movs=(list move)
  |-
  ?~  apps
    =.  num.cha  num.eve
    :-  movs
    %=  this
      channels  (~(put by channel.sta) cha.eve cha)
    ==
  =.  movs
    :_  movs
    [ost.bol %poke /(scot %ud wen.cha) [our.bol i.apps] [mar.eve dat.eve]]
  $(movs t.movs)
::
--
