package pilot.wings;

import pilot.VNode;
import pilot.Placeholder;
import pilot.wings.PortalTarget;

abstract Portal(VNode) to VNode {
  
  public inline function new(props:{
    target:PortalTargetId,
    child:VNode,
    ?onAttach:(vn:VNode)->Void,
    ?onDetach:()->Void
  }) {
    PortalTarget.insertInto(props.target, props.child);
    this = new Placeholder();
    #if js
      this.hooks.attach = vn -> {
        if (props.onAttach != null) props.onAttach(vn);
      }
      this.hooks.detach = () -> {
        PortalTarget.clear(props.target);
        if (props.onDetach != null) props.onDetach();
      }
    #end
  }

}
