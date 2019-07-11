::
|%
:: +move: output effect
::
+$  move  [bone card]
:: +card: output effect payload
::
+$  event  [cha=@t num=@ wen=@da mar=@tas dat=*]
::
+$  poke
  $%  [%synapse-event event]
  ==
::
+$  card
  $%  [%poke wire dock poke]
  ==
::
--
::
|_  [bol=bowl:gall sta=~]
::
++  this  .
::
++  prep
  |=  old=(unit sta=~)
  ^-  (quip move _this)
  :-  ~
  this
::
++  poke-synapse-json
  |=  [cha=@t num=@ wen=@da jon=json]
  ~&  'do stuff'
  [~ this]
::
--
