import React, { Component } from 'react';
import { Link } from "react-router-dom";
import { SidebarSwitcher } from '/components/lib/icons/icon-sidebar-switch.js';
import { makeRoutePath } from '../lib/util';
import { BooksTabBar } from './lib/books-tab-bar';

export class ImportScreen extends Component {
  constructor(props) {
    super(props);

    this.state = {
      consumerKey: '',
      consumerSecret: '',
      profileId: ''
    };

    this.setConsumerKey = this.setConsumerKey.bind(this);
    this.setConsumerSecret = this.setConsumerSecret.bind(this);
    this.setProfileId = this.setProfileId.bind(this);
    this.requestAuthorizationUrl = this.requestAuthorizationUrl.bind(this);
    this.requestAccessToken = this.requestAccessToken.bind(this);
    this.startImport = this.startImport.bind(this);
  }

  componentDidMount() {
  }

  setConsumerKey() {
    this.setState({consumerKey: event.target.value});
  }

  setConsumerSecret() {
    this.setState({consumerSecret: event.target.value});
  }

  setProfileId () {
    this.setState({profileId: event.target.value});
  }

  requestAuthorizationUrl() {
    api.requestOauthToken(this.state.consumerKey, this.state.consumerSecret);
  }

  requestAccessToken() {
    api.requestAccessToken();
  }

  startImport() {
    api.startImport(this.props.resourcePath, this.state.profileId);
  }

  render() {
    const { props, state } = this;

    return (
      <div className="h-100 w-100 overflow-x-hidden flex flex-column white-d">
        <div
          className="w-100 dn-m dn-l dn-xl inter pt4 pb6 pl3 f8"
          style={{ height: "1rem" }}>
          <Link to="/~books">{"⟵ All Shelves"}</Link>
        </div>
        <div
          className="pl4 pt2 bb b--gray4 b--gray1-d flex relative overflow-x-scroll overflow-x-auto-l overflow-x-auto-xl flex-shrink-0"
          style={{ height: 48 }}>
          <SidebarSwitcher
            sidebarShown={this.props.sidebarShown}
            popout={this.props.popout}
          />
          <Link to={makeRoutePath(props.resourcePath, props.popout)}
                className="pt2">
            <h2
              className="dib f9 fw4 lh-solid v-top"
              style={{ width: "max-content" }}>
              {props.resource.metadata.title}
            </h2>
          </Link>
          <BooksTabBar {...props}/>
        </div>
        <div className="w-100 pl3 mt4 cf">
          <h2 className="f8 pb2">Goodreads import</h2>
          <p className="f9 gray2 db mb4">Start by requesting an API key at <a href="https://www.goodreads.com/api/keys">https://www.goodreads.com/api/keys</a></p>
          <p className="f8 mt3 lh-copy">API key</p>
          <div className="relative w-100 flex"
               style={{maxWidth: "29rem"}}>
            <input
              className={"f8 ba b--gray3 b--gray2-d bg-gray0-d white-d " +
                         "focus-b--black focus-b--white-d pa3 db w-100 flex-auto mr3"}
              onChange={this.setConsumerKey}
            />
          </div>
          <p className="f8 mt3 lh-copy">API secret</p>
          <div className="relative w-100 flex"
               style={{maxWidth: "29rem"}}>
            <input
              className={"f8 ba b--gray3 b--gray2-d bg-gray0-d white-d " +
                         "focus-b--black focus-b--white-d pa3 db w-100 flex-auto mr3"}
              onChange={this.setConsumerSecret}
            />
          </div>
          <div className="w-100 fl mt3">
            <a className="dib f9 black gray4-d bg-gray0-d ba pa2 b--black b--gray1-d pointer"
               onClick={this.requestAuthorizationUrl}>
              Request authorization url
            </a>
          </div>
          {this.props.authorizationUrl &&
           <>
             <div className="w-100 fl mt3">
               <p className="f9 gray2 db mb4">Next visit <a href={this.props.authorizationUrl}>{this.props.authorizationUrl}</a> to authorize your application to access your Goodreads account. When you're finished, press the button below.</p>
             </div>
             <a className="dib f9 black gray4-d bg-gray0-d ba pa2 b--black b--gray1-d pointer"
                onClick={this.requestAccessToken}>
               Request access token
             </a>
             <div className="w-100 fl mt3">
               <p className="f9 gray2 db mb4">Finally, you need to enter your Goodreads profile ID. You can find it in the URL of your Goodreads profile page.</p>
             </div>
             <p className="f8 mt3 lh-copy">Goodreads profile ID</p>
             <div className="relative w-100 flex"
                  style={{maxWidth: "29rem"}}>
               <input
                 className={"f8 ba b--gray3 b--gray2-d bg-gray0-d white-d " +
                            "focus-b--black focus-b--white-d pa3 db w-100 flex-auto mr3"}
                 onChange={this.setProfileId}
               />
             </div>
             <div className="w-100 fl mt3">
               <a className="dib f9 black gray4-d bg-gray0-d ba pa2 b--black b--gray1-d pointer"
                  onClick={this.startImport}>
                 Import
               </a>
             </div>
           </>
          }
        </div>
      </div>
    );
  }
}
