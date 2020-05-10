package pilot.wings;

using Lambda;

class PortalTarget extends Component {

  @:attribute var portals:Array<{ id:Int, children:Children }> = [];

  override function render() {
    if (portals.length == 0) return null;
    return html(<>
      { [ for (portal in portals) <>{portal.children}</> ] }
    </>);
  }

  @:update
  public function set(id:Int, children:Children) {
    if (portals.exists(p -> p.id == id)) {
      return {};
    }
    return {
      portals: portals.concat([ { id: id, children: children } ])
    };
  }

  @:update
  public function remove(id:Int) {
    return {
      portals: portals.filter(p -> p.id != id)
    };
  }

}
