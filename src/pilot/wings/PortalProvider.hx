package pilot.wings;

import pilot.Provider;
import pilot.Component;
import pilot.Children;
import pilot.VNode;

using Lambda;

class PortalProvider extends Component {
  
  public static final TARGET = 'PortalTarget';
  
  @:attribute var children:Children;
  var target:PortalTarget;
  
  public function getTarget() {
    if (target == null) target = new PortalTarget({}, __context);
    return target; 
  }
                                                 
  override function render() return html(<>
    {VComponent({
      __create: (_, _) -> getTarget() 
    }, {})}
    <Provider id={TARGET} value={getTarget()}>
      {children}
    </Provider>
  </>);
  
}
     
class PortalTarget extends Component {

  @:attribute var portals:Map<Int, Children> = new Map();
     
  public function set(id:Int, children:Children) {
    portals.set(id, children);
    if (__context != null) __patch({});
  }
  
  public function remove(id:Int) {
    portals.remove(id);
    if (__context != null) __patch({});
  }

  override function render() {
    if (!portals.iterator().hasNext()) return null;
    return html(<>
      { [ for (_ => children in portals) <>{children}</> ] }
    </>);
  }

}
