package pilot.wings;

import pilot.Component;
import pilot.VNode;
import pilot.Children;
import pilot.Style;
import pilot.dom.Element;
import pilot.wings.Positioned;

class Popover extends Component {
  
  @:attribute @:optional var containerStyle:Style;
  @:attribute @:optional var popoverStyle:Style;
  @:attribute var side:PositionedSide = Bottom;
  @:attribute var label:({ isOpen:Bool })->VNode;
  @:attribute var children:Children;
  @:attribute var isOpen:Bool = false;
  var ref:Element;

  override function render() return html(
    <div @ref={node -> ref = cast node} class={containerStyle}>
      <button onClick={_ -> toggle()}>
        {label({ isOpen: isOpen })}
      </button>
      { if (isOpen) <Portal>
        <Positioned
          style={popoverStyle}
          side={side}
          getRelativeNode={() -> ref}
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
    return {
      isOpen: true
    };
  }
  
  @:update
  function close() {
    #if js
      js.Browser.window.removeEventListener('click', close); 
    #end
    return {
      isOpen: false
    };
  }
        
  #if js

    @:effect(guard = isOpen == true) 
    function closeOnClickOff() {
      js.Browser.window.addEventListener('click', close);
    }
        
    @:dispose 
    function cleanup() {
      js.Browser.window.removeEventListener('click', close); 
    }
    
  #end

}
