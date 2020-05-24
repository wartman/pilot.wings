package pilot.wings;

#if js
  import pilot.wings.util.Body;
  
  using pilot.Helpers;
#end

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
  
  @:attribute var requestClose:()->Void;
  @:attribute var children:Children;
  @:attribute var position:ModalPosition = PositionDefault;
  @:attribute var closeOnEsc:Bool = true;
  @:attribute(optional) var overlayStyle:Style;
  @:attribute(optional) var modalStyle:Style;
  @:attribute(optional) var header:VNode;

  override function render() return html(
    <Portal>
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
  
  #if js

    function doCloseOnEsc(e:js.html.KeyboardEvent) {
      if (e.key == 'Escape') requestClose();
    }

    @:init 
    inline function setup() {
      Body.lock();
      if (closeOnEsc) js.Browser.window.addEventListener('keydown', doCloseOnEsc);
    }

    @:dispose 
    inline function cleanup() {
      Body.unlock.later();
      js.Browser.window.removeEventListener('keydown', doCloseOnEsc);
    }

  #end

}
