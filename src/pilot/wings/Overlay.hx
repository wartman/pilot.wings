package pilot.wings;

import pilot.Style;
import pilot.Component;
import pilot.Children;

class Overlay extends Component {
  
  @:attribute @:optional var style:Style;
  @:attribute var requestClose:()->Void;
  @:attribute var children:Children;
  @:style var root = '
    position: fixed;
    overflow-y: scroll;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 90000;
  ';

  override function render() return html(
    <div class={root.add(style)} onClick={_ -> requestClose()}>
      {children}
    </div>
  );

}
