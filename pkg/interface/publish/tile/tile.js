import React, { Component } from 'react'
import classnames from 'classnames';


export default class PublishTile extends Component {
  constructor(props){
    super(props);
  }

  render(){
    console.log("tile", this.props);

    let info = [];
    if (this.props.data.invites > 0) {
      let text = (this.props.data.invites == 1)
        ?  "Invite"
        :  "Invites"
      info.push(
        <p key={1}>
          <span className="green-medium">{this.props.data.invites} </span>
          <span>{text}</span>
        </p>
      );
    }
    if (this.props.data.new > 0) {
      let text = (this.props.data.new == 1)
        ?  "New Post"
        :  "New Posts"
      info.push(
        <p key={2}>
          <span className="green-medium">{this.props.data.new} </span>
          <span>{text}</span>
        </p>
      );
    }

    return (
      <div className="w-100 h-100 relative" style={{background: "#1a1a1a"}}>
        <a className="w-100 h-100 db no-underline" href="/~publish">
          <p className="gray label-regular b absolute"
            style={{left: 8, top: 4}}>
            Publish
          </p>
          <img
            className="absolute"
            style={{left: 60, top: 66}}
            src="/~publish/tile.png"
            width={113}
            height={102} />
          <div className="absolute w-100 flex-col body-regular white"
            style={{verticalAlign: "bottom", bottom: 8, left: 8}}>
            {info}
          </div>
        </a>
      </div>
    );
  }
}

window.publishTile = PublishTile;
