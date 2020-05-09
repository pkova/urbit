import React, { Component } from 'react';
import { BrowserRouter, Switch, Route, Link } from "react-router-dom";
import _ from 'lodash';
import { HeaderBar } from "./lib/header-bar.js"

import { api } from '/api';
import { store } from '/store';
import { NewScreen } from '/components/new';
import { Book } from '/components/book'
import { SidebarSwitcher } from '/components/lib/icons/icon-sidebar-switch.js';
import { BooksTabBar } from './lib/books-tab-bar';
import { BookSubmit } from '/components/lib/book-submit.js';
import { makeRoutePath } from '../lib/util';
import { Pagination } from '/components/lib/pagination.js';
import { Books } from '/components/books';
import { MemberScreen } from '/components/member';
import { SettingsScreen } from '/components/settings';
import { ImportScreen } from '/components/import';

import { Skeleton } from '/components/skeleton';

import {  amOwnerOfGroup } from '../lib/util';

export class Root extends Component {
  constructor(props) {
    super(props);

    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
  }

  render() {
    const { state } = this;

    let contacts = !!state.contacts ? state.contacts : {};
    const groups = !!state.groups ? state.groups : {};

    const associations = !!state.associations ? state.associations : {books: {}, contacts: {}};
    let books = !!state.books ? state.books : {};
    let comments = !!state.comments ? state.comments : {};
    const seen = !!state.seen ? state.seen : {};

    const invites = state.invites ?
                    state.invites : {};

    let selectedGroups = !!state.selectedGroups ? state.selectedGroups : [];


    return (
      <BrowserRouter><Switch>
        <Route exact path="/~books" render={ () => {
          return (
            <Skeleton
              active="collections"
              associations={associations}
              invites={invites}
              groups={groups}
              rightPanelHide={true}
              sidebarShown={state.sidebarShown}
              selectedGroups={selectedGroups}
              links={books}
              listening={state.listening}>
              <div className="pl3 pr3 pt2 dt pb3 w-100 h-100">
                <p className="f8 pt3 gray2 w-100 h-100 dtc v-mid tc">
                  Select or create a shelf to begin.
                </p>
              </div>
            </Skeleton>

        )}}
        />
        <Route exact path="/~books/new"
               render={(props) => {
                 return (
                   <Skeleton
                     associations={associations}
                     invites={invites}
                     groups={groups}
                     rightPanelHide={true}
                     sidebarShown={state.sidebarShown}
                     selectedGroups={selectedGroups}
                     links={books}
                     listening={state.listening}>
                     <NewScreen
                       associations={associations}
                       groups={groups}
                       contacts={contacts}
                       {...props}
                     />
                   </Skeleton>
                 );
               }}
        />
        <Route exact path="/~books/join/:resource"
               render={ (props) => {
                 const resourcePath = '/' + props.match.params.resource;
                 api.joinShelf(resourcePath);
                 props.history.push(makeRoutePath(resourcePath));
               }}
        />
        <Route exact path="/~books/(popout)?/:resource/members"
               render={(props) => {
                 const popout = props.match.url.includes("/popout/");
                 const resourcePath = '/' + props.match.params.resource;
                 const resource = associations.books[resourcePath] || {metadata: {}};

                 const contactDetails = contacts[resource["group-path"]] || {};
                 const group = groups[resource["group-path"]] || new Set([]);
                 const amOwner = amOwnerOfGroup(resource["group-path"]);

                 return (
                   <Skeleton
                     associations={associations}
                     invites={invites}
                     groups={groups}
                     selected={resourcePath}
                     rightPanelHide={true}
                     sidebarShown={state.sidebarShown}
                     selectedGroups={selectedGroups}
                     links={books}
                     listening={state.listening}>
                     <MemberScreen
                       sidebarShown={state.sidebarShown}
                       resource={resource}
                       contacts={contacts}
                       contactDetails={contactDetails}
                       groupPath={resource["group-path"]}
                       group={group}
                       amOwner={amOwner}
                       resourcePath={resourcePath}
                       popout={popout}
                       {...props}
                     />
                   </Skeleton>
                 );
               }}
        />
        <Route exact path="/~books/(popout)?/:resource/import"
               render={(props) => {
                 const popout = props.match.url.includes("/popout/");
                 const resourcePath = '/' + props.match.params.resource;
                 const resource = associations.books[resourcePath] || {metadata: {}};

                 const contactDetails = contacts[resource["group-path"]] || {};
                 const group = groups[resource["group-path"]] || new Set([]);
                 const amOwner = amOwnerOfGroup(resource["group-path"]);

                 return (
                   <Skeleton
                     associations={associations}
                     invites={invites}
                     groups={groups}
                     selected={resourcePath}
                     rightPanelHide={true}
                     sidebarShown={state.sidebarShown}
                     selectedGroups={selectedGroups}
                     links={books}
                     listening={state.listening}>
                     <ImportScreen
                       sidebarShown={state.sidebarShown}
                       resource={resource}
                       contacts={contacts}
                       contactDetails={contactDetails}
                       groupPath={resource["group-path"]}
                       group={group}
                       amOwner={amOwner}
                       resourcePath={resourcePath}
                       popout={popout}
                       authorizationUrl={state.oauthUrl}
                       {...props}
                     />
                   </Skeleton>
                 );
               }}
        />
        <Route exact path="/~books/(popout)?/:resource/settings"
               render={ (props) => {
                 const popout = props.match.url.includes("/popout/");
                 const resourcePath = '/' + props.match.params.resource;
                 const resource = associations.books[resourcePath] || false;

                 const contactDetails = contacts[resource["group-path"]] || {};
                 const group = groups[resource["group-path"]] || new Set([]);
                 const amOwner = amOwnerOfGroup(resource["group-path"]);

                 return (
                   <Skeleton
                     associations={associations}
                     invites={invites}
                     groups={groups}
                     selected={resourcePath}
                     rightPanelHide={true}
                     sidebarShown={state.sidebarShown}
                     selectedGroups={selectedGroups}
                     popout={popout}
                     links={books}
                     listening={state.listening}>
                     <SettingsScreen
                       sidebarShown={state.sidebarShown}
                       resource={resource}
                       contacts={contacts}
                       contactDetails={contactDetails}
                       groupPath={resource["group-path"]}
                       group={group}
                       amOwner={amOwner}
                       resourcePath={resourcePath}
                       popout={popout}
                       {...props}
                     />
                   </Skeleton>
                 );
               }}
        />

        <Route exact path="/~books/(popout)?/:resource/:page?"
               render={ (props) => {
                 const resourcePath = '/' + props.match.params.resource;
                 const resource = associations.books[resourcePath] || {metadata: {}};

                 const amOwner = amOwnerOfGroup(resource["group-path"]);

                 let contactDetails = contacts[resource["group-path"]] || {};

                 let page = props.match.params.page || 0;

                 let popout = props.match.url.includes("/popout/");

                 let channelBooks = !!books[resourcePath]
                                  ? books[resourcePath]
                                  : {local: {}};

                 let channelComments = !!comments[resourcePath]
                                     ? comments[resourcePath]
                                     : {};

                 const channelSeen = !!seen[resourcePath]
                                   ? seen[resourcePath]
                                   : {};

                 let totalPages = state.books[resourcePath]
                                ? Number(state.books[resourcePath].totalPages)
                                : 1;

                 return (
                   <Skeleton
                     associations={associations}
                     invites={invites}
                     groups={groups}
                     selected={resourcePath}
                     sidebarShown={state.sidebarShown}
                     selectedGroups={selectedGroups}
                     sidebarHideMobile={true}
                     popout={popout}
                     links={books}
                     listening={state.listening}>
                     <Books
                       contacts={contactDetails}
                       books={channelBooks}
                       comments={channelComments}
                       seen={channelSeen}
                       page={page}
                       resourcePath={resourcePath}
                       resource={resource}
                       amOwner={amOwner}
                       popout={popout}
                       sidebarShown={state.sidebarShown}
                       {...props}
                     />
                   </Skeleton>
                 )
               }}
        />
      </Switch> </BrowserRouter>
    )
  }
}

