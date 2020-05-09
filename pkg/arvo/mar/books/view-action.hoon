/-  *books-view
=,  dejs:format
|_  act=books-view-action
++  grab
  |%
  ++  noun  books-view-action
  ++  json
    |^  %-  of
        :~  %create^create
            %delete^delete
            %invite^invite
        ==
    ::
    ++  create
      %-  ot
      :~  'path'^pa
          'title'^so
          'description'^so
          'members'^mems
          'realGroup'^bo
      ==
    ::
    ++  mems
      (of %group^pa %ships^ships ~)
    ::
    ++  delete
      (ot 'path'^pa ~)
    ::
    ++  invite
      (ot 'path'^pa 'ships'^ships ~)
    ::
    ::TODO  stdlib
    ++  ships
      (cu sy (ar (su ;~(pfix sig fed:ag))))
    ::
    --
  --
::
++  grow
  |%
  ++  noun  act
  --
--
