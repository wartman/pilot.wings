package pilot.wings;

import pilot.VNode;
import pilot.StatelessWidget;

using pilot.Differ;

abstract PortalTargetId(String) to String {

  public inline function new(id:String) {
    this = id;
  }

} 

class PortalTarget extends StatelessWidget {

  static public final defaultTarget:PortalTargetId = new PortalTargetId('overlay');
  static final portals:Map<PortalTargetId, VNode> = [];

  static public function insertInto(id:PortalTargetId, vnode:VNode) {
    js.Browser.window.requestAnimationFrame(_ -> {
      if (portals.exists(id)) {
        portals.get(id).subPatch(vnode);
      }
    });
  }

  static public function clear(id:PortalTargetId) {
    if (portals.exists(id)) {
      portals.get(id).subPatch(new VNode({
        name: 'div',
        props: {},
        children: []
      }));
    }
  }

  @:prop var id:PortalTargetId;

  override function build():VNode {
    return  new VNode({
      name: 'div',
      props: {},
      children: []
    });
  }

  override function detached() {
    portals.remove(id);
  }

  override function attached(vnode:VNode) {
    portals.set(id, vnode);
  }

}
