package pilot.wings;

import pilot.VNode;
using pilot.Style;

enum abstract VerticalLayoutAlignment(Style) to Style {
  var AlignTop = Style.create('wng-v-layout--align-top' => {
    alignItems: 'flex-start',
  });
  var AlignBottom = Style.create('wng-v-layout--align-bottom' => {
    alignItems: 'flex-end',
  });
  var AlignCenter = Style.create('wng-v-layout--align-center' => {
    alignItems: 'center',
  });
}

abstract VerticalLayout(VNode) to VNode {
  
  public inline function new(props:{
    ?align:VerticalLayoutAlignment,
    child:VNode,
  }) {
    this = props.child.applyStyle([
      props.align,
      Style.create('wng-v-layout' => {
        display: 'flex',
        flexDirection: 'column'
      })
    ]);
  }

}
