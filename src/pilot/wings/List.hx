package pilot.wings;

import pilot.VNode;
import pilot.Style;
import pilot.Children;

abstract List(VNode) to VNode {
  
  public inline function new(props:{
    ?style:Style,
    children:Children
  }) {
    this = new VNode({
      name: 'ul',
      style: [
        Style.create('wng-list' => {
          listStyle: 'none',
          margin: 0,
          padding: 0,
        }),
        props.style,
      ],
      props: {},
      children: props.children
    });
  }

}
