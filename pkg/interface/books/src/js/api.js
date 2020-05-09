import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

import { store } from '/store';

class UrbitApi {
  setAuthTokens(authTokens) {
    this.authTokens = authTokens;
    this.bindPaths = [];
  }

  bind(path, method, ship = this.authTokens.ship, appl, success, fail) {
    this.bindPaths = _.uniq([...this.bindPaths, path]);

    window.subscriptionId = window.urb.subscribe(ship, appl, path, 
      (err) => {
        fail(err);
      },
      (event) => {
        success({
          data: event,
          from: {
            ship,
            path
          }
        });
      },
      (err) => {
        fail(err);
      });
  }

  bindBooksView(path, result, fail, quit) {
    this.bind.bind(this)(
      path, 'PUT', this.authTokens.ship, 'books-view',
      result, fail, quit
    );
  }


  booksStoreAction(data) {
    return this.action('books-store', 'books-action', data);
  }

  booksViewAction(data) {
    return this.action('books-view', 'books-view-action', data);
  }

  booksListenAction(data) {
    return this.action('books-listen-hook', 'books-listen-action', data);
  }

  booksImportAction(data) {
    return this.action('books-import-hook', 'books-import-action', data);
  }

  requestOauthToken(consumerKey, consumerSecret) {
    return this.booksImportAction({'request-token': {consumerKey, consumerSecret}});
  }

  requestAccessToken() {
    return this.booksImportAction({'access-token': null});
  }

  groupsAction(data) {
    return this.action('group-store', 'group-action', data);
  }

  metadataAction(data) {
    return this.action('metadata-hook', 'metadata-action', data);
  }

  inviteAction(data) {
    return this.action('invite-store', 'json', data);
  }

  addBook(path, book) {
    const add = Object.assign({path}, book);
    return this.booksStoreAction({add});
  }

  startImport(path, profileId) {
    return this.booksImportAction({'import': {path, profileId}});
  }

  createShelf(path, title, description, members, realGroup) {
    // members is either {group:'/group-path'} or {'ships':[~zod]},
    // with realGroup signifying if ships should become a managed group or not.
    return this.booksViewAction({
      'create': {path, title, description, members, realGroup}
    });
  }

  action(appl, mark, data) {
    return new Promise((resolve, reject) => {
      window.urb.poke(ship, appl, mark, data,
        (json) => {
          resolve(json);
        },
        (err) => {
          reject(err);
        });
    });
  }

  getPage(path, page) {
    const endpoint = '/json/' + page + '/local-books' + path;
    this.bindBooksView(endpoint,
                       (dat)=>{store.handleEvent(dat)},
                       console.error,
                       ()=>{} // no-op on quit
                      );
  }

  joinShelf(path) {
    return this.booksListenAction({ watch: path });
  }

  removeShelf(path) {
    return this.booksListenAction({ leave: path });
  }

  deleteShelf(path) {
    return this.booksViewAction({
      'delete': {path}
    });
  }

  groupRemove(path, members) {
    return this.groupsAction({
      remove: {
        path, members
      }
    });
  }

  inviteToShelf(path, ships) {
    return this.booksViewAction({
      'invite': {path, ships}
    });
  }

  inviteAccept(uid) {
    return this.inviteAction({
      accept: {
        path: '/books',
        uid
      }
    });
  }

  inviteDecline(uid) {
    return this.inviteAction({
      decline: {
        path: '/books',
        uid
      }
    });
  }

  requestOauthUrl() {
    return fetch('/~books/oauth-url').then(res => res.json());
  }

  metadataAdd(appPath, groupPath, title, description, dateCreated, color) {
    return this.metadataAction({
      add: {
        'group-path': groupPath,
        resource: {
          'app-path': appPath,
          'app-name': 'books'
        },
        metadata: {
          title,
          description,
          color,
          'date-created': dateCreated,
          creator: `~${window.ship}`
        }
      }
    });
  }

  sidebarToggle() {
    let sidebarBoolean = true;
    if (store.state.sidebarShown === true) {
      sidebarBoolean = false;
    }
    store.handleEvent({
      data: {
        local: {
          'sidebarToggle': sidebarBoolean
        }
      }
    });
  }
}

export let api = new UrbitApi();
window.api = api;
