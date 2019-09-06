package pilot.wings;

import pilot.VNode;
import pilot.Style;

abstract ModalHeader(VNode) to VNode {
  
  public inline function new(props:{
    ?icon:VNode,
    ?style:Style,
    requestClose:()->Void,
    title:String
  }) {
    this = new Layout({
      type: LayoutInline,
      child: new Header({
        style: props.style,
        children: [
          new LayoutItem({
            type: LayoutItemPrimary,
            child: new HeadingText({
              type: HeadingSecondary,
              content: props.title
            }),
          }),
          new Button({
            #if js
              onClick: _ -> props.requestClose(),
            #end
            children: [
              if (props.icon == null) 'X' else props.icon
            ]
          })
        ]
      })
    });
  }

}
