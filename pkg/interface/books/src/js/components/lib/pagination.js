
import React, { Component } from 'react';
import { Route, Link } from 'react-router-dom';
import { makeRoutePath } from '../../lib/util';

export const Pagination = (props) => {

  let prevPage = (Number(props.page) - 1);
  let nextPage = (Number(props.page) + 1);

  let prevDisplay = ((props.currentPage > 0))
                  ? "dib absolute left-0"
                  : "dn";

  let nextDisplay = ((props.currentPage + 1) < props.totalPages)
                  ? "dib absolute right-0"
                  : "dn";

  return (
    <div className="w-100 inter relative pv6">
      <div className={prevDisplay + " inter f8"}>
        <Link to={makeRoutePath(props.resourcePath, props.popout, prevPage)}>
    &#60;- Previous Page
        </Link>
      </div>
      <div className={nextDisplay + " inter f8"}>
        <Link to={makeRoutePath(props.resourcePath, props.popout, nextPage)}>
          Next Page ->
        </Link>
      </div>
    </div>
  )
}
