package pilot.wings;

import pilot.Style;
import pilot.VNode;

using pilot.VNodeTools;

enum abstract LayoutItemType(Style) to Style {
  var LayoutItemPrimary = Style.create({
    flex: 2
  });
  var LayoutItemLast = Style.create({
    flex: 1,
    alignSelf: 'flex-end'
  });
}

abstract LayoutItem(VNode) to VNode {

  public function new(props:{
    type:LayoutItemType,
    child:VNode
  }) {
    this = props.child.addStyle(props.type);
  }

}