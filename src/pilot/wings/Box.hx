package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract Box(VNode) to VNode {
  
  public inline function new(props:{
    ?style:Style,
    children:Array<VNode>,
    #if js
      ?onClick:(e:js.html.Event)->Void,
      ?onAttach:(node:VNode)->Void,
      ?onDetach:()->Void,
    #end
  }) {
    this = new VNode({
      name: 'div',
      style: props.style,
      props: {
        #if js
          onClick: props.onClick,
        #end
      },
      #if js
        hooks: {
          attach: props.onAttach,
          detach: props.onDetach,
        },
      #end
      children: props.children
    });
  }

}
