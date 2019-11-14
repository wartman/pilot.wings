package pilot.wings;

import pilot.Style;
import pilot.Component;
import pilot.PureComponent;
import pilot.Children;
import pilot.wings.PortalTarget;

@:forward
enum abstract ModalPosition(Style) to Style {
  
  var PositionCentered = Pilot.css('
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
  ');

  var PositionDefault = Pilot.css('
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  ');

}

class Modal extends Component {
  
  @:attribute var target:PortalTargetId;
  @:attribute var requestClose:()->Void;
  @:attribute var children:Children;
  @:attribute var position:ModalPosition = PositionDefault;
  @:attribute @:optional var overlayStyle:Style;
  @:attribute @:optional var modalStyle:Style;
  @:attribute @:optional var header:PureComponent;

  override function render() return html(
    <Portal id={target}>
      <Overlay 
        style={position.add(overlayStyle)}
        requestClose={requestClose}
      >
        <div class={modalStyle} onClick={e -> e.stopPropagation()}>
          {header}
          {children}
        </div>
      </Overlay>
    </Portal>
  );
  
}
