package pilot.wings;

import pilot.VNode;
import pilot.Style;

using pilot.VNodeTools;

enum VerticalLayoutAlignment {
  AlignTop;
  AlignBottom;
  AlignCenter;
}

abstract VerticalLayout(VNode) to VNode {
  
  static final styles = Style.sheet({
    wingVLayoutAlignTop: {
      alignItems: 'flex-top'
    },
    wingVLayoutAlignBottom: {
      alignItems: 'flex-end'
    },
    wingVLayoutAlignCenter: {
      alignItems: 'center'
    },
    wingVLayout: {
      display: 'flex',
      flexDirection: 'column'
    }
  });

  public inline function new(props:{
    ?align:VerticalLayoutAlignment,
    child:VNode,
  }) {
    this = props.child.addStyle([
      switch props.align {
        case AlignBottom: styles.wingVLayoutAlignBottom;
        case AlignCenter: styles.wingVLayoutAlignCenter;
        default: styles.wingVLayoutAlignTop;
      },
      styles.wingVLayout
    ]);
  }

}
