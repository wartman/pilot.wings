package pilot.wings;

import pilot.Style;
import pilot.VNode;

enum abstract LayoutItemType(Style) to Style {
  
  var LayoutItemPrimary = Style.create({
    flex: 2
  }, 'wng-layout-item--primary');

  var LayoutItemLast = Style.create({
    flex: 1,
    alignSelf: 'flex-end'
  }, 'wng-layout-item--last');

}

abstract LayoutItem(VNode) to VNode {
  
  public function new(props:{
    type:LayoutItemType,
    child:VNode
  }) {
    this = Style.applyStyle(props.child, props.type);
  }

}