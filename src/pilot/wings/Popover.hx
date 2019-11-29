package pilot.wings;

import pilot.Component;
import pilot.VNode;
import pilot.Children;
import pilot.Style;
import pilot.wings.Positioned;

class Popover extends Component {
  
  @:attribute @:optional var containerStyle:Style;
  @:attribute @:optional var popoverStyle:Style;
  @:attribute var side:PositionedSide = Bottom;
  @:attribute var label:({ isOpen:Bool })->VNode;
  @:attribute var children:Children;
  @:attribute(mutable = true) var isOpen:Bool = false;
  var ref:Node;

  override function render() return html(
    <div @ref={node -> ref = node} class={containerStyle}>
      <button onClick={_ -> toggle()}>
        {label({ isOpen: isOpen })}
      </button>
      <if {isOpen}>
        <Portal>
          <Positioned
            style={popoverStyle}
            side={side}
            // this is a bit iffy, as `ref` will not be available
            // right away. This will only work on the second render,
            // which -- luckily -- should be the typical behavior.
            // Still, huge potential for bugs. Perhaps rethink how `@ref`
            // works!
            relativeTo={ref}
          >
            {children}
          </Positioned>
        </Portal>
      </if>
    </div>
  );

  function toggle() {
    if (isOpen) close();
    else open();
  }
  
  function open() {
    isOpen = true;
  }
  
  function close() {
    isOpen = false;
    #if js
      js.Browser.window.removeEventListener('click', close); 
    #end
  }
        
  #if js
    @:effect(guard = isOpen == true) function closeOnClickOff() {  
      js.Browser.window.addEventListener('click', close);
    }
        
    @:dispose function cleanup() {
      js.Browser.window.removeEventListener('click', close); 
    }
  #end

}
