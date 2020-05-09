import React, { Component } from "react";
import { api } from "../../api";
import { IconSpinner } from './icons/icon-spinner';
import { dateToDa } from '/lib/util';

import moment from 'moment';

export class BookSubmit extends Component {
  constructor() {
    super();
    this.state = {
      title: '',
      coverUrl: '',
      author: '',
      rating: '',
      pages: '',
      published: '',
      read: '',
      coverUrlValid: false,
      submitFocus: false,
      submitFocusLeaving: false,
      disabled: false
    };
    this.setTitle = this.setTitle.bind(this);
    this.setCoverUrl = this.setCoverUrl.bind(this);
    this.setAuthor = this.setAuthor.bind(this);
    this.setRating = this.setRating.bind(this);
    this.setPages = this.setPages.bind(this);
    this.setPublished = this.setPublished.bind(this);
    this.setRead = this.setRead.bind(this);
    this.onBlur = this.onBlur.bind(this);
    this.onFocus = this.onFocus.bind(this);
  }

  onClickPost() {
    let title = this.state.title;
    let coverUrl = this.state.coverUrl;
    let author = this.state.author;
    let rating = parseInt(this.state.rating);
    let pages = parseInt(this.state.pages);
    let published = dateToDa(moment(this.state.published, '~YYYY.MM.DD').toDate());
    let read = moment(this.state.read, '~YYYY.MM.DD').unix();

    let book = {title, coverUrl, author, rating, pages, published, read};

    this.setState({disabled: true});
    api.addBook(this.props.resourcePath, book).then(r => {
      this.setState({
        title: '',
        coverUrl: '',
        author: '',
        rating: '',
        pages: '',
        published: '',
        read: '',
        coverUrlValid: false,
        submitFocus: false,
        disabled: false
      });
    });
  }


  setTitle(event) {
    this.setState({ title: event.target.value });
  }

  setCoverUrl(event) {
    this.setState({ coverUrl: event.target.value });
  }

  setAuthor(event) {
    this.setState({ author: event.target.value });
  }

  setRating(event) {
    this.setState({ rating: event.target.value });
  }

  setPages(event) {
    this.setState({ pages: event.target.value });
  }

  setPublished(event) {
    this.setState({ published: event.target.value });
  }

  setRead(event) {
    this.setState({ read: event.target.value });
  }

  onBlur() {
    this.setState({ submitFocusLeaving: true });
    setTimeout(() => this.setState((prevState) => {
      if (prevState.submitFocusLeaving) {
        return {submitFocus: false};
      }
      return null;
    }), 50)
  }

  onFocus() {
    this.setState({ submitFocus: true,
                    submitFocusLeaving: false });
  }

render() {
  let activeClasses = !this.state.disabled
      ? "green2 pointer" : "gray2";

    let focus = (this.state.submitFocus)
      ? "b--black b--white-d"
      : "b--gray4 b--gray2-d"

    let additionalInput = this.state.submitFocus ?
      <>
        <textarea
          className="pl2 bg-gray0-d white-d w-100 f8"
          style={{
            resize: "none",
            height: 40,
            paddingTop: 16
          }}
          placeholder="Cover URL"
          onChange={this.setCoverUrl}
          onBlur={this.onBlur}
          onFocus={this.onFocus}
          spellCheck="false"
          rows={1}
          onKeyPress={e => {
            if (e.key === "Enter") {
              e.preventDefault();
              this.onClickPost();
            }
          }}
          value={this.state.coverUrl}
        />
        <textarea
          className="pl2 bg-gray0-d white-d w-100 f8"
          style={{
            resize: "none",
            height: 40,
            paddingTop: 16
          }}
          placeholder="Author"
          onChange={this.setAuthor}
          onBlur={this.onBlur}
          onFocus={this.onFocus}
          spellCheck="false"
          rows={1}
          onKeyPress={e => {
            if (e.key === "Enter") {
              e.preventDefault();
              this.onClickPost();
            }
          }}
          value={this.state.author}
        />
        <textarea
          className="pl2 bg-gray0-d white-d w-100 f8"
          style={{
            resize: "none",
            height: 40,
            paddingTop: 16
          }}
          placeholder="Rating (1-5, optional)"
          onChange={this.setRating}
          onBlur={this.onBlur}
          onFocus={this.onFocus}
          spellCheck="false"
          rows={1}
          onKeyPress={e => {
            if (e.key === "Enter") {
              e.preventDefault();
              this.onClickPost();
            }
          }}
          value={this.state.rating}
        />
        <textarea
          className="pl2 bg-gray0-d white-d w-100 f8"
          style={{
            resize: "none",
            height: 40,
            paddingTop: 16
          }}
          placeholder="Pages"
          onChange={this.setPages}
          onBlur={this.onBlur}
          onFocus={this.onFocus}
          spellCheck="false"
          rows={1}
          onKeyPress={e => {
            if (e.key === "Enter") {
              e.preventDefault();
              this.onClickPost();
            }
          }}
          value={this.state.pages}
        />
        <textarea
          className="pl2 bg-gray0-d white-d w-100 f8"
          style={{
            resize: "none",
            height: 40,
            paddingTop: 16
          }}
          placeholder="Published (~YYYY.MM.DD)"
          onChange={this.setPublished}
          onBlur={this.onBlur}
          onFocus={this.onFocus}
          spellCheck="false"
          rows={1}
          onKeyPress={e => {
            if (e.key === "Enter") {
              e.preventDefault();
              this.onClickPost();
            }
          }}
          value={this.state.published}
        />
        <textarea
          className="pl2 bg-gray0-d white-d w-100 f8"
          style={{
            resize: "none",
            height: 40,
            paddingTop: 16
          }}
          placeholder="Read (~YYYY.MM.DD, optional)"
          onChange={this.setRead}
          onBlur={this.onBlur}
          onFocus={this.onFocus}
          spellCheck="false"
          rows={1}
          onKeyPress={e => {
            if (e.key === "Enter") {
              e.preventDefault();
              this.onClickPost();
            }
          }}
          value={this.state.read}
        />
      </> : null

    return (
      <div className={"relative ba br1 w-100 mb6 " + focus}>
        <textarea
          className="pl2 bg-gray0-d white-d w-100 f8"
          style={{
            resize: "none",
            height: 40,
            paddingTop: 10
          }}
          placeholder="Title"
          onChange={this.setTitle}
          onBlur={this.onBlur}
          onFocus={this.onFocus}
          spellCheck="false"
          rows={1}
          onKeyPress={e => {
            if (e.key === "Enter") {
              e.preventDefault();
              this.onClickPost();
            }
          }}
          value={this.state.title}
        />
        {additionalInput}
        <button
          className={
          "absolute bg-gray0-d f8 ml2 flex-shrink-0 " + activeClasses
          }
          disabled={this.state.disabled}
          onClick={this.onClickPost.bind(this)}
          style={{
            bottom: 12,
            right: 8
          }}>
          Post
        </button>
        <IconSpinner awaiting={this.state.disabled} classes="mt3 absolute right-0" text="Posting to collection..." />
      </div>
    );
  }
}

export default LinkSubmit;
