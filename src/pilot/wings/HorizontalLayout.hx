package pilot.wings;

import pilot.VNode;

using pilot.Style;

enum abstract HorizontalLayoutAlignment(Style) to Style {
  var AlignRight = Style.create('wng-h-layout--align-right' => {
    justifyContent: 'flex-end'
  });
  var AlignLeft = Style.create('wng-h-layout--align-left' => {
    justifyContent: 'flex-start'
  });
  var AlignCenter = Style.create('wng-h-layout--align-center' => {
    justifyContent: 'center'
  });
}

abstract HorizontalLayout(VNode) to VNode {
  
  public inline function new(props:{
    ?align:HorizontalLayoutAlignment,
    child:VNode,
  }) {
    this = props.child.applyStyle([
      props.align,
      Style.create('wng-h-layout' => {
        display: 'flex',
        flexDirection: 'row'
      })
    ]);
  }

}
