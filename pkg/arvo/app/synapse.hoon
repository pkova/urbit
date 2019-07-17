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
::  +poke-synapse-action: main action handler
::
++  poke-synapse-action
  |=  =action
  ^-  (quip move _this)
  ?-  -.action
    %create
      (create-action +.action)
    %invite
      (invite-action +.action)
    %join
      (join-action +.action)
    %update
      (update-action +.action)
    %delete
      (delete-action +.action)
    %follow
      (follow-action +.action)
  ==
::
::  +create-action: my ship wants to create a channel
::
++  create-action
  |=  =create
  ^-  (quip move _this)
  ?.  =(src.bol our.bol)
    [~ this]
  =/  uid  (shaf our.bol eny.bol)
  =/  channel=channel
    :*  uid
        our.bol
        (silt [our.bol]~)
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
::  +invite-action: my ship has received an invite from the owner of
::  a channel
::
++  invite-action
  |=  [uid=@t shp=@p]
  ^-  (quip move _this)
  ::  check if invite uid is in join-requests. if so, auto-join.
  ?:  (~(has in join-requests.sta) uid)
    :-  [ost.bol %poke / [shp %synapse] [%synapse-action [%follow uid %.y]]]~
    this
  ::  otherwise, just add it to the invites
  :-  ~  :: todo: tell our local subscribers that we got an invite
  this(invites.sta (~(put in invites.sta [uid shp])))
::
::  +join-action: my ship wants to join a channel someone else created
::
++  join-action
  |=  [uid=@t shp=@p]
  ^-  (quip move _this)
  ?.  =(src.bol our.bol)
    [~ this]
  ?~  (~(has by channels.sta) uid)
  ::  check if this channel is in pending. If so, remove it.
  ::  check if I already have this channel. If so, no-op.
  ::  otherwise, send a follow action to the ship.
  [~ this]
::
::  +update-action: my ship updates a channel it owns
::
++  update-action
  |=  update=channel
  ^-  (quip move _this)
  ?.  =(owner.update our.bol)
    [~ this]
  :-
  %+  turn  ~(tap in (~(uni in members.channel) members.update))
  |=  shp=@p
  ^-  move
  [ost.bol %poke / [shp %synapse] [%synapse-action [%external-update update]]]
  %=  this
    channels.sta  (~(put by channels.sta) uid update)
  ==
::
::  +update-action: my ship receives an update from the owner of a channel
::
++  external-update-action
  |=  update=channel
  ^-  (quip move _this)
  ::  this can generate delete-actions
  =/  cha=(unit channel)  (~(get by channels.sta) owner.update)
  ?~  cha
  ?:  (~(has in join-requests) [uid.update owner.update])
    [~ this(channels.sta (~(put by channels.sta) update))]
::
::  +delete-action: delete actions can come from other apps on your ship
::  or are generated when you receive an external-update telling you you are 
::  no longer an allowed member of the channel
::
++  delete-action
  |=  delete=@t
  ^-  (quip move _this)
  ?:  =(src.bol our.bol)
    [~ this(channels.sta (~(del by channels.sta) delete))]
  [~ this]
::
::  +follow-action: receive a follow action when someone else wants to add or
::  remove themselves from your channel. decide to allow or deny based on
::  read/write permissions
::
++  follow-action
  |=  follow=?
  ^-  (quip move _this)
  ::  If requesting ship is allowed by either
  ::  the read or the write permission group, send it back the channel
  ::  as a channel external-update
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
  ::  check write permission of sender
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
