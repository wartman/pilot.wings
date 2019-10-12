package pilot.wings;

import pilot.*;

abstract Box(VNode) to VNode {
  
  public inline function new(props:{
    ?style:Style,
    children:Children,
    ?hooks:Array<Hook>,
    #if js
      ?onClick:(e:js.html.Event)->Void,
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
      hooks: props.hooks,
      children: props.children
    });
  }

}
