package pilot.wings;

import pilot.Provider;
import pilot.Component;
import pilot.Children;
import pilot.VNode;

class PortalProvider extends Component {
  
  public static final TARGET = 'PortalTarget';
  
  @:attribute var children:Children;
  var target:PortalTarget;
  
  public function getTarget() {
    if (target == null) target = new PortalTarget({}, _pilot_context);
    return target; 
  }
                                                 
  override function render() return html(<>
    {VComponent({
      _pilot_create: (_, _) -> getTarget() 
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
    if (_pilot_context != null) _pilot_update({}, [], _pilot_context);
  }
                                         
  public function remove(id:Int) {
    portals.remove(id);
    if (_pilot_context != null) _pilot_update({}, [], _pilot_context);
  }

  override function render() {
    return html(<>
        { [ for (_ => children in portals) <>{children}</> ] }
      </>);
  }
    
}
