package pilot.wings;

import pilot.VNode;
import pilot.Style;
import pilot.wings.PortalTarget;

enum abstract ModalPosition(Style) to Style {
  var PositionCentered = Style.create('wng-overlay--modal-centered' => {
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'center',
    alignItems: 'center',
  });
  var PositionDefault = Style.create('wng-overlay--modal-default' => {
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'center',
  });
}

enum abstract ModalType(Style) to Style {
  var ModalDefault = Style.create('wng-modal--default' => {
    padding: '1.5rem'
  });
  var ModalLarge = Style.create('wng-modal--large' => {
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
  });
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
