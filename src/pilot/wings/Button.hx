package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract Button(VNode) to VNode {
  
  public inline function new(props:{
    children:Array<VNode>,
    ?buttonType:String,
    ?style:Style,
    ?disabled:Bool,
    #if js
      ?onClick:(e:js.html.Event)->Void
    #end
  }) {
    this = new VNode({
      name: 'button',
      style: props.style,
      props: {
        type: props.buttonType,
        disabled: props.disabled == null ? false : props.disabled,
        #if js
          onClick: props.onClick
        #end
      },
      children: props.children
    });
  }

}
