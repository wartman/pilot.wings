package pilot.wings;

import pilot.Component;
import pilot.RenderResult;
import pilot.Style;

class ModalHeader extends Component {

  @:attribute @:optional var style:Style;
  @:attribute var content:RenderResult;
  @:attribute var requestClose:()->Void;
  @:attribute @:optional var icon:RenderResult;

  override function render() return html(
    <header class={style}>
      {content}
      <button onClick={_ -> requestClose()}>
        <if {icon != null}>
          {icon}
        <else>
          X
        </if>
      </button>
    </header>
  );

}
