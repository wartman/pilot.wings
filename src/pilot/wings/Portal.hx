package pilot.wings;

class Portal extends Component {

  static var portalIds:Int = 0;
  
  @:attribute(consume) var state:PortalState;
  @:attribute var children:Children;
  var id:Int = portalIds++;

  @:effect
  function updateTarget() {
    state.target.set(id, children);
  }
  
  @:dispose
  function removeFromTarget() {
    state.target.remove(id);
  }
  
  override function render() return null;
  
}
