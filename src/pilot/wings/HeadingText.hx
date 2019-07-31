package pilot.wings;

import pilot.Style;
import pilot.VNode;

enum abstract HeadingTextType(String) to String {
  var HeadingMain = 'h1';
  var HeadingSecondary = 'h2';
  var HeadingTerciary = 'h3';
}

abstract HeadingText(VNode) to VNode {
  
  public inline function new(props:{
    type:HeadingTextType,
    content:String,
    ?style:Style,
  }) {
    this = new VNode({
      name: props.type,
      style: [
        props.style
      ],
      props: {},
      children: [ props.content ]
    });
  }

}