package pilot.wings;

import pilot.VNode;
import pilot.Style;

enum abstract ModalPosition(Style) to Style {
  var PositionCentered = Style.create({
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  }, 'wng-overlay--modal-centered');
  var PositionDefault = Style.create({
    display: 'flex',
    justifyContent: 'center',
    padding: '3rem 0',
    overflowY: 'scroll',
  }, 'wng-overlay--modal-default');
}

// enum abstract ModalType(Style) to Style {
// }

abstract Modal(VNode) to VNode {
  
  public inline function new(props:{
    ?target:String,
    ?overlayStyle:Style,
    ?modalStyle:Style,
    ?header:VNode,
    ?position:ModalPosition,
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
          props.position == null 
            ? PositionDefault
            : props.position
        ],
        child: new Box({
          style: [
            Style.create({
              backgroundColor: '#fff',
              padding: '1.5rem',
            }, 'wng-modal'),
            props.modalStyle,
          ],
          #if js
            onClick: e -> e.stopPropagation(),
          #end
          children: [
            props.header,
            props.child
          ]
        })
      })
    });
  }

}
