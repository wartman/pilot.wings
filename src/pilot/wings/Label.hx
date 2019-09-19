package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract Label(VNode) to VNode {

  inline public function new(props:{
    target:String,
    ?style:Style,
    children:Children
  }) {
    this = new VNode({
      name: 'label',
      style: props.style,
      props: {
        'for': props.target,
      },
      children: props.children
    });
  }

}
