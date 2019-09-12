package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract Overlay(VNode) to VNode {
  
  public inline function new(props:{
    ?style:Style,
    requestClose:()->Void,
    child:VNode
  }) {
    this = new Box({
      style: [
        Style.create({ 
          position: 'fixed',
          overflowY: 'scroll',
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          zIndex: 9000,
        }),
        props.style
      ],
      #if js
        onClick: _ -> props.requestClose(),
      #end
      children: [ props.child ]
    });
  }

}
