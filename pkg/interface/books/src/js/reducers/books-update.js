import _ from 'lodash';

// page size as expected from books-view.
// must change in parallel with the +page-size in /app/books-view to
// ensure sane behavior.
const PAGE_SIZE = 25;

export class BooksUpdateReducer {
  reduce(json, state) {
    this.booksPage(json, state);
    this.booksUpdate(json, state);
    this.discussionsPage(json, state);
    this.discussionsUpdate(json, state);
  }

  booksPage(json, state) {
    let data = _.get(json, 'initial-books', false);
    if (data) {
      //  { "initial-submissions": {
      //    "/~ship/group": {
      //      page: [{commentCount: 0, ...restOfBook}]
      //      page-number: 0
      //      total-items: 1
      //      total-pages: 1
      //    }
      //  } }

      for (var path of Object.keys(data)) {
        const here = data[path];
        const page = here.pageNumber;

        // if we didn't have any state for this path yet, initialize.
        if (!state.books[path]) {
          state.books[path] = {local: {}};
        }

        // since data contains an up-to-date full version of the page,
        // we can safely overwrite the one in state.
        state.books[path][page] = here.page;
        state.books[path].local[page] = false;
        state.books[path].totalPages = here.totalPages;
        state.books[path].totalItems = here.totalItems;

      }
    }
  }

  booksUpdate(json, state) {
    let data = _.get(json, 'local-books', false);
    if (data) {
      //  { "books": {
      //    path: /~ship/group
      //    pages: [{...book}]
      //  } }

      const path = data.path;

      // stub in a comment count, which is more or less guaranteed to be 0
      data.pages = data.pages.map(book => {
        book.commentCount = 0;
        return book;
      });

      // add the new submissions to state, update totals
      state.books[path] = this._addNewItems(
        data.pages, state.books[path]
      );
    }
  }

  discussionsPage(json, state) {
    let data = _.get(json, 'initial-discussions', false);
    if (data) {
      //  { "initial-discussions": {
      //    path: "/~ship/group"
      //    id: 0
      //    page: [{book}]
      //    page-number: 0
      //    total-items: 1
      //    total-pages: 1
      //  } }

      const path = data.path;
      const id = data.url;
      const page = data.pageNumber;

      // if we didn't have any state for this path yet, initialize.
      if (!state.comments[path]) {
        state.comments[path] = {};
      }
      if (!state.comments[path][id]) {
        state.comments[path][id] = {local: {}};
      }
      let here = state.comments[path][id];

      // since data contains an up-to-date full version of the page,
      // we can safely overwrite the one in state.
      here[page] = data.page;
      here.local[page] = false;
      here.totalPages = data.totalPages;
      here.totalItems = data.totalItems;
    }
  }

  discussionsUpdate(json, state) {
    let data = _.get(json, 'discussions', false);
    if (data) {
      //  { "discussions": {
      //    path: /~ship/path
      //    id: 0
      //    comments: [{ship, timestamp, udon}]
      //  } }

      const path = data.path;
      const id = data.id;

      // add new comments to state, update totals
      state.comments[path][id] = this._addNewItems(
        data.comments, state.comments[path][id]
      );
    }
  }

  _addNewItems(items, pages, page = 0) {
    if (!pages) {
      pages = {
        local: {},
        totalPages: 0,
        totalItems: 0
      };
    }
    const i = page;
    if (!pages[i]) {
      pages[i] = [];
      // if we know this page exists in the backend, flag it as "local",
      // so that we know to initiate a "fetch the rest" request when we want
      // to display the page.
      pages.local[i] = (page < pages.totalPages);
    }
    pages[i] = items.concat(pages[i]);
    pages[i].sort((a, b) => b.added - a.added);
    pages.totalItems = pages.totalItems + items.length;
    if (pages[i].length <= PAGE_SIZE) {
      pages.totalPages = Math.ceil(pages.totalItems / PAGE_SIZE);
      return pages;
    }
    // overflow into next page
    const tail = pages[i].slice(PAGE_SIZE);
    pages[i].length = PAGE_SIZE;
    pages.totalItems = pages.totalItems - tail.length;
    return this._addNewItems(tail, pages, page+1);
  }

}
