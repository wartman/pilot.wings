package pilot.wings;

class PortalProvider extends Component {
  
  @:attribute var children:Children;

  override function render() {
    var target = new PortalTarget({}, __context);
    return html(<>
      {target}
      <PortalState target={target}>
        {children}
      </PortalState>
    </>);
  }

}
