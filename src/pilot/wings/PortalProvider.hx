package pilot.wings;

import pilot.Component;
import pilot.Children;
import pilot.VNode;
import pilot.Provider;

class PortalProvider extends Component {
  
  public static final TARGET = 'PortalTarget';
  
  @:attribute var children:Children;
  var target:PortalTarget;
  
  public function getTarget<Node>():Wire<Node, {}> {
    if (target == null) target = new PortalTarget({}, __context);
    return cast target; 
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
   
  @:update
  public function set(id:Int, children:Children) {
    portals.set(id, children);
    return {
      portals: portals
    };
  }
  
  @:update
  public function remove(id:Int) {
    portals.remove(id);
    return {
      portals: portals
    };
  }

  override function render() {
    if (!portals.iterator().hasNext()) return null;
    return html(<>
      { [ for (_ => children in portals) <>{children}</> ] }
    </>);
  }

}
