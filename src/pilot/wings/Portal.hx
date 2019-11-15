package pilot.wings;

import pilot.Component;
import pilot.Children;
import pilot.wings.PortalProvider;

class Portal extends Component {

  static var portalIds:Int = 0;
  
  @:attribute(inject = PortalProvider.TARGET) var target:PortalTarget;
  @:attribute var children:Children;
  var id:Int = portalIds++;
  
  @:effect function updateTarget() {
    target.set(id, children);
  }
  
  @:dispose function removeFromTarget() {
    target.remove(id);
  }
  
  override function render() return html(<></>);
  
}
