package pilot.wings;

import pilot.VNode;
import pilot.Style;

using pilot.VNodeTools;

enum abstract HorizontalLayoutAlignment(Style) to Style {
  var AlignRight = Style.create({
    justifyContent: 'flex-end'
  });
  var AlignLeft = Style.create({
    justifyContent: 'flex-start'
  });
  var AlignCenter = Style.create({
    justifyContent: 'center'
  });
}

abstract HorizontalLayout(VNode) to VNode {
  
  public inline function new(props:{
    ?align:HorizontalLayoutAlignment,
    child:VNode,
  }) {
    this = props.child.addStyle([
      props.align,
      Style.create({
        display: 'flex',
        flexDirection: 'row'
      })
    ]);
  }

}
