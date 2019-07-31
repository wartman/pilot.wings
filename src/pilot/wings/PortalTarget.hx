package pilot.wings;

import pilot.VNode;
import pilot.StatelessWidget;

using pilot.Differ;

class PortalTarget extends StatelessWidget {

  static public final defaultTarget = 'overlay';
  static final portals:Map<String, VNode> = [];

  static public function insertInto(id:String, vnode:VNode) {
    js.Browser.window.requestAnimationFrame(_ -> {
      if (portals.exists(id)) {
        portals.get(id).subPatch(vnode);
      }
    });
  }

  static public function clear(id:String) {
    if (portals.exists(id)) {
      portals.get(id).subPatch(new VNode({
        name: 'div',
        props: {},
        children: []
      }));
    }
  }

  @:prop var id:String;

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
