package pilot.wings;

import pilot.VNode;
import pilot.Style;

using pilot.VNodeTools;

enum LayoutType {
  LayoutInline;
  LayoutCentered;
}

abstract Layout(VNode) to VNode {
  
  static final styles = Style.sheet({
    wingLayoutInline: {
      display: 'flex',
      flexDirection: 'row'
    },
    wingLayoutCentered: {
      display: 'flex',
      justifyContent: 'center'
    }
  });

  public inline function new(props:{
    type:LayoutType,
    child:VNode
  }) {
    this = props.child.addStyle(switch props.type {
      case LayoutInline: styles.wingLayoutInline;
      case LayoutCentered: styles.wingLayoutCentered;
    });
  }

}
