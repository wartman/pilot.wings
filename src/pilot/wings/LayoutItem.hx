package pilot.wings;

import pilot.Style;
import pilot.VNode;

enum abstract LayoutItemType(Style) to Style {
  
  var LayoutItemPrimary = Style.create('wng-layout-item--primary' => {
    flex: 2
  });

  var LayoutItemLast = Style.create('wng-layout-item--last' => {
    flex: 1,
    alignSelf: 'flex-end'
  });

}

abstract LayoutItem(VNode) to VNode {
  
  public function new(props:{
    type:LayoutItemType,
    child:VNode
  }) {
    this = Style.applyStyle(props.child, props.type);
  }

}