package pilot.wings;

import pilot.VNode;
import pilot.Style;

using pilot.VNodeTools;

enum HorizontalLayoutAlignment {
  AlignRight;
  AlignLeft;
  AlignCenter;
}

abstract HorizontalLayout(VNode) to VNode {

  static final styles = Style.sheet({
    wingHLayoutAlignRight: {
      justifyContent: 'flex-end'
    },
    wingHLayoutAlignLeft: {
    justifyContent: 'flex-start'
    },
    wingHLayoutAlignCenter: {
      justifyContent: 'center'
    },
    wingHLayout: {
      display: 'flex',
      flexDirection: 'row'
    }
  });
  
  public inline function new(props:{
    ?align:HorizontalLayoutAlignment,
    child:VNode,
  }) {
    this = props.child.addStyle([
      switch props.align {
        case AlignRight: styles.wingHLayoutAlignRight;
        case AlignCenter: styles.wingHLayoutAlignCenter;
        default: styles.wingHLayoutAlignLeft;
      },
      styles.wingHLayout
    ]);
  }

}
