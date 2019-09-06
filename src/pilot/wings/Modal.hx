package pilot.wings;

import pilot.VNode;
import pilot.Style;
import pilot.wings.PortalTarget;

enum ModalPosition {
  PositionCentered;
  PositionDefault;
}

abstract Modal(VNode) to VNode {
  
  static final styles = Style.sheet({
    wingModalPositionCentered: {
      display: 'flex',
      flexWrap: 'wrap',
      justifyContent: 'center',
      alignItems: 'center',      
    },
    wingModalPositionDefault: {
      display: 'flex',
      flexWrap: 'wrap',
      justifyContent: 'center',      
    }
  });

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
          switch props.position {
            case PositionCentered: styles.wingModalPositionCentered;
            default: styles.wingModalPositionDefault;
          }
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
