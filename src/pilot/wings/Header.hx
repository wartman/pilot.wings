package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract Header(VNode) to VNode {
  
  public inline function new(props:{
    ?style:Style,
    ?id:String,
    children:Array<VNode>
  }) {
    this = new VNode({
      name: 'header',
      style: [
        props.style
      ],
      props: {
        id: props.id
      },
      children: props.children
    });
  }

}