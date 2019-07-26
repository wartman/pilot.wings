package pilot.wings;

import pilot.VNode;
import pilot.Style;
import pilot.StatefulWidget;
import pilot.wings.util.Body;

class Popover extends StatefulWidget {

  @:prop @:optional var style:Style;
  @:prop @:optional var buttonStyle:Style;
  @:prop var target:String = PortalTarget.defaultTarget;
  @:prop var label:VNode;
  @:prop var child:VNode;
  @:state var isOpen:Bool = false;

  override function build():VNode {
    return new Box({
      style: style,
      children: [
        new Button({
          style: buttonStyle,
          children: [ label ]
        }),
        if (isOpen) new Portal({
          target: target,
          child: new Overlay({
            requestClose: () -> isOpen = false,
            child: child
          }),
          onAttach: _ -> Body.lock(),
          onDetach: () -> Body.unlock(),
        }) else null
      ]
    });
  }

}
