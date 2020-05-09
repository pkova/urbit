import { api } from '/api';
import { store } from '/store';

import urbitOb from 'urbit-ob';


export class Subscription {
  start() {
    if (api.authTokens) {
      this.initializeBooks();
    } else {
      console.error("~~~ ERROR: Must set api.authTokens before operation ~~~");
    }
  }

  initializeBooks() {
    // api.bind('/primary', 'PUT', api.authTokens.ship, 'books',
    //   this.handleEvent.bind(this),
    //   this.handleError.bind(this));

    api.bind('/all', 'PUT', api.authTokens.ship, 'group-store',
      this.handleEvent.bind(this),
      this.handleError.bind(this),
      this.handleQuitAndResubscribe.bind(this)
    );
    api.bind('/primary', 'PUT', api.authTokens.ship, 'contact-view',
      this.handleEvent.bind(this),
      this.handleError.bind(this),
      this.handleQuitAndResubscribe.bind(this)
    );
    api.bind('/primary', 'PUT', api.authTokens.ship, 'invite-view',
      this.handleEvent.bind(this),
      this.handleError.bind(this),
      this.handleQuitAndResubscribe.bind(this));
    api.bind('/app-name/books', 'PUT', api.authTokens.ship, 'metadata-store',
      this.handleEvent.bind(this),
      this.handleError.bind(this),
      this.handleQuitAndResubscribe.bind(this)
    );
    api.bind('/app-name/contacts', 'PUT', api.authTokens.ship, 'metadata-store',
      this.handleEvent.bind(this),
      this.handleError.bind(this),
      this.handleQuitAndResubscribe.bind(this)
    );

    // open a subscription for what collections we're listening to
    api.bind('/listening', 'PUT', api.authTokens.ship, 'books-listen-hook',
      this.handleEvent.bind(this),
      this.handleError.bind(this),
      this.handleQuitAndResubscribe.bind(this)
    );

    api.bind('/oauth-url', 'PUT', api.authTokens.ship, 'books-import-hook',
      this.handleEvent.bind(this),
      this.handleError.bind(this),
      this.handleQuitAndResubscribe.bind(this)
    );

    api.getPage('', 0);

  }

  handleEvent(diff) {
    store.handleEvent(diff);
  }

  handleError(err) {
    console.error(err);
    api.bind('/primary', 'PUT', api.authTokens.ship, 'books',
      this.handleEvent.bind(this),
      this.handleError.bind(this));
  }


  fetchBooks() {
    // fetch('/~books/all')
    //   .then((response) => response.json())
    //   .then((json) => {
    //     store.handleEvent({
    //       data: json
    //     });
    //   });
  }

  handleQuitAndResubscribe(quit) {
    // TODO: resubscribe
  }
}

export let subscription = new Subscription();
