package pilot.wings;

import pilot.Style;
import pilot.VNode;

using pilot.VNodeTools;

enum LayoutItemType {
  LayoutItemPrimary;
  LayoutItemLast;
}

abstract LayoutItem(VNode) to VNode {
  
  static final styles = Style.sheet({
    wingLayoutItemPrimary: {
      flex: 2
    },
    wingLayoutItemLast: {
      flex: 1,
      alignSelf: 'flex-end'
    }
  });

  public function new(props:{
    type:LayoutItemType,
    child:VNode
  }) {
    this = props.child.addStyle(switch props.type {
      case LayoutItemPrimary: styles.wingLayoutItemPrimary;
      case LayoutItemLast: styles.wingLayoutItemLast;
    });
  }

}