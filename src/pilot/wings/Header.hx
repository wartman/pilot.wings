package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract Header(VNode) to VNode {
  
  public inline function new(props:{
    ?style:Style,
    children:Array<VNode>
  }) {
    this = new VNode({
      name: 'header',
      style: [
        props.style
      ],
      props: {},
      children: props.children
    });
  }

}