package pilot.wings;

import pilot.VNode;
import pilot.Style;

using pilot.VNodeTools;

enum abstract VerticalLayoutAlignment(Style) to Style {
  var AlignTop = Style.create({
    alignItems: 'flex-top'
  });
  var AlignBottom = Style.create({
    alignItems: 'flex-end'
  });
  var AlignCenter = Style.create({
    alignItems: 'center'
  });
}

abstract VerticalLayout(VNode) to VNode {

  public inline function new(props:{
    ?align:VerticalLayoutAlignment,
    child:VNode,
  }) {
    this = props.child.addStyle([
      props.align,
      Style.create({
        display: 'flex',
        flexDirection: 'column'
      })
    ]);
  }

}
