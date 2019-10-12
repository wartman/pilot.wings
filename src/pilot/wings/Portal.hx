package pilot.wings;

import pilot.*;
import pilot.wings.PortalTarget;

class Portal implements Renderable {
  
  final id:PortalTargetId;
  final child:VNode;
  var vNode:VNode;

  public function new(props:{
    target:PortalTargetId,
    child:VNode
  }) {
    id = props.target;
    child = props.child;
  }

  public function _pilot_getId() {
    return id + '_portal';
  }

  public function _pilot_getVNode() {
    return vNode;
  }

  public function render(context:Context) {
    var target:PortalTarget = context.data.get(id);
    if (target == null) {
      throw 'No target found for ${id}';
    }
    Util.nextFrame(() -> target.set(child));
    vNode = VNode.create({
      type: VNodePlaceholder(_pilot_getId()),
      hooks: [
        // Do we need an 'after' hook too?
        HookDestroy(_ -> target.clear())
      ]
    });
    return vNode;
  }

  public function dispose() {
    vNode = null;
  }

}
