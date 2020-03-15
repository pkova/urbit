import React, { Component } from 'react';
import { Route, Link } from 'react-router-dom';
import { ContactItem } from '/components/lib/contact-item';
import { ShareSheet } from '/components/lib/share-sheet';
import { Sigil } from '../lib/icons/sigil';
import { cite } from '../../lib/util';

export class ContactSidebar extends Component {
  render() {
    const { props } = this;

    let group = new Set(Array.from(props.group));
    let responsiveClasses =
      props.activeDrawer === "contacts" ? "db" : "dn db-ns";

    let me = (window.ship in props.defaultContacts) ?
      props.defaultContacts[window.ship] :
      {foregroundColor: '0xff.ffff', backgroundColor: '0x0', nickname: null};

    let shareSheet =
      !(window.ship in props.contacts) ?
      ( <ShareSheet
          ship={window.ship}
          nickname={me.nickname}
          foregroundColor={me.foregroundColor}
          backgroundColor={me.backgroundColor}
          path={props.path}
          selected={props.path + "/" + window.ship === props.selectedContact}
        />
      ) : (<div></div>);
    group.delete(window.ship);

    let contactItems =
      Object.keys(props.contacts)
      .map((contact) => {
        group.delete(contact);
        let path = props.path + "/" + contact;
        let obj = props.contacts[contact];
        return (
          <ContactItem
            key={contact}
            ship={contact}
            nickname={obj.nickname}
            foregroundColor={obj.foregroundColor}
            backgroundColor={obj.backgroundColor}
            path={props.path}
            selected={path === props.selectedContact}
            share={false}
          />
        );
      });

    let groupItems =
      Array.from(group).map((member) => {
        return (
          <div
          key={member}
          className={"pl4 pt1 pb1 f9 flex justify-start content-center " +
            "bg-white bg-gray0-d"}>
            <Sigil
              ship={member}
              foregroundColor="#FFFFFF"
              backgroundColor="#000000"
              size={32}
              classes="mix-blend-diff"
              />
            <p className="f9 w-70 dib v-mid ml2 nowrap mono"
              style={{ paddingTop: 6, color: '#aaaaaa' }}
              title={member}>
              {cite(member)}
            </p>
          </div>
        );
      });

    let detailHref = `/~groups/detail${props.path}`

    return (
      <div className={`bn br-m br-l br-xl b--gray2 lh-copy h-100 flex-shrink-0
      flex-basis-100-s flex-basis-30-ns mw5-m mw5-l mw5-xl relative
      overflow-hidden ` + responsiveClasses}>
        <div className="pt3 pb5 pl3 f8 db dn-m dn-l dn-xl">
          <Link to="/~groups/">{"⟵ All Groups"}</Link>
        </div>
        <div className="overflow-auto h-100">
          <Link
            to={"/~groups/add" + props.path}
            className={((props.path.includes(window.ship))
              ? "dib"
              : "dn")}>
            <p className="f9 pl4 pt0 pt4-m pt4-l pt4-xl green2 bn">Add to Group</p>
          </Link>
          <Link to={detailHref}
            className="dib dn-m dn-l dn-xl f9 pl4 pt0 pt4-m pt4-l pt4-xl gray2 bn">Channels</Link>
          {shareSheet}
          <h2 className="f9 pt4 pr4 pb2 pl4 gray2 c-default">Members</h2>
          {contactItems}
          {groupItems}
        </div>
        </div>
    );
  }
}

