import React, { Component } from 'react';
import { LoadingScreen } from './loading';
import { BooksTabBar } from './lib/books-tab-bar';
import { SidebarSwitcher } from '/components/lib/icons/icon-sidebar-switch.js';
import { Route, Link } from "react-router-dom";
import { BookSubmit } from '/components/lib/book-submit.js';
import { Pagination } from '/components/lib/pagination.js';
import { Book } from '/components/book.js';

import { makeRoutePath, getContactDetails } from '../lib/util';
import { api } from '/api';

export class Books extends Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.componentDidUpdate();
  }

  componentDidUpdate() {
    const booksPage = this.props.page;
    if ( (booksPage != 0) &&
         (!this.props.books[booksPage] ||
          this.props.books.local[booksPage])
    ) {
      api.getPage(this.props.resourcePath, this.props.page);
    }
  }

  render() {
    let props = this.props;

    if (!props.resource.metadata.title) {
      return <LoadingScreen/>;
    }

    let booksPage = props.page;

    let books = !!props.books[booksPage]
    ? props.books[booksPage]
    : {};

    let currentPage = !!props.page
    ? Number(props.page)
    : 0;

    let totalPages = !!props.books
    ? Number(props.books.totalPages)
    : 1;

    let BooksList = Object.keys(books)
    .map((booksIndex) => {
      let booksObj = props.books[booksPage];
      let { id,
            title,
            author,
            coverUrl,
            rating,
            pages,
            read,
            published,
            added
      } = booksObj[booksIndex];
      let members = {};

      const commentCount = props.comments[id]
        ? props.comments[id].totalItems
        : booksObj[booksIndex].commentCount || 0;


      return (
        <Book
          key={title}
          title={title}
          author={author}
          coverUrl={coverUrl}
          rating={rating}
          pages={pages}
          read={read}
          published={published}
          added={added + id}
          comments={commentCount}
        />
      )
    })

    return (
      <div className="cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d">
        <div
          className={`pl4 pt2 flex relative overflow-x-scroll
         overflow-x-auto-l overflow-x-auto-xl flex-shrink-0
         bb b--gray4 b--gray1-d bg-gray0-d`}
          style={{ height: 48 }}>
          <SidebarSwitcher
            sidebarShown={props.sidebarShown}
            popout={props.popout}/>
          <Link to={makeRoutePath(props.resourcePath, props.popout, props.page)} className="pt2">
            <h2 className={`dib f9 fw4 lh-solid v-top`}>
              {props.resource.metadata.title}
            </h2>
          </Link>
          <BooksTabBar
            {...props}
            amOwner={props.amOwner}
            popout={props.popout}
            page={props.age}
            resourcePath={props.resourcePath}/>
        </div>
        <div className="w-100 mt6 flex justify-center overflow-y-scroll ph4 pb4">
          <div className="w-100 mw7">
            <div className="flex">
              <BookSubmit resourcePath={props.resourcePath}/>
            </div>
            <div className="h-100 w-100 overflow-y-scroll flex flex-column">
              <table className="inter">
                <thead>
                  <tr>
                    <th>Cover</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Rating</th>
                    <th>Pages</th>
                    <th>Published</th>
                    <th>Read</th>
                    <th>Added</th>
                  </tr>
                </thead>
                <tbody>
                  {BooksList}
                </tbody>
              </table>
              <Pagination
                {...props}
                key={props.resourcePath + props.page}
                popout={props.popout}
                resourcePath={props.resourcePath}
                currentPage={currentPage}
                totalPages={totalPages}
              />
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Links;
