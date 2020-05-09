import _ from 'lodash';

export class ImportUpdateReducer {
  reduce(json, state) {
    let data = _.get(json, 'books-import-update', false);
    if (data) {
      state.oauthUrl = data.oauthUrl;
    }
  }
}
