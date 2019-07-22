import React, { Component } from 'react';
import classnames from 'classnames';

export class PostSnippet extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    let elem = this.props.body.c.find((elem) => {
      return (elem.gn === "p" && typeof(elem.c[0]) === "string");
    });

    let string = (elem === undefined)
      ?  null
      :  elem.c[0];

    return (
      <p className="body-regular-400 five-lines"
        style={{WebkitBoxOrient: "vertical"}}>
        {string}
      </p>
    );
  }
}

