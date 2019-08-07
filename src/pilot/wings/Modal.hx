package pilot.wings;

import pilot.VNode;
import pilot.Style;
import pilot.wings.PortalTarget;

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

enum abstract ModalType(Style) to Style {
  var ModalDefault = Style.create({
    padding: '1.5rem'
  }, 'wng-modal--default');
  var ModalLarge = Style.create({
    padding: '1.5rem',
    media: {
      query: { type: 'screen' } & { maxWidth: '700px' },
      style: {
        width: '50%',
        minWidth: '700px',
      }
    } + {
      query: { type: 'screen'} & { minWidth: '700px' },
      style: {
        width: 'auto',
      }
    }
  }, 'wng-modal--large');
}

abstract Modal(VNode) to VNode {
  
  public inline function new(props:{
    ?target:PortalTargetId,
    ?overlayStyle:Style,
    ?modalStyle:Style,
    ?header:VNode,
    ?position:ModalPosition,
    ?type:ModalType,
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
            props.type == null
              ? ModalDefault
              : props.type,
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
