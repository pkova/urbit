import React, { Component } from 'react';
import _ from 'lodash';


export default class booksTile extends Component {

  render() {
    return (
      <div className="w-100 h-100 relative bg-white bg-gray0-d ba b--black b--gray1-d">
        <a className="w-100 h-100 db pa2 no-underline" href="/~books">
          <p className="black white-d absolute f9" style={{ left: 8, top: 8 }}>Books</p>
          <img className="absolute" src="/~books/img/Tile.png" style={{top: 21, left: 14, height: 100, width: 100}}/>
        </a>
      </div>
    );
  }

}

window['books-viewTile'] = booksTile;
