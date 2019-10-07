package pilot.wings;

import pilot.VNode;
import pilot.Style;
import pilot.Children;

abstract ListItem(VNode) to VNode {
  
  public inline function new(props:{
    ?style:Style,
    ?key:VNodeKey,
    ?id:String,
    #if js
      ?onClick: (e:js.html.Event)->Void,
    #end
    children:Children,
  }) {
    this = new VNode({
      name: 'li',
      key: props.key,
      style: props.style,
      props: {
        id: props.id,
        #if js
          onClick: props.onClick
        #end
      },
      children: props.children
    });
  }

}
