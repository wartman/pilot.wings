package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract Modal(VNode) to VNode {
  
  public inline function new(props:{
    ?target:String,
    ?overlayStyle:Style,
    ?modalStyle:Style,
    title:String,
    requestClose:()->Void,
    child:VNode
  }) {
    this = new Portal({
      target: props.target == null 
        ? PortalTarget.defaultTarget 
        : props.target,
      child: new Overlay({
        requestClose: props.requestClose,
        style: [
          props.overlayStyle,
          Style.create({
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
          }, 'wng-overlay--modal'),
        ],
        child: new Box({
          style: [
            Style.create({
              backgroundColor: '#fff',
              padding: '1.5rem',
            }, 'wng-modal-wrapper'),
            props.modalStyle,
          ],
          #if js
            onClick: e -> e.stopPropagation(),
          #end
          children: [
            // todo: header etc
            props.child
          ]
        })
      })
    });
  }

}
