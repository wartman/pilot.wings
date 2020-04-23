package pilot.wings;

import pilot.Component;
import pilot.VNode;
import pilot.Children;
import pilot.Style;
import pilot.wings.Positioned;

class Popover extends Component {
  
  @:attribute(optional) var containerStyle:Style;
  @:attribute(optional) var popoverStyle:Style;
  @:attribute var side:PositionedSide = Bottom;
  @:attribute var label:({ isOpen:Bool })->VNode;
  @:attribute var children:Children;
  @:attribute var isOpen:Bool = false;
  #if (js && !nodejs)
    var ref:js.html.Element;
  #end

  override function render() return html(
    <div 
      class={containerStyle}
      @ref={node -> #if (js && !nodejs) ref = cast node #else null #end}
    >
      <button onClick={_ -> toggle()}>
        {label({ isOpen: isOpen })}
      </button>
      { if (isOpen) <Portal>
        <Positioned
          style={popoverStyle}
          side={side}
          getRelativeNode={#if (js && !nodejs) () -> ref #else null #end}
        >
          {children}
        </Positioned>
      </Portal> else null }
    </div>
  );

  function toggle() {
    if (isOpen) close();
    else open();
  }
  
  @:update
  function open() {
    return { isOpen: true };
  }
  
  @:update
  function close() {
    #if (js && !nodejs)
      js.Browser.window.removeEventListener('click', close); 
    #end
    return { isOpen: false };
  }
        
  #if (js && !nodejs)

    @:effect
    function closeOnClickOff() {
      if (isOpen == true) js.Browser.window.addEventListener('click', close);
    }
        
    @:dispose 
    function cleanup() {
      js.Browser.window.removeEventListener('click', close); 
    }
    
  #end

}
