package pilot.wings;

import pilot.Component;
import pilot.Style;
import pilot.Children;
#if (js && !nodejs)
  import js.html.Element;
#end

enum PositionedSide {
  Top;
  Left;
  Right;
  Bottom;
}

class Positioned extends Component {

  @:attribute(optional) var style:Style;
  @:attribute var children:Children;
  @:attribute var side:PositionedSide = Bottom;
  #if (js && !nodejs)
    @:attribute var getRelativeNode:()->Element;
    var ref:Element;
  #else
    @:attribute var getRelativeNode:()->Dynamic;
  #end

  override function render() return html(
    <div class={ css('
      position: absolute;
      visibility:hidden;
    ').add(style) } @ref={node -> #if (js && !nodejs) ref = cast node #else null #end }>{children}</div>
  );

  #if (js && !nodejs)
    @:effect 
    function position() {
      if (getRelativeNode == null || getRelativeNode() == null) {
        return;
      }

      var el = ref;
      var parent = getRelativeNode();
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
