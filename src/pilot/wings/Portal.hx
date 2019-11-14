package pilot.wings;

import pilot.Component;
import pilot.Children;
import pilot.wings.PortalTarget;

class Portal extends Component {
  
  @:attribute var id:PortalTargetId;
  // Note: never pass the `portalTarget` in manually: only provide
  //       the `id` and allow it to be injected.
  @:attribute(inject = id) var portalTarget:PortalTarget;
  @:attribute var children:Children;

  @:effect function mount() {
    portalTarget.setPortalContent(children);
  }

  @:dispose function unmount() {
    portalTarget.clearPortalContent();
  }

  override function render() return html(<></>);

}
