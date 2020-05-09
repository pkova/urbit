import React, { Component } from 'react';
import moment from 'moment';

const defaultImage = (event) => {
  event.target.onerror = null;
  event.target.src = '/~books/img/Tile.png';
}

const getRead = (read) => {
  if (read === null) {
    return '';
  }
  return '~' + moment.unix(read / 1000).format('YYYY.M.D');
}

export const Book = (props) => {
  return(
    <tr style={{textAlign: 'center'}}>
      <td>
        <img src={props.coverUrl}
             onError={defaultImage}
             style={{maxHeight: '160px',
                     height: 'auto',
                     width: 'auto'}} />
      </td>
      <td>{props.title}</td>
      <td>{props.author}</td>
      <td>{props.rating}</td>
      <td>{props.pages}</td>
      <td>{'~' + moment(props.published, 'ddd, D MMM y HH:mm:ss Z').format('YYYY.M.D')}</td>
      <td>{getRead(props.read)}</td>
      <td>{'~' + moment.unix(props.added / 1000).format('YYYY.M.D')}</td>
    </tr>
  )
}
