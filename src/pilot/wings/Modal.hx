package pilot.wings;

import pilot.VNode;
import pilot.Style;
import pilot.wings.PortalTarget;

enum abstract ModalPosition(Style) to Style {
  var PositionCentered = Style.create( {
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'center',
    alignItems: 'center',      
  });
  var PositionDefault = Style.create({
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'center',   
  });
}

abstract Modal(VNode) to VNode {

  public inline function new(props:{
    ?target:PortalTargetId,
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
          props.position
        ],
        child: new Box({
          style: [
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
