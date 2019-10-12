package pilot.wings;

import pilot.*;

abstract PortalTargetId(String) to String {

  public inline function new(id:String) {
    this = id;
  }

}

class PortalTarget implements Renderable {
  
  static public final defaultTarget:PortalTargetId = new PortalTargetId('overlay');

  final id:PortalTargetId;
  var context:Context;
  var vNode:VNode;

  public function new(props:{
    id:PortalTargetId
  }) {
    id = props.id;
  }

  function _pilot_getVNode() {
    return vNode;
  }

  function _pilot_getId():String {
    return id;
  }

  function build(?child:VNode):VNode {
    return new VNode({
      name: 'div',
      props: { id: id },
      children: child != null ? [ child ] : []
    });
  }

  public function set(child:VNode) {
    #if js
      if (context != null) {
        context.differ.subPatch(vNode, build(child));
      }
    #end
  }

  public function clear() {
    #if js
      if (context != null) {
        context.differ.subPatch(vNode, build());
      }
    #end
  }

  public function render(context:Context):VNode {
    this.context = context;
    context.data.set(_pilot_getId(), this);
    vNode = build();
    return vNode;
  }

  public function dispose() {
    context = null;
    vNode = null;
  }

}
