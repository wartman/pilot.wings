package pilot.wings;

import pilot.Component;
import pilot.Style;
import pilot.Children;
import pilot.Node;

enum PositionedSide {
  Top;
  Left;
  Right;
  Bottom;
}

class Positioned extends Component {

  @:attribute @:optional var style:Style;
  @:attribute var relativeTo:Node;
  @:attribute var children:Children;
  @:attribute var side:PositionedSide = Bottom;
  var ref:Node;

  @:style var root = '
    position: absolute;
    visibility:hidden;
  ';

  override function render() return html(
    <div class={root.add(style)} @ref={node -> ref = node}>{children}</div>
  );

  #if js
    @:effect(guard = relativeTo != null) function position() {
      var el = ref.toElement();
      var parent = relativeTo.toElement();
      var parentRect = parent.getBoundingClientRect();

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
