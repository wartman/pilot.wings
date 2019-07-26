package pilot.wings;

import pilot.VNode;

abstract Portal(VNode) to VNode {
  
  public inline function new(props:{
    target:String,
    child:VNode,
    ?onAttach:(vn:VNode)->Void,
    ?onDetach:()->Void
  }) {
    PortalTarget.insertInto(props.target, props.child);
    this = VNode.placeholder();
    this.hooks.attach = vn -> {
      if (props.onAttach != null) props.onAttach(vn);
    }
    this.hooks.detach = () -> {
      PortalTarget.clear(props.target);
      if (props.onDetach != null) props.onDetach();
    }
  }

}
