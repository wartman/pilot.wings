package pilot.wings;

import pilot.VNode;
import pilot.Style;

enum abstract LayoutType(Style) to Style {
  var LayoutInline = Style.create({
    display: 'flex',
    flexDirection: 'row'
  });
  var LayoutCentered = Style.create({
    display: 'flex',
    justifyContent: 'center'
  });
}

abstract Layout(VNode) to VNode {

  public inline function new(props:{
    type:LayoutType,
    child:VNode
  }) {
    this = props.child.addStyle(props.type);
  }

}
