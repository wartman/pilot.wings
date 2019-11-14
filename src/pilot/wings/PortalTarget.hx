package pilot.wings;

import pilot.core.Context;
import pilot.Component;

abstract PortalTargetId(String) to String {

  public inline function new(id:String) {
    this = id;
  }

} 

class PortalTarget extends Component {

  @:attribute var id:PortalTargetId;
  @:attribute(mutable = true) var children:Children = [];

  public function setPortalContent(children:Children) {
    this.children = children;
  }

  public function clearPortalContent() {
    this.children = [];
  }

  override function _pilot_update(attrs:Dynamic, context:Context) {
    super._pilot_update(attrs, context);
    context.set(id, this);
  }

  override function render() return html(<>{children}</>);

}
