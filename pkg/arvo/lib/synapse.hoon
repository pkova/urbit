|%
::
::  +permission: main permission model
::
+$  permission
  $%  [%white (set @p)]
      [%black (set @p)]
  ==
::
::  +channel: main abstraction for a message bus
::
+$  channel
  $:  uid=@t
      owner=@p
      members=(set @p)
      write-permission=permission
      read-permission=permission
      marks=(map @tas (list @tas))
      number=@
  ==
::
::  +create: data type an app sends to create a channel
::
+$  create
  $:  write-permission=permission
      read-permission=permission
      invites=(set @p)
      marks=(map @tas (list @tas))
  ==
::
+$  action
  $%  [%create create]
      [%invite @t]
      [%join [@t @p]]
      [%update channel]
      [%external-update channel]
      [%delete @t]
      [%follow [@t ?]]
  ==
::
::  +event-type: either an upstream or a downstream event
::
+$  event-type  ?(%up %down)
::
::  +event: event data
::
+$  event  [type=event-type channel=@t number=@ mark=@tas data=*]
::
::  +event-metadata: all event metadata
::
+$  event-metadata  [type=event-type channel=@t number=@]
::
:: +move: output effect
::
+$  move  [bone card]
::
:: +card: output effect payload
::
+$  card
  $%  [%poke wire dock [@tas [event-metadata *]]]
  ==
::
+$  state-zero
  $:  channels=(map @t channel)
      invites=(set [@t @p])
      join-requests=(set [@t @p])
  ==
::
+$  state
  $%  [%0 state-zero]
  ==
::
--

