/+  *synapse
::
|_  [bol=bowl:gall sta=state]
::
++  this  .
::
++  prep
  |=  old=(unit state)
  ^-  (quip move _this)
  ?~  old
    [~ this]
  [~ this(sta u.old)]
::
::  +poke-synapse-create: my ship wants to create a channel
::
++  poke-synapse-create
  |=  =create
  ^-  (quip move _this)
  ?.  =(src.bol our.bol)
    [~ this]
  =/  uid  (shaf our.bol eny.bol)
  =/  channel=channel
    :*  uid
        our.bol
        ~
        write-permission.create
        read-permission.create
        marks.create
        0
    ==
  :-  ~  :: todo: send invites
  %=  this
    channels.sta  (~(put by channels.sta) uid channel)
  ==
::
::  +poke-synapse-invite: my ship has received an invite from the owner of
::  a channel
::
++  poke-synapse-invite
  |=  =invite
  ^-  (quip move _this)
  [~ this]
  ::  must come from app on our system
::
::  +poke-synapse-join: my ship wants to join a channel someone else created
::
++  poke-synapse-join
  |=  =invite
  ^-  (quip move _this)
  ::  check if this channel is in pending. If so, remove it.
  ::  check if I already have this channel. If so, no-op.
  [~ this]
::
::  +poke-synapse-upstream-event: my ship is owner of channel, so when ships
::  with the write permission send me an event, my ship sends to my apps to
::  process the event to decide whether to propagate it
::
++  poke-synapse-upstream-event
  |=  eve=event
  ^-  (quip move _this)
  =/  cha  (~(get by channels.sta) channel.eve)
  ?~  cha
    ~&  'no existing channel'
    [~ this]
  [~ this]
  ::  check permission of sender
  ::  if sender permission checks out, send the event to all my apps
::
::  +poke-synapse-propagate-event: my ship is owner of channel, so it
::  propagates the event to all channel subscribers in the members set
::
++  poke-synapse-propagate-event
  |=  eve=event
  ^-  (quip move _this)
  =/  cha  (~(get by channels.sta) channel.eve)
  ?~  cha
    ~&  'no existing channel'
    [~ this]
  ?.  =(src.bol owner.u.cha)
    ~&  'someone is sending me a message they should not'
    [~ this]
  =/  apps=(list @tas)  (~(got by marks.u.cha) mark.eve)
  =/  metadata=event-metadata  [%down uid.u.cha number.eve]
  =|  movs=(list move)
  |-
  ?~  apps
    =.  number.u.cha  number.eve
    :-  movs
    %=  this
      channels.sta  (~(put by channels.sta) channel.eve u.cha)
    ==
  =.  movs
    %+  weld
    movs
    %+  turn  ~(tap in members.u.cha)
    |=  member=@p
    ^-  move
    [ost.bol %poke /propagate [member i.apps] [mark.eve [metadata data.eve]]]
  $(apps t.apps)
::
::  +poke-synapse-downstream-event: owner of channel sends me a message
::  and then my ship tells all of my associated apps about the new event
::
++  poke-synapse-downstream-event
  |=  eve=event
  ^-  (quip move _this)
  =/  cha  (~(get by channels.sta) channel.eve)
  ?~  cha
    ~&  'no existing channel'
    [~ this]
  ?.  =(src.bol owner.u.cha)
    ~&  'someone is sending me a message they should not'
    [~ this]
  =/  apps=(list @tas)  (~(got by marks.u.cha) mark.eve)
  =/  metadata=event-metadata  [%down uid.u.cha number.eve]
  =|  movs=(list move)
  |-
  ?~  apps
    =.  number.u.cha  number.eve
    :-  movs
    %=  this
      channels.sta  (~(put by channels.sta) channel.eve u.cha)
    ==
  =.  movs
    :_  movs
    [ost.bol %poke /down [our.bol i.apps] [mark.eve [metadata data.eve]]]
  $(apps t.apps)
::
--
