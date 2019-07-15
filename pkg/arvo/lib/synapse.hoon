|%
::
::  +permission: main permission model
::
+$  permission  (each [%white (set @p)] [%black (set @p)])
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
::  +invite: data type another ship sends to invite you to a channel
::
+$  invite  [uid=@t channel=channel]
::
::  +event-type: either an upstream or a downstream event
::
+$  event-type  (each %up %down)
::
::  +event: event data
::
+$  event  [type=event-type channel=@t number=@ mark=@tas data=*]
::
::  +event-metadata: all event metadata
::
+$  event-metadata  [channel=@t number=@ type=event-type]
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
      pending=(map @t channel)
  ==
::
+$  state
  $%  [%0 state-zero]
  ==
::
--

