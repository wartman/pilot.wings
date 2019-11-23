package pilot.wings;

import pilot.Component;
import pilot.Style;
import pilot.Children;

enum PositionedSide {
  Top;
  Left;
  Right;
  Bottom;
}

class Positioned extends Component {

  @:attribute @:optional var style:Style;
  @:attribute var relativeTo:Component;
  @:attribute var children:Children;
  @:attribute var side:PositionedSide = Bottom;

  @:style var root = '
    position: absolute;
    visibility:hidden;
  ';

  override function render() return html(
    <div class={root.add(style)}>{children}</div>
  );

  #if js
    // todo: handle side
    @:effect(guard = getRealNode() != null) function position() {
      var el:js.html.Element = cast getRealNode();
      var parent:js.html.Element = cast relativeTo.getRealNode();
      var parentRect = parent.getBoundingClientRect();
      
      trace(el.offsetHeight / 2);

      // todo: switch to Bottom if set to Top but would go off the window, and vice-versa
      var x = switch side {
        case Top: 'top:${(js.Browser.window.scrollX + parentRect.top) - el.offsetHeight}px';
        case Bottom: 'top:${js.Browser.window.scrollX + parentRect.bottom}px';
        default: 'top:${(js.Browser.window.scrollX + parentRect.top) + (parent.offsetHeight / 2) - (el.offsetHeight / 2)}px';
      }
      var y = switch side {
        case Right: 'left:${js.Browser.window.scrollY + parentRect.right}px';
        case Left: 'left:${(js.Browser.window.scrollY + parentRect.left) - el.offsetWidth}px';
        default: 'left:${js.Browser.window.scrollY + parentRect.left}px';
      }
      el.setAttribute('style', '$x;$y;visibility:visible;');
    }
  #end

}
