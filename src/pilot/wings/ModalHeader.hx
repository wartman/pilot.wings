package pilot.wings;

import pilot.Component;
import pilot.VNode;
import pilot.Style;

class ModalHeader extends Component {

  @:attribute @:optional var style:Style;
  @:attribute var content:VNode;
  @:attribute var requestClose:()->Void;
  @:attribute @:optional var icon:VNode;

  override function render() return html(
    <header class={style}>
      {content}
      <button onClick={_ -> requestClose()}>
        @if (icon != null) {
          icon;
        } else {
          'x';
        }
      </button>
    </header>
  );

}
