import React, { Component } from 'react';
import classnames from 'classnames';
import { HeaderBar } from './lib/header-bar';
import { ChannelsSidebar } from './lib/channel-sidebar';


export const Skeleton = (props) => {

  let rightPanelHide = props.rightPanelHide
                     ? "dn-s" : "";

  let popout = !!props.popout
             ? props.popout : false;

  let popoutWindow = (popout)
                   ? "" : "h-100-m-40-ns ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl"

  let popoutBorder = (popout)
                   ? "" : "ba-m ba-l ba-xl b--gray4 b--gray1-d br1"

  let booksInvites = ('/books' in props.invites)
                  ? props.invites['/books'] : {};

  return (
    <div className={"absolute h-100 w-100 " + popoutWindow}>
      <HeaderBar
        invites={props.invites}
        associations={props.associations}
      />
      <div className={`cf w-100 h-100 flex ` + popoutBorder}>
        <ChannelsSidebar
          active={props.active}
          popout={popout}
          associations={props.associations}
          invites={booksInvites}
          groups={props.groups}
          selected={props.selected}
          selectedGroups={props.selectedGroups}
          sidebarShown={props.sidebarShown}
          links={props.links}
          listening={props.listening}/>
        <div className={"h-100 w-100 flex-auto relative " + rightPanelHide} style={{
          flexGrow: 1,
        }}>
          {props.children}
        </div>
      </div>
    </div>
  );
}
